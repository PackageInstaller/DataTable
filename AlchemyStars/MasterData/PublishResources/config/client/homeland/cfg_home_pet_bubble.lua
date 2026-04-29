local key = {
  ID = 1,
  Length = 2,
  Type = 3,
  Params = 4,
  FaceSeq = 5,
  Audio = 6,
  Scale = 7,
  Offset = 8,
  BubbleAni = 9
}
local common = {
  "eff_jy_meme_duihua2.prefab",
  {
    {3, 1300},
    {1, 300}
  },
  {
    {2, 1300},
    {1, 300}
  },
  {
    {1, 0},
    {2, 50},
    {1, 800},
    {2, 50},
    {1, 0}
  },
  {
    0.8,
    0.8,
    0.8
  }
}
local config = {
  [4010001] = {
    4010001,
    1700,
    1,
    "eff_jy_meme_aixin.prefab",
    common[2],
    1717,
    common[5]
  },
  [4010002] = {
    4010002,
    1700,
    1,
    "eff_jy_meme_shengqi.prefab",
    {
      {4, 1300},
      {1, 300}
    },
    nil,
    common[5]
  },
  [4010003] = {
    4010003,
    1700,
    1,
    "eff_jy_meme_jingqi.prefab",
    nil,
    1714,
    common[5]
  },
  [4010004] = {
    4010004,
    1700,
    1,
    "eff_jy_meme_beiai.prefab",
    {
      {5, 1300},
      {1, 300}
    },
    nil,
    common[5]
  },
  [4010006] = {
    4010006,
    1700,
    1,
    "eff_jy_meme_duihua1.prefab",
    nil,
    nil,
    common[5]
  },
  [4010007] = {
    4010007,
    1700,
    1,
    common[1],
    nil,
    1712,
    common[5]
  },
  [4010008] = {
    4010008,
    1700,
    1,
    "eff_jy_meme_haixiu.prefab",
    {
      {8, 1300},
      {1, 300}
    },
    1712,
    common[5]
  },
  [4010009] = {
    4010009,
    1700,
    1,
    "eff_jy_meme_linggan.prefab",
    nil,
    1715,
    common[5]
  },
  [4010010] = {
    4010010,
    1700,
    1,
    "eff_jy_meme_liwuhe.prefab",
    nil,
    nil,
    common[5]
  },
  [4010011] = {
    4010011,
    1700,
    1,
    "eff_jy_meme_pibei.prefab",
    common[3],
    1716,
    common[5]
  },
  [4010012] = {
    4010012,
    1700,
    1,
    "eff_jy_meme_qidai.prefab",
    common[2],
    1717,
    common[5]
  },
  [4010013] = {
    4010013,
    1700,
    1,
    "eff_jy_meme_xingfen.prefab",
    common[2],
    1717,
    common[5]
  },
  [4010014] = {
    4010014,
    1700,
    1,
    "eff_jy_meme_yiwen.prefab",
    nil,
    1713,
    common[5]
  },
  [4010015] = {
    4010015,
    3000,
    0,
    nil,
    {
      {1, 0},
      {2, 50},
      {1, 800},
      {2, 50},
      {1, 0},
      {2, 50},
      {1, 800},
      {2, 50},
      {1, 0}
    },
    nil,
    common[5]
  },
  [4010016] = {
    4010016,
    1700,
    0,
    nil,
    {
      {2, 1600}
    },
    nil,
    common[5]
  },
  [4010017] = {
    4010017,
    1700,
    0,
    nil,
    {
      {1, 1600}
    },
    nil,
    common[5]
  },
  [4020001] = {
    4020001,
    0,
    1,
    "eff_jy_meme_wenhao.prefab",
    common[4],
    nil,
    common[5],
    {
      0,
      -0.9,
      0
    },
    {
      "effanim_hl_meme_wenhao_in",
      "effanim_hl_meme_wenhao_loop",
      "effanim_hl_meme_wenhao_out"
    }
  },
  [4020002] = {
    4020002,
    0,
    1,
    common[1],
    common[4],
    nil,
    common[5],
    nil,
    {
      "effanim_hl_meme_duihua2_in",
      "effanim_hl_meme_duihua2_loop",
      "effanim_hl_meme_duihua2_out"
    }
  },
  [4020003] = {
    4020003,
    1700,
    1,
    "eff_jy_meme_huangzhang.prefab",
    common[3],
    1713,
    common[5]
  },
  [4020004] = {
    4020004,
    1700,
    1,
    "eff_jy_meme_hunluan.prefab",
    common[2],
    1714,
    common[5]
  },
  [4020005] = {
    4020005,
    1700,
    1,
    "eff_jy_meme_heixian.prefab",
    common[2],
    1717,
    common[5]
  },
  [4040001] = {
    4040001,
    5000,
    2,
    "str_homeland_petbubble_0001",
    common[4],
    nil,
    common[5]
  },
  [4040002] = {
    4040002,
    5000,
    3,
    "str_homeland_petbubble_0002",
    common[4],
    nil,
    common[5]
  },
  [4010018] = {
    4010018,
    900,
    2,
    "str_homeland_petbubble_1001",
    common[4],
    nil,
    common[5]
  },
  [4010019] = {
    4010019,
    900,
    2,
    "str_homeland_petbubble_1002",
    common[4],
    nil,
    common[5]
  },
  [4010020] = {
    4010020,
    900,
    2,
    "str_homeland_petbubble_1003",
    common[4],
    nil,
    common[5]
  },
  [4010021] = {
    4010021,
    900,
    2,
    "str_homeland_petbubble_1004",
    common[4],
    nil,
    common[5]
  },
  [4010022] = {
    4010022,
    900,
    2,
    "str_homeland_petbubble_1005",
    common[4],
    nil,
    common[5]
  },
  [4010023] = {
    4010023,
    900,
    2,
    "str_homeland_petbubble_1006",
    common[4],
    nil,
    common[5]
  },
  [4010024] = {
    4010024,
    900,
    2,
    "str_homeland_petbubble_1007",
    common[4],
    nil,
    common[5]
  },
  [4010025] = {
    4010025,
    900,
    2,
    "str_homeland_petbubble_1008",
    common[4],
    nil,
    common[5]
  },
  [4010026] = {
    4010026,
    900,
    2,
    "str_homeland_petbubble_1009",
    common[4],
    nil,
    common[5]
  },
  [4010027] = {
    4010027,
    900,
    2,
    "str_homeland_petbubble_1010",
    common[4],
    nil,
    common[5]
  },
  [4010028] = {
    4010028,
    900,
    2,
    "str_homeland_petbubble_1011",
    common[4],
    nil,
    common[5]
  },
  [4010029] = {
    4010029,
    900,
    2,
    "str_homeland_petbubble_1012",
    common[4],
    nil,
    common[5]
  },
  [4010030] = {
    4010030,
    900,
    2,
    "str_homeland_petbubble_1013",
    common[4],
    nil,
    common[5]
  },
  [4010031] = {
    4010031,
    900,
    2,
    "str_homeland_petbubble_1014",
    common[4],
    nil,
    common[5]
  },
  [4010032] = {
    4010032,
    900,
    2,
    "str_homeland_petbubble_1015",
    common[4],
    nil,
    common[5]
  },
  [4010033] = {
    4010033,
    900,
    2,
    "str_homeland_petbubble_1016",
    common[4],
    nil,
    common[5]
  },
  [4010034] = {
    4010034,
    900,
    2,
    "str_homeland_petbubble_1017",
    common[4],
    nil,
    common[5]
  },
  [4010035] = {
    4010035,
    900,
    2,
    "str_homeland_petbubble_1018",
    common[4],
    nil,
    common[5]
  },
  [4010036] = {
    4010036,
    900,
    2,
    "str_homeland_petbubble_1019",
    common[4],
    nil,
    common[5]
  },
  [4010037] = {
    4010037,
    900,
    2,
    "str_homeland_petbubble_1020",
    common[4],
    nil,
    common[5]
  },
  [4010038] = {
    4010038,
    900,
    2,
    "str_homeland_petbubble_1021",
    common[4],
    nil,
    common[5]
  },
  [4010039] = {
    4010039,
    900,
    2,
    "str_homeland_petbubble_1022",
    common[4],
    nil,
    common[5]
  },
  [4010040] = {
    4010040,
    900,
    2,
    "str_homeland_petbubble_1023",
    common[4],
    nil,
    common[5]
  },
  [4010041] = {
    4010041,
    900,
    2,
    "str_homeland_petbubble_1024",
    common[4],
    nil,
    common[5]
  },
  [4010042] = {
    4010042,
    900,
    2,
    "str_homeland_petbubble_1025",
    common[4],
    nil,
    common[5]
  },
  [4010043] = {
    4010043,
    900,
    2,
    "str_homeland_petbubble_1026",
    common[4],
    nil,
    common[5]
  },
  [4010044] = {
    4010044,
    900,
    2,
    "str_homeland_petbubble_1027",
    common[4],
    nil,
    common[5]
  },
  [4010045] = {
    4010045,
    900,
    2,
    "str_homeland_petbubble_1028",
    common[4],
    nil,
    common[5]
  },
  [4010046] = {
    4010046,
    900,
    2,
    "str_homeland_petbubble_1029",
    common[4],
    nil,
    common[5]
  },
  [4010047] = {
    4010047,
    900,
    2,
    "str_homeland_petbubble_1030",
    common[4],
    nil,
    common[5]
  },
  [4010048] = {
    4010048,
    900,
    2,
    "str_homeland_petbubble_1031",
    common[4],
    nil,
    common[5]
  },
  [4010049] = {
    4010049,
    900,
    2,
    "str_homeland_petbubble_1032",
    common[4],
    nil,
    common[5]
  },
  [4010050] = {
    4010050,
    900,
    2,
    "str_homeland_petbubble_1033",
    common[4],
    nil,
    common[5]
  },
  [4010051] = {
    4010051,
    900,
    2,
    "str_homeland_petbubble_1034",
    common[4],
    nil,
    common[5]
  },
  [4010052] = {
    4010052,
    900,
    2,
    "str_homeland_petbubble_1035",
    common[4],
    nil,
    common[5]
  },
  [4010053] = {
    4010053,
    900,
    2,
    "str_homeland_petbubble_1036",
    common[4],
    nil,
    common[5]
  },
  [4010054] = {
    4010054,
    900,
    2,
    "str_homeland_petbubble_1037",
    common[4],
    nil,
    common[5]
  },
  [4010055] = {
    4010055,
    900,
    2,
    "str_homeland_petbubble_1038",
    common[4],
    nil,
    common[5]
  },
  [4010056] = {
    4010056,
    900,
    2,
    "str_homeland_petbubble_1039",
    common[4],
    nil,
    common[5]
  },
  [4010057] = {
    4010057,
    900,
    2,
    "str_homeland_petbubble_1040",
    common[4],
    nil,
    common[5]
  },
  [4010058] = {
    4010058,
    900,
    2,
    "str_homeland_petbubble_1041",
    common[4],
    nil,
    common[5]
  },
  [4010059] = {
    4010059,
    900,
    2,
    "str_homeland_petbubble_1042",
    common[4],
    nil,
    common[5]
  },
  [4010060] = {
    4010060,
    900,
    2,
    "str_homeland_petbubble_1043",
    common[4],
    nil,
    common[5]
  },
  [4010061] = {
    4010061,
    900,
    2,
    "str_homeland_petbubble_1044",
    common[4],
    nil,
    common[5]
  },
  [4010062] = {
    4010062,
    900,
    2,
    "str_homeland_petbubble_1045",
    common[4],
    nil,
    common[5]
  },
  [4010063] = {
    4010063,
    900,
    2,
    "str_homeland_petbubble_1046",
    common[4],
    nil,
    common[5]
  },
  [4010064] = {
    4010064,
    900,
    2,
    "str_homeland_petbubble_1047",
    common[4],
    nil,
    common[5]
  },
  [4010065] = {
    4010065,
    900,
    2,
    "str_homeland_petbubble_1048",
    common[4],
    nil,
    common[5]
  },
  [4010066] = {
    4010066,
    900,
    2,
    "str_homeland_petbubble_1049",
    common[4],
    nil,
    common[5]
  },
  [4010067] = {
    4010067,
    900,
    2,
    "str_homeland_petbubble_1050",
    common[4],
    nil,
    common[5]
  },
  [4010068] = {
    4010068,
    900,
    2,
    "str_homeland_petbubble_1051",
    common[4],
    nil,
    common[5]
  },
  [4010069] = {
    4010069,
    900,
    2,
    "str_homeland_petbubble_1052",
    common[4],
    nil,
    common[5]
  },
  [4010070] = {
    4010070,
    900,
    2,
    "str_homeland_petbubble_1053",
    common[4],
    nil,
    common[5]
  },
  [4010071] = {
    4010071,
    900,
    2,
    "str_homeland_petbubble_1054",
    common[4],
    nil,
    common[5]
  },
  [4010072] = {
    4010072,
    900,
    2,
    "str_homeland_petbubble_1055",
    common[4],
    nil,
    common[5]
  },
  [4010073] = {
    4010073,
    900,
    2,
    "str_homeland_petbubble_1056",
    common[4],
    nil,
    common[5]
  },
  [4010074] = {
    4010074,
    900,
    2,
    "str_homeland_petbubble_1057",
    common[4],
    nil,
    common[5]
  },
  [4010075] = {
    4010075,
    900,
    2,
    "str_homeland_petbubble_1058",
    common[4],
    nil,
    common[5]
  },
  [4010076] = {
    4010076,
    900,
    2,
    "str_homeland_petbubble_1059",
    common[4],
    nil,
    common[5]
  },
  [4010077] = {
    4010077,
    900,
    2,
    "str_homeland_petbubble_1060",
    common[4],
    nil,
    common[5]
  },
  [4010078] = {
    4010078,
    900,
    2,
    "str_homeland_petbubble_1061",
    common[4],
    nil,
    common[5]
  },
  [4010079] = {
    4010079,
    900,
    2,
    "str_homeland_petbubble_1062",
    common[4],
    nil,
    common[5]
  },
  [4010080] = {
    4010080,
    900,
    2,
    "str_homeland_petbubble_1063",
    common[4],
    nil,
    common[5]
  },
  [4010081] = {
    4010081,
    900,
    2,
    "str_homeland_petbubble_1064",
    common[4],
    nil,
    common[5]
  },
  [4010082] = {
    4010082,
    900,
    2,
    "str_homeland_petbubble_1065",
    common[4],
    nil,
    common[5]
  },
  [4010083] = {
    4010083,
    900,
    2,
    "str_homeland_petbubble_1066",
    common[4],
    nil,
    common[5]
  },
  [4010084] = {
    4010084,
    900,
    2,
    "str_homeland_petbubble_1067",
    common[4],
    nil,
    common[5]
  },
  [4010085] = {
    4010085,
    900,
    2,
    "str_homeland_petbubble_1068",
    common[4],
    nil,
    common[5]
  },
  [4010086] = {
    4010086,
    900,
    2,
    "str_homeland_petbubble_1069",
    common[4],
    nil,
    common[5]
  },
  [4010087] = {
    4010087,
    900,
    2,
    "str_homeland_petbubble_1070",
    common[4],
    nil,
    common[5]
  },
  [4010088] = {
    4010088,
    900,
    2,
    "str_homeland_petbubble_1071",
    common[4],
    nil,
    common[5]
  },
  [4010089] = {
    4010089,
    900,
    2,
    "str_homeland_petbubble_1072",
    common[4],
    nil,
    common[5]
  },
  [4010090] = {
    4010090,
    900,
    2,
    "str_homeland_petbubble_1073",
    common[4],
    nil,
    common[5]
  },
  [4010091] = {
    4010091,
    900,
    2,
    "str_homeland_petbubble_1074",
    common[4],
    nil,
    common[5]
  },
  [4010092] = {
    4010092,
    900,
    2,
    "str_homeland_petbubble_1075",
    common[4],
    nil,
    common[5]
  },
  [4010093] = {
    4010093,
    900,
    2,
    "str_homeland_petbubble_1076",
    common[4],
    nil,
    common[5]
  },
  [4010094] = {
    4010094,
    900,
    2,
    "str_homeland_petbubble_1077",
    common[4],
    nil,
    common[5]
  },
  [4010095] = {
    4010095,
    900,
    2,
    "str_homeland_petbubble_1078",
    common[4],
    nil,
    common[5]
  },
  [4010096] = {
    4010096,
    900,
    2,
    "str_homeland_petbubble_1079",
    common[4],
    nil,
    common[5]
  },
  [4010097] = {
    4010097,
    900,
    2,
    "str_homeland_petbubble_1080",
    common[4],
    nil,
    common[5]
  },
  [4010098] = {
    4010098,
    900,
    2,
    "str_homeland_petbubble_1081",
    common[4],
    nil,
    common[5]
  },
  [4010099] = {
    4010099,
    900,
    2,
    "str_homeland_petbubble_1082",
    common[4],
    nil,
    common[5]
  },
  [4010100] = {
    4010100,
    900,
    2,
    "str_homeland_petbubble_1083",
    common[4],
    nil,
    common[5]
  },
  [4010101] = {
    4010101,
    900,
    2,
    "str_homeland_petbubble_1084",
    common[4],
    nil,
    common[5]
  },
  [4010102] = {
    4010102,
    900,
    2,
    "str_homeland_petbubble_1085",
    common[4],
    nil,
    common[5]
  },
  [4010103] = {
    4010103,
    900,
    2,
    "str_homeland_petbubble_1086",
    common[4],
    nil,
    common[5]
  },
  [4010104] = {
    4010104,
    900,
    2,
    "str_homeland_petbubble_1087",
    common[4],
    nil,
    common[5]
  },
  [4010105] = {
    4010105,
    900,
    2,
    "str_homeland_petbubble_1088",
    common[4],
    nil,
    common[5]
  },
  [4010106] = {
    4010106,
    900,
    2,
    "str_homeland_petbubble_1089",
    common[4],
    nil,
    common[5]
  },
  [4010107] = {
    4010107,
    900,
    2,
    "str_homeland_petbubble_1090",
    common[4],
    nil,
    common[5]
  },
  [4010108] = {
    4010108,
    900,
    2,
    "str_homeland_petbubble_1091",
    common[4],
    nil,
    common[5]
  },
  [4010109] = {
    4010109,
    900,
    2,
    "str_homeland_petbubble_1092",
    common[4],
    nil,
    common[5]
  },
  [4010110] = {
    4010110,
    900,
    2,
    "str_homeland_petbubble_1093",
    common[4],
    nil,
    common[5]
  },
  [4010111] = {
    4010111,
    900,
    2,
    "str_homeland_petbubble_1094",
    common[4],
    nil,
    common[5]
  },
  [4010112] = {
    4010112,
    900,
    2,
    "str_homeland_petbubble_1095",
    common[4],
    nil,
    common[5]
  },
  [4010113] = {
    4010113,
    900,
    2,
    "str_homeland_petbubble_1096",
    common[4],
    nil,
    common[5]
  },
  [4010114] = {
    4010114,
    900,
    2,
    "str_homeland_petbubble_1097",
    common[4],
    nil,
    common[5]
  },
  [4010115] = {
    4010115,
    900,
    2,
    "str_homeland_petbubble_1098",
    common[4],
    nil,
    common[5]
  },
  [4010116] = {
    4010116,
    900,
    2,
    "str_homeland_petbubble_1099",
    common[4],
    nil,
    common[5]
  },
  [4010117] = {
    4010117,
    900,
    2,
    "str_homeland_petbubble_1100",
    common[4],
    nil,
    common[5]
  },
  [4010118] = {
    4010118,
    900,
    2,
    "str_homeland_petbubble_1101",
    common[4],
    nil,
    common[5]
  },
  [4010119] = {
    4010119,
    900,
    2,
    "str_homeland_petbubble_1102",
    common[4],
    nil,
    common[5]
  },
  [4010120] = {
    4010120,
    900,
    2,
    "str_homeland_petbubble_1103",
    common[4],
    nil,
    common[5]
  },
  [4010121] = {
    4010121,
    900,
    2,
    "str_homeland_petbubble_1104",
    common[4],
    nil,
    common[5]
  },
  [4010122] = {
    4010122,
    900,
    2,
    "str_homeland_petbubble_1105",
    common[4],
    nil,
    common[5]
  },
  [4010123] = {
    4010123,
    900,
    2,
    "str_homeland_petbubble_1106",
    common[4],
    nil,
    common[5]
  },
  [4010124] = {
    4010124,
    900,
    2,
    "str_homeland_petbubble_1107",
    common[4],
    nil,
    common[5]
  },
  [4010125] = {
    4010125,
    900,
    2,
    "str_homeland_petbubble_1108",
    common[4],
    nil,
    common[5]
  },
  [4010126] = {
    4010126,
    900,
    2,
    "str_homeland_petbubble_1109",
    common[4],
    nil,
    common[5]
  },
  [4010127] = {
    4010127,
    900,
    2,
    "str_homeland_petbubble_1110",
    common[4],
    nil,
    common[5]
  },
  [4010128] = {
    4010128,
    900,
    2,
    "str_homeland_petbubble_1111",
    common[4],
    nil,
    common[5]
  },
  [4010129] = {
    4010129,
    900,
    2,
    "str_homeland_petbubble_1112",
    common[4],
    nil,
    common[5]
  },
  [4010130] = {
    4010130,
    900,
    2,
    "str_homeland_petbubble_1113",
    common[4],
    nil,
    common[5]
  },
  [4010131] = {
    4010131,
    900,
    2,
    "str_homeland_petbubble_1114",
    common[4],
    nil,
    common[5]
  },
  [4010132] = {
    4010132,
    900,
    2,
    "str_homeland_petbubble_1115",
    common[4],
    nil,
    common[5]
  },
  [4010133] = {
    4010133,
    900,
    2,
    "str_homeland_petbubble_1116",
    common[4],
    nil,
    common[5]
  },
  [4010134] = {
    4010134,
    900,
    2,
    "str_homeland_petbubble_1117",
    common[4],
    nil,
    common[5]
  },
  [4010135] = {
    4010135,
    900,
    2,
    "str_homeland_petbubble_1118",
    common[4],
    nil,
    common[5]
  },
  [4010136] = {
    4010136,
    900,
    2,
    "str_homeland_petbubble_1119",
    common[4],
    nil,
    common[5]
  },
  [4010137] = {
    4010137,
    900,
    2,
    "str_homeland_petbubble_1120",
    common[4],
    nil,
    common[5]
  },
  [4010138] = {
    4010138,
    900,
    2,
    "str_homeland_petbubble_1121",
    common[4],
    nil,
    common[5]
  },
  [4010139] = {
    4010139,
    900,
    2,
    "str_homeland_petbubble_1122",
    common[4],
    nil,
    common[5]
  },
  [4010140] = {
    4010140,
    900,
    2,
    "str_homeland_petbubble_1123",
    common[4],
    nil,
    common[5]
  },
  [4010141] = {
    4010141,
    900,
    2,
    "str_homeland_petbubble_1124",
    common[4],
    nil,
    common[5]
  },
  [4010142] = {
    4010142,
    900,
    2,
    "str_homeland_petbubble_1125",
    common[4],
    nil,
    common[5]
  },
  [4010143] = {
    4010143,
    900,
    2,
    "str_homeland_petbubble_1126",
    common[4],
    nil,
    common[5]
  },
  [4010144] = {
    4010144,
    900,
    2,
    "str_homeland_petbubble_1127",
    common[4],
    nil,
    common[5]
  },
  [4010145] = {
    4010145,
    900,
    2,
    "str_homeland_petbubble_1128",
    common[4],
    nil,
    common[5]
  },
  [4010146] = {
    4010146,
    900,
    2,
    "str_homeland_petbubble_1129",
    common[4],
    nil,
    common[5]
  },
  [4010147] = {
    4010147,
    900,
    2,
    "str_homeland_petbubble_1130",
    common[4],
    nil,
    common[5]
  },
  [4010148] = {
    4010148,
    900,
    2,
    "str_homeland_petbubble_1131",
    common[4],
    nil,
    common[5]
  },
  [4010149] = {
    4010149,
    900,
    2,
    "str_homeland_petbubble_1132",
    common[4],
    nil,
    common[5]
  },
  [4010150] = {
    4010150,
    900,
    2,
    "str_homeland_petbubble_1133",
    common[4],
    nil,
    common[5]
  },
  [4010151] = {
    4010151,
    900,
    2,
    "str_homeland_petbubble_1134",
    common[4],
    nil,
    common[5]
  },
  [4010152] = {
    4010152,
    900,
    2,
    "str_homeland_petbubble_1135",
    common[4],
    nil,
    common[5]
  },
  [4010153] = {
    4010153,
    900,
    2,
    "str_homeland_petbubble_1136",
    common[4],
    nil,
    common[5]
  },
  [4010154] = {
    4010154,
    900,
    2,
    "str_homeland_petbubble_1137",
    common[4],
    nil,
    common[5]
  },
  [4010155] = {
    4010155,
    900,
    2,
    "str_homeland_petbubble_1138",
    common[4],
    nil,
    common[5]
  },
  [4010156] = {
    4010156,
    900,
    2,
    "str_homeland_petbubble_1139",
    common[4],
    nil,
    common[5]
  },
  [4010157] = {
    4010157,
    900,
    2,
    "str_homeland_petbubble_1140",
    common[4],
    nil,
    common[5]
  },
  [4010158] = {
    4010158,
    900,
    2,
    "str_homeland_petbubble_1141",
    common[4],
    nil,
    common[5]
  },
  [4010159] = {
    4010159,
    900,
    2,
    "str_homeland_petbubble_1142",
    common[4],
    nil,
    common[5]
  },
  [4010160] = {
    4010160,
    900,
    2,
    "str_homeland_petbubble_1143",
    common[4],
    nil,
    common[5]
  },
  [4010161] = {
    4010161,
    900,
    2,
    "str_homeland_petbubble_1144",
    common[4],
    nil,
    common[5]
  },
  [4010162] = {
    4010162,
    900,
    2,
    "str_homeland_petbubble_1145",
    common[4],
    nil,
    common[5]
  },
  [4010163] = {
    4010163,
    900,
    2,
    "str_homeland_petbubble_1146",
    common[4],
    nil,
    common[5]
  },
  [4010164] = {
    4010164,
    900,
    2,
    "str_homeland_petbubble_1147",
    common[4],
    nil,
    common[5]
  },
  [4010165] = {
    4010165,
    900,
    2,
    "str_homeland_petbubble_1148",
    common[4],
    nil,
    common[5]
  },
  [4010166] = {
    4010166,
    900,
    2,
    "str_homeland_petbubble_1149",
    common[4],
    nil,
    common[5]
  },
  [4010167] = {
    4010167,
    900,
    2,
    "str_homeland_petbubble_1150",
    common[4],
    nil,
    common[5]
  },
  [4010168] = {
    4010168,
    900,
    2,
    "str_homeland_petbubble_1151",
    common[4],
    nil,
    common[5]
  },
  [4010169] = {
    4010169,
    900,
    2,
    "str_homeland_petbubble_1152",
    common[4],
    nil,
    common[5]
  },
  [4010170] = {
    4010170,
    900,
    2,
    "str_homeland_petbubble_1153",
    common[4],
    nil,
    common[5]
  },
  [4010171] = {
    4010171,
    900,
    2,
    "str_homeland_petbubble_1154",
    common[4],
    nil,
    common[5]
  },
  [4010172] = {
    4010172,
    900,
    2,
    "str_homeland_petbubble_1155",
    common[4],
    nil,
    common[5]
  },
  [4010173] = {
    4010173,
    900,
    2,
    "str_homeland_petbubble_1156",
    common[4],
    nil,
    common[5]
  },
  [4010174] = {
    4010174,
    900,
    2,
    "str_homeland_petbubble_1157",
    common[4],
    nil,
    common[5]
  },
  [4010175] = {
    4010175,
    900,
    2,
    "str_homeland_petbubble_1158",
    common[4],
    nil,
    common[5]
  },
  [4010176] = {
    4010176,
    900,
    2,
    "str_homeland_petbubble_1159",
    common[4],
    nil,
    common[5]
  },
  [4010177] = {
    4010177,
    900,
    2,
    "str_homeland_petbubble_1160",
    common[4],
    nil,
    common[5]
  },
  [4010178] = {
    4010178,
    900,
    2,
    "str_homeland_petbubble_1161",
    common[4],
    nil,
    common[5]
  },
  [4010179] = {
    4010179,
    900,
    2,
    "str_homeland_petbubble_1162",
    common[4],
    nil,
    common[5]
  },
  [4010180] = {
    4010180,
    900,
    2,
    "str_homeland_petbubble_1163",
    common[4],
    nil,
    common[5]
  },
  [4010181] = {
    4010181,
    900,
    2,
    "str_homeland_petbubble_1164",
    common[4],
    nil,
    common[5]
  },
  [4010182] = {
    4010182,
    900,
    2,
    "str_homeland_petbubble_1165",
    common[4],
    nil,
    common[5]
  },
  [4010183] = {
    4010183,
    900,
    2,
    "str_homeland_petbubble_1166",
    common[4],
    nil,
    common[5]
  },
  [4010184] = {
    4010184,
    900,
    2,
    "str_homeland_petbubble_1167",
    common[4],
    nil,
    common[5]
  },
  [4010185] = {
    4010185,
    900,
    2,
    "str_homeland_petbubble_1168",
    common[4],
    nil,
    common[5]
  },
  [4010186] = {
    4010186,
    900,
    2,
    "str_homeland_petbubble_1169",
    common[4],
    nil,
    common[5]
  },
  [4010187] = {
    4010187,
    900,
    2,
    "str_homeland_petbubble_1170",
    common[4],
    nil,
    common[5]
  },
  [4010188] = {
    4010188,
    900,
    2,
    "str_homeland_petbubble_1171",
    common[4],
    nil,
    common[5]
  },
  [4010189] = {
    4010189,
    900,
    2,
    "str_homeland_petbubble_1172",
    common[4],
    nil,
    common[5]
  },
  [4010190] = {
    4010190,
    900,
    2,
    "str_homeland_petbubble_1173",
    common[4],
    nil,
    common[5]
  },
  [4010191] = {
    4010191,
    900,
    2,
    "str_homeland_petbubble_1175",
    common[4],
    nil,
    common[5]
  },
  [4010192] = {
    4010192,
    900,
    2,
    "str_homeland_petbubble_1176",
    common[4],
    nil,
    common[5]
  },
  [4010193] = {
    4010193,
    900,
    2,
    "str_homeland_petbubble_1177",
    common[4],
    nil,
    common[5]
  },
  [4010194] = {
    4010194,
    900,
    2,
    "str_homeland_petbubble_1178",
    common[4],
    nil,
    common[5]
  },
  [4010195] = {
    4010195,
    900,
    2,
    "str_homeland_petbubble_1179",
    common[4],
    nil,
    common[5]
  },
  [4010196] = {
    4010196,
    900,
    2,
    "str_homeland_petbubble_1180",
    common[4],
    nil,
    common[5]
  },
  [4010197] = {
    4010197,
    900,
    2,
    "str_homeland_petbubble_1181",
    common[4],
    nil,
    common[5]
  },
  [4010198] = {
    4010198,
    900,
    2,
    "str_homeland_petbubble_1182",
    common[4],
    nil,
    common[5]
  },
  [4010199] = {
    4010199,
    900,
    2,
    "str_homeland_petbubble_1183",
    common[4],
    nil,
    common[5]
  },
  [4010200] = {
    4010200,
    900,
    2,
    "str_homeland_petbubble_1184",
    common[4],
    nil,
    common[5]
  },
  [4010201] = {
    4010201,
    900,
    2,
    "str_homeland_petbubble_1185",
    common[4],
    nil,
    common[5]
  },
  [4010202] = {
    4010202,
    900,
    2,
    "str_homeland_petbubble_1186",
    common[4],
    nil,
    common[5]
  },
  [4010203] = {
    4010203,
    900,
    2,
    "str_homeland_petbubble_1187",
    common[4],
    nil,
    common[5]
  },
  [4010204] = {
    4010204,
    900,
    2,
    "str_homeland_petbubble_1188",
    common[4],
    nil,
    common[5]
  },
  [4010205] = {
    4010205,
    900,
    2,
    "str_homeland_petbubble_1189",
    common[4],
    nil,
    common[5]
  },
  [4010206] = {
    4010206,
    900,
    2,
    "str_homeland_petbubble_1190",
    common[4],
    nil,
    common[5]
  },
  [4010207] = {
    4010207,
    900,
    2,
    "str_homeland_petbubble_1191",
    common[4],
    nil,
    common[5]
  },
  [4010208] = {
    4010208,
    900,
    2,
    "str_homeland_petbubble_1192",
    common[4],
    nil,
    common[5]
  },
  [4030002] = {
    4030002,
    5000,
    2,
    "str_homeland_petbubble_2002",
    common[4],
    nil,
    common[5]
  },
  [4030003] = {
    4030003,
    5000,
    2,
    "str_homeland_petbubble_2003",
    common[4],
    nil,
    common[5]
  },
  [4030004] = {
    4030004,
    5000,
    2,
    "str_homeland_petbubble_2004",
    common[4],
    nil,
    common[5]
  },
  [4030005] = {
    4030005,
    5000,
    2,
    "str_homeland_petbubble_2005",
    common[4],
    nil,
    common[5]
  },
  [4030006] = {
    4030006,
    5000,
    2,
    "str_homeland_petbubble_2006",
    common[4],
    nil,
    common[5]
  },
  [4030007] = {
    4030007,
    5000,
    2,
    "str_homeland_petbubble_2007",
    common[4],
    nil,
    common[5]
  },
  [4030008] = {
    4030008,
    5000,
    2,
    "str_homeland_petbubble_2008",
    common[4],
    nil,
    common[5]
  },
  [4030009] = {
    4030009,
    5000,
    2,
    "str_homeland_petbubble_2009",
    common[4],
    nil,
    common[5]
  },
  [4030010] = {
    4030010,
    5000,
    2,
    "str_homeland_petbubble_2010",
    common[4],
    nil,
    common[5]
  },
  [4030011] = {
    4030011,
    5000,
    2,
    "str_homeland_petbubble_2011",
    common[4],
    nil,
    common[5]
  },
  [4030012] = {
    4030012,
    5000,
    2,
    "str_homeland_petbubble_2012",
    common[4],
    nil,
    common[5]
  },
  [4030013] = {
    4030013,
    5000,
    2,
    "str_homeland_petbubble_2013",
    common[4],
    nil,
    common[5]
  },
  [4030014] = {
    4030014,
    5000,
    2,
    "str_homeland_petbubble_2014",
    common[4],
    nil,
    common[5]
  },
  [4030015] = {
    4030015,
    5000,
    2,
    "str_homeland_petbubble_2015",
    common[4],
    nil,
    common[5]
  },
  [4030016] = {
    4030016,
    5000,
    2,
    "str_homeland_petbubble_2016",
    common[4],
    nil,
    common[5]
  },
  [4030017] = {
    4030017,
    5000,
    2,
    "str_homeland_petbubble_2017",
    common[4],
    nil,
    common[5]
  },
  [4030018] = {
    4030018,
    5000,
    2,
    "str_homeland_petbubble_2018",
    common[4],
    nil,
    common[5]
  },
  [4030019] = {
    4030019,
    5000,
    2,
    "str_homeland_petbubble_2019",
    common[4],
    nil,
    common[5]
  },
  [4030020] = {
    4030020,
    5000,
    2,
    "str_homeland_petbubble_2020",
    common[4],
    nil,
    common[5]
  },
  [4030021] = {
    4030021,
    5000,
    2,
    "str_homeland_petbubble_2021",
    common[4],
    nil,
    common[5]
  },
  [4030022] = {
    4030022,
    5000,
    2,
    "str_homeland_petbubble_2022",
    common[4],
    nil,
    common[5]
  },
  [4030023] = {
    4030023,
    5000,
    2,
    "str_homeland_petbubble_2023",
    common[4],
    nil,
    common[5]
  },
  [4030024] = {
    4030024,
    5000,
    2,
    "str_homeland_petbubble_2024",
    common[4],
    nil,
    common[5]
  },
  [4030025] = {
    4030025,
    5000,
    2,
    "str_homeland_petbubble_2025",
    common[4],
    nil,
    common[5]
  },
  [4030026] = {
    4030026,
    5000,
    2,
    "str_homeland_petbubble_2026",
    common[4],
    nil,
    common[5]
  },
  [4030027] = {
    4030027,
    5000,
    2,
    "str_homeland_petbubble_2027",
    common[4],
    nil,
    common[5]
  },
  [4030028] = {
    4030028,
    5000,
    2,
    "str_homeland_petbubble_2028",
    common[4],
    nil,
    common[5]
  },
  [4030029] = {
    4030029,
    5000,
    2,
    "str_homeland_petbubble_2029",
    common[4],
    nil,
    common[5]
  },
  [4030030] = {
    4030030,
    5000,
    2,
    "str_homeland_petbubble_2030",
    common[4],
    nil,
    common[5]
  },
  [4030031] = {
    4030031,
    5000,
    2,
    "str_homeland_petbubble_2031",
    common[4],
    nil,
    common[5]
  },
  [4030032] = {
    4030032,
    5000,
    2,
    "str_homeland_petbubble_2032",
    common[4],
    nil,
    common[5]
  },
  [4030033] = {
    4030033,
    5000,
    2,
    "str_homeland_petbubble_2033",
    common[4],
    nil,
    common[5]
  },
  [4030034] = {
    4030034,
    5000,
    2,
    "str_homeland_petbubble_2034",
    common[4],
    nil,
    common[5]
  },
  [4030035] = {
    4030035,
    5000,
    2,
    "str_homeland_petbubble_2035",
    common[4],
    nil,
    common[5]
  },
  [4030036] = {
    4030036,
    5000,
    2,
    "str_homeland_petbubble_2036",
    common[4],
    nil,
    common[5]
  },
  [4030037] = {
    4030037,
    5000,
    2,
    "str_homeland_petbubble_2037",
    common[4],
    nil,
    common[5]
  },
  [4030038] = {
    4030038,
    5000,
    2,
    "str_homeland_petbubble_2038",
    common[4],
    nil,
    common[5]
  },
  [4030039] = {
    4030039,
    5000,
    2,
    "str_homeland_petbubble_2039",
    common[4],
    nil,
    common[5]
  },
  [4030040] = {
    4030040,
    5000,
    2,
    "str_homeland_petbubble_2040",
    common[4],
    nil,
    common[5]
  },
  [4030041] = {
    4030041,
    5000,
    2,
    "str_homeland_petbubble_2041",
    common[4],
    nil,
    common[5]
  },
  [4030042] = {
    4030042,
    5000,
    2,
    "str_homeland_petbubble_2042",
    common[4],
    nil,
    common[5]
  },
  [4030043] = {
    4030043,
    5000,
    2,
    "str_homeland_petbubble_2043",
    common[4],
    nil,
    common[5]
  },
  [4030044] = {
    4030044,
    5000,
    2,
    "str_homeland_petbubble_2044",
    common[4],
    nil,
    common[5]
  },
  [4030045] = {
    4030045,
    5000,
    2,
    "str_homeland_petbubble_2045",
    common[4],
    nil,
    common[5]
  },
  [4030046] = {
    4030046,
    5000,
    2,
    "str_homeland_petbubble_2046",
    common[4],
    nil,
    common[5]
  },
  [4030047] = {
    4030047,
    5000,
    2,
    "str_homeland_petbubble_2047",
    common[4],
    nil,
    common[5]
  },
  [4030048] = {
    4030048,
    5000,
    2,
    "str_homeland_petbubble_2048",
    common[4],
    nil,
    common[5]
  },
  [4030049] = {
    4030049,
    5000,
    2,
    "str_homeland_petbubble_2049",
    common[4],
    nil,
    common[5]
  },
  [4030050] = {
    4030050,
    5000,
    2,
    "str_homeland_petbubble_2050",
    common[4],
    nil,
    common[5]
  },
  [4030051] = {
    4030051,
    5000,
    2,
    "str_homeland_petbubble_2051",
    common[4],
    nil,
    common[5]
  },
  [4030052] = {
    4030052,
    5000,
    2,
    "str_homeland_petbubble_2052",
    common[4],
    nil,
    common[5]
  },
  [4030053] = {
    4030053,
    5000,
    2,
    "str_homeland_petbubble_2053",
    common[4],
    nil,
    common[5]
  },
  [4030054] = {
    4030054,
    5000,
    2,
    "str_homeland_petbubble_2054",
    common[4],
    nil,
    common[5]
  },
  [4030055] = {
    4030055,
    5000,
    2,
    "str_homeland_petbubble_2055",
    common[4],
    nil,
    common[5]
  },
  [4030056] = {
    4030056,
    5000,
    2,
    "str_homeland_petbubble_2056",
    common[4],
    nil,
    common[5]
  },
  [4030057] = {
    4030057,
    5000,
    2,
    "str_homeland_petbubble_2057",
    common[4],
    nil,
    common[5]
  },
  [4030058] = {
    4030058,
    5000,
    2,
    "str_homeland_petbubble_2058",
    common[4],
    nil,
    common[5]
  },
  [4030059] = {
    4030059,
    5000,
    2,
    "str_homeland_petbubble_2059",
    common[4],
    nil,
    common[5]
  },
  [4030060] = {
    4030060,
    5000,
    2,
    "str_homeland_petbubble_2060",
    common[4],
    nil,
    common[5]
  },
  [4030061] = {
    4030061,
    5000,
    2,
    "str_homeland_petbubble_2061",
    common[4],
    nil,
    common[5]
  },
  [4030062] = {
    4030062,
    5000,
    2,
    "str_homeland_petbubble_2062",
    common[4],
    nil,
    common[5]
  },
  [4030063] = {
    4030063,
    5000,
    2,
    "str_homeland_petbubble_2063",
    common[4],
    nil,
    common[5]
  },
  [4030064] = {
    4030064,
    5000,
    2,
    "str_homeland_petbubble_2064",
    common[4],
    nil,
    common[5]
  },
  [4030065] = {
    4030065,
    5000,
    2,
    "str_homeland_petbubble_2065",
    common[4],
    nil,
    common[5]
  },
  [4030066] = {
    4030066,
    5000,
    2,
    "str_homeland_petbubble_2066",
    common[4],
    nil,
    common[5]
  },
  [4030067] = {
    4030067,
    5000,
    2,
    "str_homeland_petbubble_2067",
    common[4],
    nil,
    common[5]
  },
  [4030068] = {
    4030068,
    5000,
    2,
    "str_homeland_petbubble_2068",
    common[4],
    nil,
    common[5]
  },
  [4030069] = {
    4030069,
    5000,
    2,
    "str_homeland_petbubble_2069",
    common[4],
    nil,
    common[5]
  },
  [4030070] = {
    4030070,
    5000,
    2,
    "str_homeland_petbubble_2070",
    common[4],
    nil,
    common[5]
  },
  [4030071] = {
    4030071,
    5000,
    2,
    "str_homeland_petbubble_2071",
    common[4],
    nil,
    common[5]
  },
  [4030072] = {
    4030072,
    5000,
    2,
    "str_homeland_petbubble_2072",
    common[4],
    nil,
    common[5]
  },
  [4030073] = {
    4030073,
    5000,
    2,
    "str_homeland_petbubble_2073",
    common[4],
    nil,
    common[5]
  },
  [4030074] = {
    4030074,
    5000,
    2,
    "str_homeland_petbubble_2074",
    common[4],
    nil,
    common[5]
  },
  [4030075] = {
    4030075,
    5000,
    2,
    "str_homeland_petbubble_2075",
    common[4],
    nil,
    common[5]
  },
  [4030076] = {
    4030076,
    5000,
    2,
    "str_homeland_petbubble_2076",
    common[4],
    nil,
    common[5]
  },
  [4030077] = {
    4030077,
    5000,
    2,
    "str_homeland_petbubble_2077",
    common[4],
    nil,
    common[5]
  },
  [4030078] = {
    4030078,
    5000,
    2,
    "str_homeland_petbubble_2078",
    common[4],
    nil,
    common[5]
  },
  [4030079] = {
    4030079,
    5000,
    2,
    "str_homeland_petbubble_2079",
    common[4],
    nil,
    common[5]
  },
  [4030080] = {
    4030080,
    5000,
    2,
    "str_homeland_petbubble_2080",
    common[4],
    nil,
    common[5]
  },
  [4030081] = {
    4030081,
    5000,
    2,
    "str_homeland_petbubble_2081",
    common[4],
    nil,
    common[5]
  },
  [4030082] = {
    4030082,
    5000,
    2,
    "str_homeland_petbubble_2082",
    common[4],
    nil,
    common[5]
  },
  [4030083] = {
    4030083,
    5000,
    2,
    "str_homeland_petbubble_2083",
    common[4],
    nil,
    common[5]
  },
  [4030084] = {
    4030084,
    5000,
    2,
    "str_homeland_petbubble_2084",
    common[4],
    nil,
    common[5]
  },
  [4030085] = {
    4030085,
    5000,
    2,
    "str_homeland_petbubble_2085",
    common[4],
    nil,
    common[5]
  },
  [4030086] = {
    4030086,
    5000,
    2,
    "str_homeland_petbubble_2086",
    common[4],
    nil,
    common[5]
  },
  [4030087] = {
    4030087,
    5000,
    2,
    "str_homeland_petbubble_2087",
    common[4],
    nil,
    common[5]
  },
  [4030088] = {
    4030088,
    5000,
    2,
    "str_homeland_petbubble_2088",
    common[4],
    nil,
    common[5]
  },
  [4030089] = {
    4030089,
    5000,
    2,
    "str_homeland_petbubble_2089",
    common[4],
    nil,
    common[5]
  },
  [4030090] = {
    4030090,
    5000,
    2,
    "str_homeland_petbubble_2090",
    common[4],
    nil,
    common[5]
  },
  [4030091] = {
    4030091,
    5000,
    2,
    "str_homeland_petbubble_2091",
    common[4],
    nil,
    common[5]
  },
  [4030092] = {
    4030092,
    5000,
    2,
    "str_homeland_petbubble_2092",
    common[4],
    nil,
    common[5]
  },
  [4030093] = {
    4030093,
    5000,
    2,
    "str_homeland_petbubble_2093",
    common[4],
    nil,
    common[5]
  },
  [4030094] = {
    4030094,
    5000,
    2,
    "str_homeland_petbubble_2094",
    common[4],
    nil,
    common[5]
  },
  [4030095] = {
    4030095,
    5000,
    2,
    "str_homeland_petbubble_2095",
    common[4],
    nil,
    common[5]
  },
  [4030096] = {
    4030096,
    5000,
    2,
    "str_homeland_petbubble_2096",
    common[4],
    nil,
    common[5]
  },
  [4030097] = {
    4030097,
    5000,
    2,
    "str_homeland_petbubble_2097",
    common[4],
    nil,
    common[5]
  },
  [4030098] = {
    4030098,
    5000,
    2,
    "str_homeland_petbubble_2098",
    common[4],
    nil,
    common[5]
  },
  [4030099] = {
    4030099,
    5000,
    2,
    "str_homeland_petbubble_2099",
    common[4],
    nil,
    common[5]
  },
  [4030100] = {
    4030100,
    5000,
    2,
    "str_homeland_petbubble_2100",
    common[4],
    nil,
    common[5]
  },
  [4030101] = {
    4030101,
    5000,
    2,
    "str_homeland_petbubble_2101",
    common[4],
    nil,
    common[5]
  },
  [4030102] = {
    4030102,
    5000,
    2,
    "str_homeland_petbubble_2102",
    common[4],
    nil,
    common[5]
  },
  [4030103] = {
    4030103,
    5000,
    2,
    "str_homeland_petbubble_2103",
    common[4],
    nil,
    common[5]
  },
  [4030104] = {
    4030104,
    5000,
    2,
    "str_homeland_petbubble_2104",
    common[4],
    nil,
    common[5]
  },
  [4030105] = {
    4030105,
    5000,
    2,
    "str_homeland_petbubble_2105",
    common[4],
    nil,
    common[5]
  },
  [4030106] = {
    4030106,
    5000,
    2,
    "str_homeland_petbubble_2106",
    common[4],
    nil,
    common[5]
  },
  [4030107] = {
    4030107,
    5000,
    2,
    "str_homeland_petbubble_2107",
    common[4],
    nil,
    common[5]
  },
  [4030108] = {
    4030108,
    5000,
    2,
    "str_homeland_petbubble_2108",
    common[4],
    nil,
    common[5]
  },
  [4030109] = {
    4030109,
    5000,
    2,
    "str_homeland_petbubble_2109",
    common[4],
    nil,
    common[5]
  },
  [4030110] = {
    4030110,
    5000,
    2,
    "str_homeland_petbubble_2110",
    common[4],
    nil,
    common[5]
  },
  [4030111] = {
    4030111,
    5000,
    2,
    "str_homeland_petbubble_2111",
    common[4],
    nil,
    common[5]
  },
  [4030112] = {
    4030112,
    5000,
    2,
    "str_homeland_petbubble_2112",
    common[4],
    nil,
    common[5]
  },
  [4030113] = {
    4030113,
    5000,
    2,
    "str_homeland_petbubble_2113",
    common[4],
    nil,
    common[5]
  },
  [4030114] = {
    4030114,
    5000,
    2,
    "str_homeland_petbubble_2114",
    common[4],
    nil,
    common[5]
  },
  [4030115] = {
    4030115,
    5000,
    2,
    "str_homeland_petbubble_2115",
    common[4],
    nil,
    common[5]
  },
  [4030116] = {
    4030116,
    5000,
    2,
    "str_homeland_petbubble_2116",
    common[4],
    nil,
    common[5]
  },
  [4030117] = {
    4030117,
    5000,
    2,
    "str_homeland_petbubble_2117",
    common[4],
    nil,
    common[5]
  },
  [4030118] = {
    4030118,
    5000,
    2,
    "str_homeland_petbubble_2118",
    common[4],
    nil,
    common[5]
  },
  [4030119] = {
    4030119,
    5000,
    2,
    "str_homeland_petbubble_2119",
    common[4],
    nil,
    common[5]
  },
  [4030120] = {
    4030120,
    5000,
    2,
    "str_homeland_petbubble_2120",
    common[4],
    nil,
    common[5]
  },
  [4030121] = {
    4030121,
    5000,
    2,
    "str_homeland_petbubble_2121",
    common[4],
    nil,
    common[5]
  },
  [4030122] = {
    4030122,
    5000,
    2,
    "str_homeland_petbubble_2122",
    common[4],
    nil,
    common[5]
  },
  [4030123] = {
    4030123,
    5000,
    2,
    "str_homeland_petbubble_2123",
    common[4],
    nil,
    common[5]
  },
  [4030124] = {
    4030124,
    5000,
    2,
    "str_homeland_petbubble_2124",
    common[4],
    nil,
    common[5]
  },
  [4030125] = {
    4030125,
    5000,
    2,
    "str_homeland_petbubble_2125",
    common[4],
    nil,
    common[5]
  },
  [4030126] = {
    4030126,
    5000,
    2,
    "str_homeland_petbubble_2126",
    common[4],
    nil,
    common[5]
  },
  [4030127] = {
    4030127,
    5000,
    2,
    "str_homeland_petbubble_2127",
    common[4],
    nil,
    common[5]
  },
  [4030128] = {
    4030128,
    5000,
    2,
    "str_homeland_petbubble_2128",
    common[4],
    nil,
    common[5]
  },
  [4030129] = {
    4030129,
    5000,
    2,
    "str_homeland_petbubble_2129",
    common[4],
    nil,
    common[5]
  },
  [4030130] = {
    4030130,
    5000,
    2,
    "str_homeland_petbubble_2130",
    common[4],
    nil,
    common[5]
  },
  [4030131] = {
    4030131,
    5000,
    2,
    "str_homeland_petbubble_2131",
    common[4],
    nil,
    common[5]
  },
  [4030132] = {
    4030132,
    5000,
    2,
    "str_homeland_petbubble_2132",
    common[4],
    nil,
    common[5]
  },
  [4030133] = {
    4030133,
    5000,
    2,
    "str_homeland_petbubble_2133",
    common[4],
    nil,
    common[5]
  },
  [4030134] = {
    4030134,
    5000,
    2,
    "str_homeland_petbubble_2134",
    common[4],
    nil,
    common[5]
  },
  [4030135] = {
    4030135,
    5000,
    2,
    "str_homeland_petbubble_2135",
    common[4],
    nil,
    common[5]
  },
  [4030136] = {
    4030136,
    5000,
    2,
    "str_homeland_petbubble_2136",
    common[4],
    nil,
    common[5]
  },
  [4030137] = {
    4030137,
    5000,
    2,
    "str_homeland_petbubble_2137",
    common[4],
    nil,
    common[5]
  },
  [4030138] = {
    4030138,
    5000,
    2,
    "str_homeland_petbubble_2138",
    common[4],
    nil,
    common[5]
  },
  [4030139] = {
    4030139,
    5000,
    2,
    "str_homeland_petbubble_2139",
    common[4],
    nil,
    common[5]
  },
  [4030140] = {
    4030140,
    5000,
    2,
    "str_homeland_petbubble_2140",
    common[4],
    nil,
    common[5]
  },
  [4030141] = {
    4030141,
    5000,
    2,
    "str_homeland_petbubble_2141",
    common[4],
    nil,
    common[5]
  },
  [4030142] = {
    4030142,
    5000,
    2,
    "str_homeland_petbubble_2142",
    common[4],
    nil,
    common[5]
  },
  [4030143] = {
    4030143,
    5000,
    2,
    "str_homeland_petbubble_2143",
    common[4],
    nil,
    common[5]
  },
  [4030144] = {
    4030144,
    5000,
    2,
    "str_homeland_petbubble_2144",
    common[4],
    nil,
    common[5]
  },
  [4030145] = {
    4030145,
    5000,
    2,
    "str_homeland_petbubble_2145",
    common[4],
    nil,
    common[5]
  },
  [4030146] = {
    4030146,
    5000,
    2,
    "str_homeland_petbubble_2146",
    common[4],
    nil,
    common[5]
  },
  [4030147] = {
    4030147,
    5000,
    2,
    "str_homeland_petbubble_2147",
    common[4],
    nil,
    common[5]
  },
  [4030148] = {
    4030148,
    5000,
    2,
    "str_homeland_petbubble_2148",
    common[4],
    nil,
    common[5]
  },
  [4030149] = {
    4030149,
    5000,
    2,
    "str_homeland_petbubble_2149",
    common[4],
    nil,
    common[5]
  },
  [4030150] = {
    4030150,
    5000,
    2,
    "str_homeland_petbubble_2150",
    common[4],
    nil,
    common[5]
  },
  [4030151] = {
    4030151,
    5000,
    2,
    "str_homeland_petbubble_2151",
    common[4],
    nil,
    common[5]
  },
  [4030152] = {
    4030152,
    5000,
    2,
    "str_homeland_petbubble_2152",
    common[4],
    nil,
    common[5]
  },
  [4030153] = {
    4030153,
    5000,
    2,
    "str_homeland_petbubble_2153",
    common[4],
    nil,
    common[5]
  },
  [4030154] = {
    4030154,
    5000,
    2,
    "str_homeland_petbubble_2154",
    common[4],
    nil,
    common[5]
  },
  [4030155] = {
    4030155,
    5000,
    2,
    "str_homeland_petbubble_2155",
    common[4],
    nil,
    common[5]
  },
  [4030156] = {
    4030156,
    5000,
    2,
    "str_homeland_petbubble_2156",
    common[4],
    nil,
    common[5]
  },
  [4030157] = {
    4030157,
    5000,
    2,
    "str_homeland_petbubble_2157",
    common[4],
    nil,
    common[5]
  },
  [4030158] = {
    4030158,
    5000,
    2,
    "str_homeland_petbubble_2158",
    common[4],
    nil,
    common[5]
  },
  [4030159] = {
    4030159,
    5000,
    2,
    "str_homeland_petbubble_2159",
    common[4],
    nil,
    common[5]
  },
  [4030160] = {
    4030160,
    5000,
    2,
    "str_homeland_petbubble_2160",
    common[4],
    nil,
    common[5]
  },
  [4030161] = {
    4030161,
    5000,
    2,
    "str_homeland_petbubble_2161",
    common[4],
    nil,
    common[5]
  },
  [4030162] = {
    4030162,
    5000,
    2,
    "str_homeland_petbubble_2162",
    common[4],
    nil,
    common[5]
  },
  [4030163] = {
    4030163,
    5000,
    2,
    "str_homeland_petbubble_2163",
    common[4],
    nil,
    common[5]
  },
  [4030164] = {
    4030164,
    5000,
    2,
    "str_homeland_petbubble_2164",
    common[4],
    nil,
    common[5]
  },
  [4030165] = {
    4030165,
    5000,
    2,
    "str_homeland_petbubble_2165",
    common[4],
    nil,
    common[5]
  },
  [4030166] = {
    4030166,
    5000,
    2,
    "str_homeland_petbubble_2166",
    common[4],
    nil,
    common[5]
  },
  [4030167] = {
    4030167,
    5000,
    2,
    "str_homeland_petbubble_2167",
    common[4],
    nil,
    common[5]
  },
  [4030168] = {
    4030168,
    5000,
    2,
    "str_homeland_petbubble_2168",
    common[4],
    nil,
    common[5]
  },
  [4030169] = {
    4030169,
    5000,
    2,
    "str_homeland_petbubble_2169",
    common[4],
    nil,
    common[5]
  },
  [4030170] = {
    4030170,
    5000,
    2,
    "str_homeland_petbubble_2170",
    common[4],
    nil,
    common[5]
  },
  [4030171] = {
    4030171,
    5000,
    2,
    "str_homeland_petbubble_2171",
    common[4],
    nil,
    common[5]
  },
  [4030172] = {
    4030172,
    5000,
    2,
    "str_homeland_petbubble_2172",
    common[4],
    nil,
    common[5]
  },
  [4030173] = {
    4030173,
    5000,
    2,
    "str_homeland_petbubble_2173",
    common[4],
    nil,
    common[5]
  },
  [4030174] = {
    4030174,
    5000,
    2,
    "str_homeland_petbubble_2174",
    common[4],
    nil,
    common[5]
  },
  [4030175] = {
    4030175,
    5000,
    2,
    "str_homeland_petbubble_2175",
    common[4],
    nil,
    common[5]
  },
  [4030176] = {
    4030176,
    5000,
    2,
    "str_homeland_petbubble_2176",
    common[4],
    nil,
    common[5]
  },
  [4030177] = {
    4030177,
    5000,
    2,
    "str_homeland_petbubble_2177",
    common[4],
    nil,
    common[5]
  },
  [4030178] = {
    4030178,
    5000,
    2,
    "str_homeland_petbubble_2178",
    common[4],
    nil,
    common[5]
  },
  [4030179] = {
    4030179,
    5000,
    2,
    "str_homeland_petbubble_2179",
    common[4],
    nil,
    common[5]
  },
  [4030180] = {
    4030180,
    5000,
    2,
    "str_homeland_petbubble_2180",
    common[4],
    nil,
    common[5]
  },
  [4030181] = {
    4030181,
    5000,
    2,
    "str_homeland_petbubble_2181",
    common[4],
    nil,
    common[5]
  },
  [4030182] = {
    4030182,
    5000,
    2,
    "str_homeland_petbubble_2182",
    common[4],
    nil,
    common[5]
  },
  [4030183] = {
    4030183,
    5000,
    2,
    "str_homeland_petbubble_2183",
    common[4],
    nil,
    common[5]
  },
  [4030184] = {
    4030184,
    5000,
    2,
    "str_homeland_petbubble_2184",
    common[4],
    nil,
    common[5]
  },
  [4030185] = {
    4030185,
    5000,
    2,
    "str_homeland_petbubble_2185",
    common[4],
    nil,
    common[5]
  },
  [4030186] = {
    4030186,
    5000,
    2,
    "str_homeland_petbubble_2186",
    common[4],
    nil,
    common[5]
  },
  [4030187] = {
    4030187,
    5000,
    2,
    "str_homeland_petbubble_2187",
    common[4],
    nil,
    common[5]
  },
  [4030188] = {
    4030188,
    5000,
    2,
    "str_homeland_petbubble_2188",
    common[4],
    nil,
    common[5]
  },
  [4030189] = {
    4030189,
    5000,
    2,
    "str_homeland_petbubble_2190",
    common[4],
    nil,
    common[5]
  },
  [4030190] = {
    4030190,
    5000,
    2,
    "str_homeland_petbubble_2191",
    common[4],
    nil,
    common[5]
  },
  [4030191] = {
    4030191,
    5000,
    2,
    "str_homeland_petbubble_2192",
    common[4],
    nil,
    common[5]
  },
  [4030192] = {
    4030192,
    5000,
    2,
    "str_homeland_petbubble_2193",
    common[4],
    nil,
    common[5]
  },
  [4030193] = {
    4030193,
    5000,
    2,
    "str_homeland_petbubble_2194",
    common[4],
    nil,
    common[5]
  },
  [4030194] = {
    4030194,
    5000,
    2,
    "str_homeland_petbubble_2195",
    common[4],
    nil,
    common[5]
  },
  [4030195] = {
    4030195,
    5000,
    2,
    "str_homeland_petbubble_2196",
    common[4],
    nil,
    common[5]
  },
  [4030196] = {
    4030196,
    5000,
    2,
    "str_homeland_petbubble_2197",
    common[4],
    nil,
    common[5]
  },
  [4030197] = {
    4030197,
    5000,
    2,
    "str_homeland_petbubble_2198",
    common[4],
    nil,
    common[5]
  },
  [4030198] = {
    4030198,
    5000,
    2,
    "str_homeland_petbubble_2199",
    common[4],
    nil,
    common[5]
  },
  [4030199] = {
    4030199,
    5000,
    2,
    "str_homeland_petbubble_2200",
    common[4],
    nil,
    common[5]
  },
  [4030200] = {
    4030200,
    5000,
    2,
    "str_homeland_petbubble_2201",
    common[4],
    nil,
    common[5]
  },
  [4030201] = {
    4030201,
    5000,
    2,
    "str_homeland_petbubble_2202",
    common[4],
    nil,
    common[5]
  },
  [4030202] = {
    4030202,
    5000,
    2,
    "str_homeland_petbubble_2203",
    common[4],
    nil,
    common[5]
  },
  [4030203] = {
    4030203,
    5000,
    2,
    "str_homeland_petbubble_2204",
    common[4],
    nil,
    common[5]
  },
  [4030204] = {
    4030204,
    5000,
    2,
    "str_homeland_petbubble_2205",
    common[4],
    nil,
    common[5]
  },
  [4030205] = {
    4030205,
    5000,
    2,
    "str_homeland_petbubble_2206",
    common[4],
    nil,
    common[5]
  },
  [4030206] = {
    4030206,
    5000,
    2,
    "str_homeland_petbubble_2207",
    common[4],
    nil,
    common[5]
  }
}
return config, "ID", key
