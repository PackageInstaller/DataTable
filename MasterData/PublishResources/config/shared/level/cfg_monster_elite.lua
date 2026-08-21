local key = {
  ID = 1,
  Name = 2,
  Desc = 3,
  Buff = 4,
  EffectID = 5
}
local common = {
  "30861,30871",
  "30862,30872",
  "30863,30873",
  "str_elite_name_101103",
  "str_elite_desc_101103",
  "str_elite_name_1027",
  "str_elite_name_1040",
  "str_elite_desc_1040",
  "str_elite_name_108801",
  "str_elite_desc_108801",
  "str_elite_name_112401",
  "str_elite_desc_112401",
  "3086,3087",
  "str_elite_name_5494001",
  "str_elite_desc_5494001",
  "str_elite_name_5494002",
  "str_elite_desc_5494002",
  "str_elite_name_5494003",
  "str_elite_desc_5494003",
  "str_elite_name_200101",
  "str_elite_desc_200101",
  "str_elite_name_804001",
  "str_elite_desc_804001",
  "str_elite_name_804006",
  "str_elite_desc_804006",
  {10150201},
  {104001}
}
local config = {
  [100101] = {
    100101,
    "str_elite_name_100101",
    "str_elite_desc_100101",
    {
      100001,
      10010101,
      10010102
    },
    common[1]
  },
  [100102] = {
    100102,
    "str_elite_name_100102",
    "str_elite_desc_100102",
    {
      100001,
      10010201,
      10010202
    },
    common[1]
  },
  [100103] = {
    100103,
    "str_elite_name_100103",
    "str_elite_desc_100103",
    {
      100001,
      10010301,
      10010302
    },
    common[1]
  },
  [100104] = {
    100104,
    "str_elite_name_100104",
    "str_elite_desc_100104",
    {
      100001,
      10010401,
      10010402
    },
    common[1]
  },
  [1002] = {
    1002,
    "str_elite_name_1002",
    "str_elite_desc_1002",
    {
      100001,
      100201,
      100203
    },
    common[1]
  },
  [100301] = {
    100301,
    "str_elite_name_100301",
    "str_elite_desc_100301",
    {10030101}
  },
  [100302] = {
    100302,
    "str_elite_name_100302",
    "str_elite_desc_100302",
    {10030201}
  },
  [100303] = {
    100303,
    "str_elite_name_100303",
    "str_elite_desc_100303",
    {10030301}
  },
  [100304] = {
    100304,
    "str_elite_name_100304",
    "str_elite_desc_100304",
    {10030401}
  },
  [100305] = {
    100305,
    "str_elite_name_100305",
    "str_elite_desc_100305",
    {10030501}
  },
  [100401] = {
    100401,
    "str_elite_name_100401",
    "str_elite_desc_100401",
    {100001, 10040101}
  },
  [100402] = {
    100402,
    "str_elite_name_100402",
    "str_elite_desc_100402",
    {100001, 10040201}
  },
  [100403] = {
    100403,
    "str_elite_name_100403",
    "str_elite_desc_100403",
    {100001, 10040301}
  },
  [100404] = {
    100404,
    "str_elite_name_100404",
    "str_elite_desc_100404",
    {100001, 10040401}
  },
  [100405] = {
    100405,
    "str_elite_name_100405",
    "str_elite_desc_100405",
    {100001, 10040501}
  },
  [1005] = {
    1005,
    "str_elite_name_1005",
    "str_elite_desc_1005",
    {100001, 100501}
  },
  [1006] = {
    1006,
    "str_elite_name_1006",
    "str_elite_desc_1006",
    {100001, 100601}
  },
  [100701] = {
    100701,
    "str_elite_name_100701",
    "str_elite_desc_100701",
    {10070101},
    common[2]
  },
  [100702] = {
    100702,
    "str_elite_name_100702",
    "str_elite_desc_100702",
    {10070201},
    common[2]
  },
  [100703] = {
    100703,
    "str_elite_name_100703",
    "str_elite_desc_100703",
    {10070301},
    common[2]
  },
  [100704] = {
    100704,
    "str_elite_name_100704",
    "str_elite_desc_100704",
    {10070401},
    common[2]
  },
  [100801] = {
    100801,
    "str_elite_name_100801",
    "str_elite_desc_100801",
    {100001, 10080101},
    common[3]
  },
  [100802] = {
    100802,
    "str_elite_name_100802",
    "str_elite_desc_100802",
    {100001, 10080201},
    common[3]
  },
  [100803] = {
    100803,
    "str_elite_name_100803",
    "str_elite_desc_100803",
    {100001, 10080301},
    common[3]
  },
  [100804] = {
    100804,
    "str_elite_name_100804",
    "str_elite_desc_100804",
    {100001, 10080401},
    common[3]
  },
  [100901] = {
    100901,
    "str_elite_name_100901",
    "str_elite_desc_100901",
    {10090101}
  },
  [100902] = {
    100902,
    "str_elite_name_100902",
    "str_elite_desc_100902",
    {10090201}
  },
  [1010] = {
    1010,
    "str_elite_name_1010",
    "str_elite_desc_1010",
    {101001}
  },
  [101101] = {
    101101,
    "str_elite_name_101101",
    "str_elite_desc_101101",
    {10110101}
  },
  [101102] = {
    101102,
    "str_elite_name_101102",
    "str_elite_desc_101102",
    {10110201}
  },
  [101103] = {
    101103,
    common[4],
    common[5],
    {10110301}
  },
  [101104] = {
    101104,
    common[4],
    common[5]
  },
  [1012] = {
    1012,
    "str_elite_name_1012",
    "str_elite_desc_1012",
    {101201, 101202}
  },
  [1013] = {
    1013,
    "str_elite_name_1013",
    "str_elite_desc_1013",
    {100001, 101301}
  },
  [1014] = {
    1014,
    "str_elite_name_1014",
    "str_elite_desc_1014",
    {101401},
    common[2]
  },
  [101501] = {
    101501,
    "str_elite_name_101501",
    "str_elite_desc_101501",
    {10150101}
  },
  [101502] = {
    101502,
    "str_elite_name_101502",
    "str_elite_desc_101502",
    common[26]
  },
  [101503] = {
    101503,
    "str_elite_name_101503",
    "str_elite_desc_101503",
    {10150301}
  },
  [101504] = {
    101504,
    "str_elite_name_101504",
    "str_elite_desc_101504",
    {10150401}
  },
  [101601] = {
    101601,
    "str_elite_name_101601",
    "str_elite_desc_101601",
    {10160101, 10160102}
  },
  [101602] = {
    101602,
    "str_elite_name_101602",
    "str_elite_desc_101602",
    {10160201, 10160202}
  },
  [101603] = {
    101603,
    "str_elite_name_101603",
    "str_elite_desc_101603",
    {10160301, 10160302}
  },
  [101701] = {
    101701,
    "str_elite_name_101701",
    "str_elite_desc_101701",
    {10170101, 10170102}
  },
  [101702] = {
    101702,
    "str_elite_name_101702",
    "str_elite_desc_101702",
    {10170201, 10170202}
  },
  [101703] = {
    101703,
    "str_elite_name_101703",
    "str_elite_desc_101703",
    {10170301, 10170302}
  },
  [101704] = {
    101704,
    "str_elite_name_101704",
    "str_elite_desc_101704",
    {10170401, 10170402}
  },
  [101705] = {
    101705,
    "str_elite_name_101705",
    "str_elite_desc_101705",
    {10170501, 10170502}
  },
  [101706] = {
    101706,
    "str_elite_name_101706",
    "str_elite_desc_101706",
    {53230314}
  },
  [101801] = {
    101801,
    "str_elite_name_101801",
    "str_elite_desc_101801",
    {
      10180101,
      10180102,
      10180103
    }
  },
  [101802] = {
    101802,
    "str_elite_name_101802",
    "str_elite_desc_101802",
    {
      10180201,
      10180202,
      10180203
    }
  },
  [101803] = {
    101803,
    "str_elite_name_101803",
    "str_elite_desc_101803",
    {
      10180301,
      10180302,
      10180303
    }
  },
  [1019] = {
    1019,
    "str_elite_name_1019",
    "str_elite_desc_1019",
    {101901},
    common[2]
  },
  [1020] = {
    1020,
    "str_elite_name_1020",
    "str_elite_desc_1020",
    {102001},
    common[2]
  },
  [1021] = {
    1021,
    "str_elite_name_1021",
    "str_elite_desc_1021",
    {100001, 102101},
    common[1]
  },
  [1022] = {
    1022,
    "str_elite_name_1022",
    "str_elite_desc_1022",
    {10102}
  },
  [1023] = {
    1023,
    "str_elite_name_1023",
    "str_elite_desc_1023",
    {102301}
  },
  [1024] = {
    1024,
    "str_elite_name_1024",
    "str_elite_desc_1024",
    {102401}
  },
  [1025] = {
    1025,
    "str_elite_name_1025",
    "str_elite_desc_1025",
    {102501}
  },
  [102601] = {
    102601,
    "str_elite_name_102601",
    "str_elite_desc_102601",
    {100001, 10260101}
  },
  [102602] = {
    102602,
    "str_elite_name_102602",
    "str_elite_desc_102602",
    {100001, 10260201}
  },
  [102603] = {
    102603,
    "str_elite_name_102603",
    "str_elite_desc_102603",
    {100001, 10260301}
  },
  [102604] = {
    102604,
    "str_elite_name_102604",
    "str_elite_desc_102604",
    {100001, 10260401}
  },
  [102605] = {
    102605,
    "str_elite_name_102605",
    "str_elite_desc_102605",
    {100001, 10260501}
  },
  [1027] = {
    1027,
    common[6],
    "str_elite_desc_1027",
    {100001, 102701}
  },
  [102701] = {
    102701,
    common[6],
    "str_elite_desc_102701",
    {102703}
  },
  [1028] = {
    1028,
    "str_elite_name_1028",
    "str_elite_desc_1028",
    {100001, 102801},
    common[3]
  },
  [1029] = {
    1029,
    "str_elite_name_1029",
    "str_elite_desc_1029",
    {100001, 102901}
  },
  [103001] = {
    103001,
    "str_elite_name_103001",
    "str_elite_desc_103001",
    {10300101}
  },
  [103002] = {
    103002,
    "str_elite_name_103002",
    "str_elite_desc_103002",
    {10300201}
  },
  [103003] = {
    103003,
    "str_elite_name_103003",
    "str_elite_desc_103003",
    {10300301}
  },
  [103004] = {
    103004,
    "str_elite_name_103004",
    "str_elite_desc_103004",
    {10300401}
  },
  [103005] = {
    103005,
    "str_elite_name_103005",
    "str_elite_desc_103005",
    {10300501}
  },
  [1031] = {
    1031,
    "str_elite_name_1031",
    "str_elite_desc_1031",
    {100001, 103101},
    common[3]
  },
  [1032] = {
    1032,
    "str_elite_name_1032",
    "str_elite_desc_1032",
    {103201}
  },
  [1033] = {
    1033,
    "str_elite_name_1033",
    "str_elite_desc_1033",
    {103301}
  },
  [103401] = {
    103401,
    "str_elite_name_103401",
    "str_elite_desc_103401",
    {10340101}
  },
  [103402] = {
    103402,
    "str_elite_name_103402",
    "str_elite_desc_103402",
    {10340201}
  },
  [103403] = {
    103403,
    "str_elite_name_103403",
    "str_elite_desc_103403",
    {10340301}
  },
  [1035] = {
    1035,
    "str_elite_name_1035",
    "str_elite_desc_1035",
    {103501}
  },
  [1036] = {
    1036,
    "str_elite_name_1036",
    "str_elite_desc_1036",
    {103601, 103602}
  },
  [103701] = {
    103701,
    "str_elite_name_103701",
    "str_elite_desc_103701",
    {10370101, 10370102}
  },
  [103702] = {
    103702,
    "str_elite_name_103702",
    "str_elite_desc_103702",
    {10370201, 10370202}
  },
  [103703] = {
    103703,
    "str_elite_name_103703",
    "str_elite_desc_103703",
    {10370301, 10370302}
  },
  [103704] = {
    103704,
    "str_elite_name_103704",
    "str_elite_desc_103704",
    {10370401, 10370402}
  },
  [103705] = {
    103705,
    "str_elite_name_103705",
    "str_elite_desc_103705",
    {10370501, 10370502}
  },
  [1038] = {
    1038,
    "str_elite_name_1038",
    "str_elite_desc_1038",
    {103801}
  },
  [1039] = {
    1039,
    "str_elite_name_1039",
    "str_elite_desc_1039",
    {103901}
  },
  [1040] = {
    1040,
    common[7],
    common[8],
    common[27]
  },
  [104001] = {
    104001,
    common[7],
    common[8],
    common[27],
    "30862, 30872"
  },
  [1041] = {
    1041,
    "str_elite_name_1041",
    "str_elite_desc_1041",
    {104101}
  },
  [1042] = {
    1042,
    "str_elite_name_1042",
    "str_elite_desc_1042",
    {104201}
  },
  [104301] = {
    104301,
    "str_elite_name_104301",
    "str_elite_desc_104301",
    {10430101, 10430102}
  },
  [104302] = {
    104302,
    "str_elite_name_104302",
    "str_elite_desc_104302",
    {10430201, 10430202}
  },
  [104303] = {
    104303,
    "str_elite_name_104303",
    "str_elite_desc_104303",
    {10430301, 10430302}
  },
  [104304] = {
    104304,
    "str_elite_name_104304",
    "str_elite_desc_104304",
    {10430401, 10430402}
  },
  [104401] = {
    104401,
    "str_elite_name_104401",
    "str_elite_desc_104401",
    {10440101}
  },
  [104402] = {
    104402,
    "str_elite_name_104402",
    "str_elite_desc_104402",
    {10440201}
  },
  [104403] = {
    104403,
    "str_elite_name_104403",
    "str_elite_desc_104403",
    {10440301}
  },
  [104501] = {
    104501,
    "str_elite_name_104501",
    "str_elite_desc_104501",
    {10450101}
  },
  [104502] = {
    104502,
    "str_elite_name_104502",
    "str_elite_desc_104502",
    {10450201}
  },
  [104503] = {
    104503,
    "str_elite_name_104503",
    "str_elite_desc_104503",
    {10450301}
  },
  [104601] = {
    104601,
    "str_elite_name_104601",
    "str_elite_desc_104601",
    {10460101}
  },
  [104602] = {
    104602,
    "str_elite_name_104602",
    "str_elite_desc_104602",
    {10460201}
  },
  [104603] = {
    104603,
    "str_elite_name_104603",
    "str_elite_desc_104604",
    {10460301}
  },
  [104701] = {
    104701,
    "str_elite_name_104701",
    "str_elite_desc_104701",
    {10470101, 10470102}
  },
  [104702] = {
    104702,
    "str_elite_name_104702",
    "str_elite_desc_104702",
    {10470201, 10470202}
  },
  [104703] = {
    104703,
    "str_elite_name_104703",
    "str_elite_desc_104703",
    {10470301, 10470302}
  },
  [104704] = {
    104704,
    "str_elite_name_104704",
    "str_elite_desc_104704",
    {10470401, 10470402}
  },
  [104705] = {
    104705,
    "str_elite_name_104705",
    "str_elite_desc_104705",
    {10470501, 10470502}
  },
  [104801] = {
    104801,
    "str_elite_name_104801",
    "str_elite_desc_104801",
    {10480101, 10480102}
  },
  [104802] = {
    104802,
    "str_elite_name_104802",
    "str_elite_desc_104802",
    {10480101, 10480202}
  },
  [104803] = {
    104803,
    "str_elite_name_104803",
    "str_elite_desc_104803",
    {10480101, 10480302}
  },
  [104804] = {
    104804,
    "str_elite_name_104804",
    "str_elite_desc_104804",
    {10480101, 10480402}
  },
  [104901] = {
    104901,
    "str_elite_name_104901",
    "str_elite_desc_104901",
    {10490101}
  },
  [105001] = {
    105001,
    "str_elite_name_105001",
    "str_elite_desc_105001",
    {10500101}
  },
  [105002] = {
    105002,
    "str_elite_name_105002",
    "str_elite_desc_105002",
    {10500201}
  },
  [105003] = {
    105003,
    "str_elite_name_105003",
    "str_elite_desc_105003",
    {10500301}
  },
  [105101] = {
    105101,
    "str_elite_name_105101",
    "str_elite_desc_105101",
    {10510101}
  },
  [105102] = {
    105102,
    "str_elite_name_105102",
    "str_elite_desc_105102",
    {10510201}
  },
  [105103] = {
    105103,
    "str_elite_name_105103",
    "str_elite_desc_105103",
    {10510301}
  },
  [105201] = {
    105201,
    "str_elite_name_105201",
    "str_elite_desc_105201",
    {10520101},
    common[2]
  },
  [105301] = {
    105301,
    "str_elite_name_105301",
    "str_elite_desc_105301",
    {10530101}
  },
  [105302] = {
    105302,
    "str_elite_name_105302",
    "str_elite_desc_105302",
    {10530201}
  },
  [105401] = {
    105401,
    "str_elite_name_105401",
    "str_elite_desc_105401",
    {10540101},
    common[2]
  },
  [105501] = {
    105501,
    "str_elite_name_105501",
    "str_elite_desc_105501",
    {10550101}
  },
  [105502] = {
    105502,
    "str_elite_name_105502",
    "str_elite_desc_105502",
    {10550201}
  },
  [105601] = {
    105601,
    "str_elite_name_105601",
    "str_elite_desc_105601",
    {10560101, 10560102}
  },
  [105602] = {
    105602,
    "str_elite_name_105602",
    "str_elite_desc_105602",
    {10560201, 10560202}
  },
  [105701] = {
    105701,
    "str_elite_name_105701",
    "str_elite_desc_105701",
    {10570101}
  },
  [105801] = {
    105801,
    "str_elite_name_105801",
    "str_elite_desc_105801",
    {10580101}
  },
  [105901] = {
    105901,
    "str_elite_name_105901",
    "str_elite_desc_105901",
    {10590101}
  },
  [105902] = {
    105902,
    "str_elite_name_105902",
    "str_elite_desc_105902",
    {10590201}
  },
  [106001] = {
    106001,
    "str_elite_name_106001",
    "str_elite_desc_106001"
  },
  [106002] = {
    106002,
    "str_elite_name_106002",
    "str_elite_desc_106002"
  },
  [106003] = {
    106003,
    "str_elite_name_106003",
    "str_elite_desc_106003"
  },
  [106004] = {
    106004,
    "str_elite_name_106004",
    "str_elite_desc_106004"
  },
  [106005] = {
    106005,
    "str_elite_name_106005",
    "str_elite_desc_106005"
  },
  [106006] = {
    106006,
    "str_elite_name_106006",
    "str_elite_desc_106006",
    {
      100001,
      10600601,
      10600602
    }
  },
  [106007] = {
    106007,
    "str_elite_name_106007",
    "str_elite_desc_106007",
    {10600701, 10600702}
  },
  [106008] = {
    106008,
    "str_elite_name_106008",
    "str_elite_desc_106008"
  },
  [106009] = {
    106009,
    "str_elite_name_106009",
    "str_elite_desc_106009"
  },
  [106010] = {
    106010,
    "str_elite_name_106010",
    "str_elite_desc_106010"
  },
  [106011] = {
    106011,
    "str_elite_name_106011",
    "str_elite_desc_106011",
    {
      10610101,
      10610102,
      10610103
    }
  },
  [106201] = {
    106201,
    "str_elite_name_106201",
    "str_elite_desc_106201",
    {
      10620101,
      10620102,
      10620103,
      10620104,
      10620105
    }
  },
  [106301] = {
    106301,
    "str_elite_name_106301",
    "str_elite_desc_106301",
    {10630101, 10630102}
  },
  [106302] = {
    106302,
    "str_elite_name_106302",
    "str_elite_desc_106302",
    {10630201, 10630202}
  },
  [106303] = {
    106303,
    "str_elite_name_106303",
    "str_elite_desc_106303",
    {10630301, 10630302}
  },
  [106401] = {
    106401,
    "str_elite_name_106401",
    "str_elite_desc_106401",
    {10640101}
  },
  [106501] = {
    106501,
    "str_elite_name_106501",
    "str_elite_desc_106501",
    {10650101}
  },
  [106601] = {
    106601,
    "str_elite_name_106601",
    "str_elite_desc_106601",
    {10660101}
  },
  [106801] = {
    106801,
    "str_elite_name_106801",
    "str_elite_desc_106801",
    {10680101},
    common[2]
  },
  [106901] = {
    106901,
    "str_elite_name_106901",
    "str_elite_desc_106901",
    {10690101}
  },
  [107001] = {
    107001,
    "str_elite_name_107001",
    "str_elite_desc_107001",
    {10700101}
  },
  [107101] = {
    107101,
    "str_elite_name_107101",
    "str_elite_desc_107101",
    {10710101}
  },
  [107203] = {
    107203,
    "str_elite_name_107201",
    "str_elite_desc_107201",
    {10720103}
  },
  [107204] = {
    107204,
    "str_elite_name_107204",
    "str_elite_desc_107204",
    {10720104}
  },
  [107301] = {
    107301,
    "str_elite_name_107301",
    "str_elite_desc_107301",
    {10730101}
  },
  [107401] = {
    107401,
    "str_elite_name_107401",
    "str_elite_desc_107401",
    {10740101}
  },
  [107402] = {
    107402,
    "str_elite_name_107402",
    "str_elite_desc_107402",
    {10740102}
  },
  [107501] = {
    107501,
    "str_elite_name_107501",
    "str_elite_desc_107501",
    {10750101}
  },
  [107601] = {
    107601,
    "str_elite_name_107601",
    "str_elite_desc_107601",
    {10760101}
  },
  [107701] = {
    107701,
    "str_elite_name_107701",
    "str_elite_desc_107701",
    {10770101}
  },
  [107801] = {
    107801,
    "str_elite_name_107801",
    "str_elite_desc_107801",
    {10780101},
    common[2]
  },
  [107901] = {
    107901,
    "str_elite_name_107901",
    "str_elite_desc_107901",
    {10790101}
  },
  [108001] = {
    108001,
    "str_elite_name_108001",
    "str_elite_desc_108001",
    {10800101}
  },
  [108101] = {
    108101,
    "str_elite_name_108101",
    "str_elite_desc_108101",
    {10810101}
  },
  [108201] = {
    108201,
    "str_elite_name_108201",
    "str_elite_desc_108201",
    {10820101},
    common[1]
  },
  [108301] = {
    108301,
    "str_elite_name_108301",
    "str_elite_desc_108301",
    {10830101}
  },
  [108401] = {
    108401,
    "str_elite_name_108401",
    "str_elite_desc_108401",
    {10840101}
  },
  [108501] = {
    108501,
    "str_elite_name_108501",
    "str_elite_desc_108501",
    {10850101}
  },
  [108601] = {
    108601,
    "str_elite_name_108601",
    "str_elite_desc_108601",
    {10860101}
  },
  [108701] = {
    108701,
    "str_elite_name_108701",
    "str_elite_desc_108701",
    {10870101}
  },
  [108801] = {
    108801,
    common[9],
    common[10],
    {10880101}
  },
  [108802] = {
    108802,
    common[9],
    common[10],
    {10880102}
  },
  [108901] = {
    108901,
    "str_elite_name_108901",
    "str_elite_desc_108901",
    {10890101}
  },
  [109001] = {
    109001,
    "str_elite_name_109001",
    "str_elite_desc_109001",
    {10900101}
  },
  [109101] = {
    109101,
    "str_elite_name_109101",
    "str_elite_desc_109101"
  },
  [109201] = {
    109201,
    "str_elite_name_109201",
    "str_elite_desc_109201",
    {10920101}
  },
  [109301] = {
    109301,
    "str_elite_name_109301",
    "str_elite_desc_109301",
    {10930101}
  },
  [109401] = {
    109401,
    "str_elite_name_109401",
    "str_elite_desc_109401",
    {10940101}
  },
  [109501] = {
    109501,
    "str_elite_name_109501",
    "str_elite_desc_109501"
  },
  [109601] = {
    109601,
    "str_elite_name_109601",
    "str_elite_desc_109601"
  },
  [109701] = {
    109701,
    "str_elite_name_109701",
    "str_elite_desc_109701",
    {10970101, 10970102}
  },
  [109801] = {
    109801,
    "str_elite_name_109801",
    "str_elite_desc_109801",
    {10980101}
  },
  [109901] = {
    109901,
    "str_elite_name_109901",
    "str_elite_desc_109901",
    {10990101, 10990102}
  },
  [110001] = {
    110001,
    "str_elite_name_110001",
    "str_elite_desc_110001",
    {11000101}
  },
  [110101] = {
    110101,
    "str_elite_name_110101",
    "str_elite_desc_110101",
    {11010101, 11010102}
  },
  [110201] = {
    110201,
    "str_elite_name_110201",
    "str_elite_desc_110201"
  },
  [110301] = {
    110301,
    "str_elite_name_110301",
    "str_elite_desc_110301",
    {11030101, 10990101}
  },
  [110401] = {
    110401,
    "str_elite_name_110401",
    "str_elite_desc_110401",
    {11040101},
    common[1]
  },
  [110501] = {
    110501,
    "str_elite_name_110501",
    "str_elite_desc_110501",
    {11050101},
    common[1]
  },
  [110601] = {
    110601,
    "str_elite_name_110601",
    "str_elite_desc_110601",
    {
      11060101,
      11060102,
      11060103,
      30132
    }
  },
  [110701] = {
    110701,
    "str_elite_name_110701",
    "str_elite_desc_110701",
    {11070101}
  },
  [110801] = {
    110801,
    "str_elite_name_110801",
    "str_elite_desc_110801"
  },
  [110901] = {
    110901,
    "str_elite_name_110901",
    "str_elite_desc_110901",
    {11090101}
  },
  [111001] = {
    111001,
    "str_elite_name_111001",
    "str_elite_desc_111001",
    {11100101}
  },
  [111002] = {
    111002,
    "str_elite_name_111002",
    "str_elite_desc_111002",
    {11100102}
  },
  [110202] = {
    110202,
    "str_elite_name_110202",
    "str_elite_desc_110202"
  },
  [111101] = {
    111101,
    "str_elite_name_111101",
    "str_elite_desc_111101",
    {1017021}
  },
  [111201] = {
    111201,
    "str_elite_name_111201",
    "str_elite_desc_111201",
    {11120101}
  },
  [111301] = {
    111301,
    "str_elite_name_111301",
    "str_elite_desc_111301",
    {11130101},
    common[3]
  },
  [111401] = {
    111401,
    "str_elite_name_111401",
    "str_elite_desc_111401",
    {11140101}
  },
  [111501] = {
    111501,
    "str_elite_name_111501",
    "str_elite_desc_111501"
  },
  [1103] = {
    1103,
    "str_elite_name_1103",
    "str_elite_desc_1103",
    {110301}
  },
  [1104] = {
    1104,
    "str_elite_name_1104",
    "str_elite_desc_1104",
    {110401}
  },
  [1105] = {
    1105,
    "str_elite_name_1105",
    "str_elite_desc_1105"
  },
  [1106] = {
    1106,
    "str_elite_name_1106",
    "str_elite_desc_1106",
    {110601, 110602}
  },
  [1107] = {
    1107,
    "str_elite_name_1107",
    "str_elite_desc_1107"
  },
  [1108] = {
    1108,
    "str_elite_name_1108",
    "str_elite_desc_1108",
    {110701}
  },
  [1109] = {
    1109,
    "str_elite_name_1109",
    "str_elite_desc_1109",
    common[26]
  },
  [1110] = {
    1110,
    "str_elite_name_1110",
    "str_elite_desc_1110",
    {110801}
  },
  [120001] = {
    120001,
    "str_elite_name_120001",
    "str_elite_desc_120001",
    {120001}
  },
  [120002] = {
    120002,
    "str_elite_name_120002",
    "str_elite_desc_120002",
    {120002}
  },
  [120004] = {
    120004,
    "str_elite_name_120004",
    "str_elite_desc_120004"
  },
  [120005] = {
    120005,
    "str_elite_name_120005",
    "str_elite_desc_120005"
  },
  [120006] = {
    120006,
    "str_elite_name_120006",
    "str_elite_desc_120006"
  },
  [120007] = {
    120007,
    "str_elite_name_120007",
    "str_elite_desc_120007",
    {120007}
  },
  [120008] = {
    120008,
    "str_elite_name_120008",
    "str_elite_desc_120008",
    {120008}
  },
  [120010] = {
    120010,
    "str_elite_name_120010",
    "str_elite_desc_120010"
  },
  [120011] = {
    120011,
    "str_elite_name_120011",
    "str_elite_desc_120011",
    {120011}
  },
  [120012] = {
    120012,
    "str_elite_name_120012",
    "str_elite_desc_120012",
    {120012}
  },
  [111601] = {
    111601,
    "str_elite_name_111601",
    "str_elite_desc_111601"
  },
  [111701] = {
    111701,
    "str_elite_name_111701",
    "str_elite_desc_111701"
  },
  [111801] = {
    111801,
    "str_elite_name_111801",
    "str_elite_desc_111801",
    {11180101, 11180102}
  },
  [111901] = {
    111901,
    "str_elite_name_111901",
    "str_elite_desc_111901",
    {11190101, 11190102}
  },
  [112001] = {
    112001,
    "str_elite_name_112001",
    "str_elite_desc_112001",
    {11200101}
  },
  [112101] = {
    112101,
    "str_elite_name_112101",
    "str_elite_desc_112101",
    {11210101}
  },
  [112102] = {
    112102,
    "str_elite_name_112102",
    "str_elite_desc_112102"
  },
  [112201] = {
    112201,
    "str_elite_name_112201",
    "str_elite_desc_112201",
    {
      11220101,
      11220102,
      11220103,
      11220107
    }
  },
  [112301] = {
    112301,
    "str_elite_name_112301",
    "str_elite_desc_112301",
    {11230101}
  },
  [112401] = {
    112401,
    common[11],
    common[12],
    {11240101, 11240102}
  },
  [112402] = {
    112402,
    common[11],
    common[12],
    {11240101, 11240202}
  },
  [112501] = {
    112501,
    "str_elite_name_112501",
    "str_elite_desc_112501"
  },
  [112601] = {
    112601,
    "str_elite_name_112601",
    "str_elite_desc_112601",
    {30124}
  },
  [112701] = {
    112701,
    "str_elite_name_112701",
    "str_elite_desc_112701",
    {30134}
  },
  [112801] = {
    112801,
    "str_elite_name_112801",
    "str_elite_desc_112801",
    {11280101}
  },
  [112901] = {
    112901,
    "str_elite_name_112901",
    "str_elite_desc_112901",
    {11290101, 11290102}
  },
  [112902] = {
    112902,
    "str_elite_name_112902",
    "str_elite_desc_112902",
    {11290201, 11290202}
  },
  [113001] = {
    113001,
    "str_elite_name_113001",
    "str_elite_desc_113001"
  },
  [113101] = {
    113101,
    "str_elite_name_113101",
    "str_elite_desc_113101"
  },
  [113201] = {
    113201,
    "str_elite_name_113201",
    "str_elite_desc_113201",
    {11320101}
  },
  [113301] = {
    113301,
    "str_elite_name_113301",
    "str_elite_desc_113301"
  },
  [113401] = {
    113401,
    "str_elite_name_113401",
    "str_elite_desc_113401"
  },
  [113501] = {
    113501,
    "str_elite_name_113501",
    "str_elite_desc_113501"
  },
  [113601] = {
    113601,
    "str_elite_name_113601",
    "str_elite_desc_113601",
    {11360101}
  },
  [113701] = {
    113701,
    "str_elite_name_113701",
    "str_elite_desc_113701"
  },
  [120101] = {
    120101,
    "str_elite_name_120101",
    "str_elite_desc_120101",
    {120101}
  },
  [120102] = {
    120102,
    "str_elite_name_120102",
    "str_elite_desc_120102",
    {120102}
  },
  [120201] = {
    120201,
    "str_elite_name_120201",
    "str_elite_desc_120201",
    nil,
    common[13]
  },
  [120301] = {
    120301,
    "str_elite_name_120301",
    "str_elite_desc_120301",
    {120301, 120300}
  },
  [120302] = {
    120302,
    "str_elite_name_120302",
    "str_elite_desc_120302",
    {120302, 120300}
  },
  [120401] = {
    120401,
    "str_elite_name_120401",
    "str_elite_desc_120401",
    {120401}
  },
  [120501] = {
    120501,
    "str_elite_name_120501",
    "str_elite_desc_120501"
  },
  [120601] = {
    120601,
    "str_elite_name_120601",
    "str_elite_desc_120601"
  },
  [120701] = {
    120701,
    "str_elite_name_120701",
    "str_elite_desc_120701",
    {120701}
  },
  [5395001] = {
    5395001,
    "str_elite_name_5395001",
    "str_elite_desc_5395001"
  },
  [5395002] = {
    5395002,
    "str_elite_name_5395002",
    "str_elite_desc_5395002",
    {5395003}
  },
  [5395003] = {
    5395003,
    "str_elite_name_5395003",
    "str_elite_desc_5395003"
  },
  [5395004] = {
    5395004,
    "str_elite_name_5395004",
    "str_elite_desc_5395004"
  },
  [5395005] = {
    5395005,
    "str_elite_name_5395005",
    "str_elite_desc_5395005",
    {5395012}
  },
  [5395006] = {
    5395006,
    "str_elite_name_5395006",
    "str_elite_desc_5395006"
  },
  [5395007] = {
    5395007,
    "str_elite_name_5395007",
    "str_elite_desc_5395007"
  },
  [5393001] = {
    5393001,
    "str_elite_name_5393001",
    "str_elite_desc_5393001"
  },
  [5392001] = {
    5392001,
    "str_elite_name_5392001",
    "str_elite_desc_5392001",
    {5392030}
  },
  [113801] = {
    113801,
    "str_elite_name_113801",
    "str_elite_desc_113801"
  },
  [113901] = {
    113901,
    "str_elite_name_113901",
    "str_elite_desc_113901"
  },
  [5412010] = {
    5412010,
    "str_elite_name_5412010",
    "str_elite_desc_5412010",
    {5412010}
  },
  [5411001] = {
    5411001,
    "str_elite_name_5411001",
    "str_elite_desc_5411001",
    {5411002},
    common[1]
  },
  [5411002] = {
    5411002,
    "str_elite_name_5411002",
    "str_elite_desc_5411002"
  },
  [5411003] = {
    5411003,
    "str_elite_name_5411003",
    "str_elite_desc_5411003"
  },
  [5435007] = {
    5435007,
    "str_elite_name_5435007",
    "str_elite_desc_5435007",
    {54350080}
  },
  [5435008] = {
    5435008,
    "str_elite_name_5435008",
    "str_elite_desc_5435008",
    {54350032}
  },
  [5435009] = {
    5435009,
    "str_elite_name_5435009",
    "str_elite_desc_5435009",
    {54350090}
  },
  [5435010] = {
    5435010,
    "str_elite_name_5435010",
    "str_elite_desc_5435010",
    {54350100}
  },
  [5435011] = {
    5435011,
    "str_elite_name_5435011",
    "str_elite_desc_5435011",
    {
      51450090,
      51450091,
      51450092,
      51450094
    }
  },
  [5435012] = {
    5435012,
    "str_elite_name_5435012",
    "str_elite_desc_5435012",
    {54350071}
  },
  [100201] = {
    100201,
    "str_elite_name_100201",
    "str_elite_desc_100201"
  },
  [100207] = {
    100207,
    "str_elite_name_100207",
    "str_elite_desc_100207",
    {1002071}
  },
  [1119011] = {
    1119011,
    "str_elite_name_1119011",
    "str_elite_desc_1119011",
    {1119011}
  },
  [1119012] = {
    1119012,
    "str_elite_name_1119012",
    "str_elite_desc_1119012",
    {1119016}
  },
  [1119021] = {
    1119021,
    "str_elite_name_1119021",
    "str_elite_desc_1119021",
    {1119021}
  },
  [1119022] = {
    1119022,
    "str_elite_name_1119022",
    "str_elite_desc_1119022",
    {1119023}
  },
  [1119031] = {
    1119031,
    "str_elite_name_1119031",
    "str_elite_desc_1119031",
    {1119031}
  },
  [1119041] = {
    1119041,
    "str_elite_name_1119041",
    "str_elite_desc_1119041",
    {1119043}
  },
  [1119051] = {
    1119051,
    "str_elite_name_1119051",
    "str_elite_desc_1119051"
  },
  [1119052] = {
    1119052,
    "str_elite_name_1119052",
    "str_elite_desc_1119052",
    {1119051}
  },
  [1119061] = {
    1119061,
    "str_elite_name_1119061",
    "str_elite_desc_1119061",
    {
      1119061,
      1119062,
      1119063
    }
  },
  [1119071] = {
    1119071,
    "str_elite_name_1119071",
    "str_elite_desc_1119071"
  },
  [1119081] = {
    1119081,
    "str_elite_name_1119081",
    "str_elite_desc_1119081",
    {1119081}
  },
  [1120011] = {
    1120011,
    "str_elite_name_1120011",
    "str_elite_desc_1120011"
  },
  [1120051] = {
    1120051,
    "str_elite_name_1120051",
    "str_elite_desc_1120051"
  },
  [1120061] = {
    1120061,
    "str_elite_name_1120061",
    "str_elite_desc_1120061"
  },
  [5455007] = {
    5455007,
    "str_elite_name_5455007",
    "str_elite_desc_5455007",
    {54550170}
  },
  [5455008] = {
    5455008,
    "str_elite_name_5455008",
    "str_elite_desc_5455008",
    {54550180},
    common[3]
  },
  [5455010] = {
    5455010,
    "str_elite_name_5455010",
    "str_elite_desc_5455010",
    nil,
    common[3]
  },
  [5455011] = {
    5455011,
    "str_elite_name_5455011",
    "str_elite_desc_5455011",
    {30124, 54550210},
    common[3]
  },
  [5455012] = {
    5455012,
    "str_elite_name_5455012",
    "str_elite_desc_5455012",
    {
      54550223,
      54550221,
      54550222
    },
    common[3]
  },
  [5455013] = {
    5455013,
    "str_elite_name_5455013",
    "str_elite_desc_5455013",
    {54550230},
    common[3]
  },
  [5452011] = {
    5452011,
    "str_elite_name_5452011",
    "str_elite_desc_5452011",
    {50019}
  },
  [5452012] = {
    5452012,
    "str_elite_name_5452012",
    "str_elite_desc_5452012",
    nil,
    common[3]
  },
  [5452013] = {
    5452013,
    "str_elite_name_5452013",
    "str_elite_desc_5452013",
    {54520050, 54520051},
    common[3]
  },
  [5452014] = {
    5452014,
    "str_elite_name_5452014",
    "str_elite_desc_5452014",
    {54520060},
    common[3]
  },
  [121201] = {
    121201,
    "str_elite_name_121201",
    "str_elite_desc_121201",
    {121201},
    common[2]
  },
  [121202] = {
    121202,
    "str_elite_name_121202",
    "str_elite_desc_121202",
    {121202},
    common[2]
  },
  [5462001] = {
    5462001,
    "str_elite_name_5462001",
    "str_elite_desc_5462001",
    {54620010}
  },
  [5462002] = {
    5462002,
    "str_elite_name_5462002",
    "str_elite_desc_5462002",
    {54620020},
    common[3]
  },
  [5462003] = {
    5462003,
    "str_elite_name_5462003",
    "str_elite_desc_5462003",
    {54620030},
    common[3]
  },
  [5462004] = {
    5462004,
    "str_elite_name_5462004",
    "str_elite_desc_5462004",
    {54620040},
    common[3]
  },
  [5462005] = {
    5462005,
    "str_elite_name_5462005",
    "str_elite_desc_5462005",
    {54620050},
    common[3]
  },
  [5462006] = {
    5462006,
    "str_elite_name_5462006",
    "str_elite_desc_5462006",
    {54620060},
    common[3]
  },
  [5474001] = {
    5474001,
    "str_elite_name_5474001",
    "str_elite_desc_5474001",
    {54740010},
    common[3]
  },
  [5474002] = {
    5474002,
    "str_elite_name_5474002",
    "str_elite_desc_5474002",
    {41041},
    common[3]
  },
  [5474003] = {
    5474003,
    "str_elite_name_5474003",
    "str_elite_desc_5474003",
    {54740030},
    common[3]
  },
  [5474004] = {
    5474004,
    "str_elite_name_5474004",
    "str_elite_desc_5474004",
    {54740040},
    common[3]
  },
  [5474005] = {
    5474005,
    "str_elite_name_5474005",
    "str_elite_desc_5474005",
    {54740050},
    common[3]
  },
  [5474006] = {
    5474006,
    "str_elite_name_5474006",
    "str_elite_desc_5474006",
    {54740031, 54740060},
    common[3]
  },
  [5474007] = {
    5474007,
    "str_elite_name_5474007",
    "str_elite_desc_5474007",
    {54740070},
    common[3]
  },
  [5474008] = {
    5474008,
    "str_elite_name_5474008",
    "str_elite_desc_5474008",
    {54740080},
    common[3]
  },
  [5474009] = {
    5474009,
    "str_elite_name_5474009",
    "str_elite_desc_5474009",
    {54740090},
    common[3]
  },
  [5474010] = {
    5474010,
    "str_elite_name_5474010",
    "str_elite_desc_5474010",
    {54740100},
    common[3]
  },
  [5474011] = {
    5474011,
    "str_elite_name_5474011",
    "str_elite_desc_5474011"
  },
  [5474012] = {
    5474012,
    "str_elite_name_5474012",
    "str_elite_desc_5474012"
  },
  [5474013] = {
    5474013,
    "str_elite_name_5474013",
    "str_elite_desc_5474013",
    {54740031},
    common[3]
  },
  [5481002] = {
    5481002,
    "str_elite_name_5481002",
    "str_elite_desc_5481002",
    {54810020},
    common[3]
  },
  [5481003] = {
    5481003,
    "str_elite_name_5481003",
    "str_elite_desc_5481003",
    {54830082},
    common[3]
  },
  [5494001] = {
    5494001,
    common[14],
    common[15],
    {54940011, 54940021},
    common[3]
  },
  [5494002] = {
    5494002,
    common[16],
    common[17],
    {54940012, 54940022},
    common[3]
  },
  [5494003] = {
    5494003,
    common[18],
    common[19],
    {54940013, 54940023},
    common[3]
  },
  [5494004] = {
    5494004,
    "str_elite_name_5494004",
    "str_elite_desc_5494004",
    {54940064},
    common[3]
  },
  [5494005] = {
    5494005,
    common[14],
    common[15],
    {54940021},
    common[3]
  },
  [5494006] = {
    5494006,
    common[16],
    common[17],
    {54940022},
    common[3]
  },
  [5494007] = {
    5494007,
    common[18],
    common[19],
    {54940023},
    common[3]
  },
  [5492001] = {
    5492001,
    "str_elite_name_5492001",
    "str_elite_desc_5492001",
    {5492001}
  },
  [200101] = {
    200101,
    common[20],
    common[21],
    {80010001},
    common[2]
  },
  [200102] = {
    200102,
    common[20],
    common[21],
    {80010002},
    common[2]
  },
  [200103] = {
    200103,
    common[20],
    common[21],
    {80010003},
    common[2]
  },
  [200104] = {
    200104,
    common[20],
    common[21],
    {80010004},
    common[2]
  },
  [200105] = {
    200105,
    common[20],
    common[21],
    {80010005},
    common[2]
  },
  [200106] = {
    200106,
    common[20],
    common[21],
    {80010006},
    common[2]
  },
  [200508] = {
    200508,
    "str_elite_name_200508",
    "str_elite_desc_200508",
    nil,
    common[13]
  },
  [200515] = {
    200515,
    "str_elite_name_200515",
    "str_elite_desc_200515",
    {80031721}
  },
  [804001] = {
    804001,
    common[22],
    common[23],
    {80040501}
  },
  [804002] = {
    804002,
    common[22],
    common[23],
    {80040502}
  },
  [804003] = {
    804003,
    common[22],
    common[23],
    {80040503}
  },
  [804004] = {
    804004,
    "str_elite_name_804004",
    "str_elite_desc_804004"
  },
  [804005] = {
    804005,
    "str_elite_name_804005",
    "str_elite_desc_804005"
  },
  [804006] = {
    804006,
    common[24],
    common[25],
    {80040801}
  },
  [804007] = {
    804007,
    common[24],
    common[25],
    {80040802}
  },
  [804008] = {
    804008,
    common[24],
    common[25],
    {80040803}
  },
  [804009] = {
    804009,
    "str_elite_name_804009",
    "str_elite_desc_804009"
  }
}
return config, "ID", key
