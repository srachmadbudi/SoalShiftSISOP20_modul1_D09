#!/bin/bash

#number1a
onea=$(awk -F "\t" '
{groupby[$13]+=$21}
END {
        for(reg in groupby) {
                print groupby[reg], reg
        }
}
' Sample-Superstore.tsv | sort -g | head -2 | tail -1)

region=$(cut -d ' ' -f2 <<<"$onea")
echo -e "1.a) Region dengan profit terkecil adalah $region\n"


#______________________________________________________________________
#number1b
oneb=$(awk -F "\t" -v reg="$region" '
$13 ~ reg {
        groupby[$11]+=$21
}
END {
        for( state in groupby ) {
                print groupby[state], state
        }
}
' Sample-Superstore.tsv | sort -g | head -2)

state1=$(cut -d $'\n' -f1 <<<"$oneb")
state1=$(cut -d ' ' -f2 <<<"$state1")
state2=$(cut -d $'\n' -f2 <<<"$oneb")
state2=$(cut -d ' ' -f2 <<<"$state2")
echo -e "1.b) State dengan profit terkecil adalah $state1 dan $state2\n"


#_______________________________________________________________________
#number1c
onec=$(awk -F "\t" -v st1="$state1" -v st2="$state2" '
$11 ~ st1 || $11 ~ st2 {
        groupby[$17]+=$21
}
END {
        for( product in groupby ) {
                print groupby[product], product
        }
}
' Sample-Superstore.tsv | sort -g | head -10)

p1=$(cut -d $'\n' -f1 <<<"$onec")
p1=$(cut --complement -d ' ' -f1 <<<"$p1")
p2=$(cut -d $'\n' -f2 <<<"$onec")
p2=$(cut --complement -d ' ' -f1 <<<"$p2")
p3=$(cut -d $'\n' -f3 <<<"$onec")
p3=$(cut --complement -d ' ' -f1 <<<"$p3")
p4=$(cut -d $'\n' -f4 <<<"$onec")
p4=$(cut --complement -d ' ' -f1 <<<"$p4")
p5=$(cut -d $'\n' -f5 <<<"$onec")
p5=$(cut --complement -d ' ' -f1 <<<"$p5")
p6=$(cut -d $'\n' -f6 <<<"$onec")
p6=$(cut --complement -d ' ' -f1 <<<"$p6")
p7=$(cut -d $'\n' -f7 <<<"$onec")
p7=$(cut --complement -d ' ' -f1 <<<"$p7")
p8=$(cut -d $'\n' -f8 <<<"$onec")
p8=$(cut --complement -d ' ' -f1 <<<"$p8")
p9=$(cut -d $'\n' -f9 <<<"$onec")
p9=$(cut --complement -d ' ' -f1 <<<"$p9")
p10=$(cut -d $'\n' -f10 <<<"$onec")
p10=$(cut --complement -d ' ' -f1 <<<"$p10")
echo -e  "1.c) Produk yang memiliki profit paling sedikit berdasarkan negara bagian
     $state1 dan $state2 adalah sebagai berikut:\n
 -$p1\n -$p2\n -$p3\n -$p4\n -$p5\n -$p6\n -$p7\n -$p8\n -$p9\n -$p10\n"
