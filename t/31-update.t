use Test;
use Red;

model Bla {
    has $!id is serial;
    has Int $.num1 is rw is column;
    has Int $.num2 is rw is column;
}

my $*RED-DEBUG = $_ with %*ENV<RED_DEBUG>;
my $*RED-DB    = database "SQLite", |(:database($_) with %*ENV<RED_DATABASE>);

Bla.^create-table;

Bla.^create: :41num1, :13num2;

Bla.^all.map({ .num1 += 1 }).save;
is Bla.^all.head.num1, 42;

Bla.^all.map({ .num1 -= 29 }).save;
is Bla.^all.head.num1, 13;

Bla.^all.grep(*.num2 == 13).map({ .num1 /= .num2 }).save;
is Bla.^all.head.num1, 1;

Bla.^all.map({ .num1 *= .num2; .num2 = 42 }).save;
is Bla.^all.head.num1, 13;
is Bla.^all.head.num2, 42;

done-testing;
