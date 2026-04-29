local key = {
  ID = 1,
  TargetType = 2,
  Notify = 3,
  Trigger = 4,
  Name = 5,
  Icon = 6,
  Desc = 7,
  TargetParam = 8,
  Logic = 9
}
local common = {
  "n11_juzd_buff02",
  {10},
  {9},
  {7},
  {6},
  {3},
  {2},
  {5},
  {4},
  {14},
  {
    {1}
  },
  {
    {11}
  },
  {
    {10}
  },
  {
    {
      13,
      5,
      3
    }
  },
  {
    {7, 3}
  },
  {
    {12, 1}
  },
  {
    [1] = {
      logic = "IncreaseProduction",
      incType = 2,
      fixVal = 0,
      perVal = 1
    }
  },
  {
    [1] = {
      logic = "IncreaseProduction",
      incType = 1,
      fixVal = 5,
      perVal = 0
    }
  },
  {count = 1},
  {
    [1] = {
      logic = "DestroyTarget"
    }
  },
  {
    [1] = {
      logic = "SetResType",
      resType = 3,
      value = 50
    }
  },
  {containSelf = 0},
  {
    [1] = {
      logic = "IncreaseProduction",
      incType = 2,
      fixVal = 0,
      perVal = 0.15
    }
  },
  {
    [1] = {
      logic = "IncreaseProduction",
      incType = 2,
      fixVal = 0,
      perVal = 0.2
    }
  },
  {posType = 1, containSelf = 0},
  {
    [1] = {
      logic = "IncreaseProduction",
      incType = 1,
      fixVal = 2,
      perVal = 0
    }
  },
  {
    [1] = {
      logic = "IncreaseProduction",
      incType = 1,
      fixVal = 3,
      perVal = 0
    }
  },
  {
    [1] = {
      logic = "IncreaseProduction",
      incType = 1,
      fixVal = 8,
      perVal = 0
    }
  },
  {
    [1] = {
      logic = "IncProByRandomMul",
      min = 50,
      max = 250
    }
  },
  {
    [1] = {
      logic = "TempZeroProduction",
      value = true
    }
  }
}
local config = {
  [104] = {
    104,
    1,
    common[2],
    common[11],
    "str_luckland_card_enemy_4",
    common[1],
    "str_luckland_buff_desc4",
    nil,
    {
      [1] = {
        logic = "SetTempValue",
        key = "DoubleAttack",
        value = true
      }
    }
  },
  [107] = {
    107,
    7,
    common[3],
    common[11],
    "str_luckland_card_enemy_7",
    common[1],
    "str_luckland_buff_desc7",
    nil,
    {
      [1] = {
        logic = "IncreaseProduction",
        incType = 2,
        fixVal = 5,
        perVal = 0
      }
    }
  },
  [110] = {
    110,
    1,
    common[4],
    common[11],
    "str_luckland_card_enemy_10",
    common[1],
    "str_luckland_buff_desc10",
    nil,
    common[17]
  },
  [111] = {
    111,
    1,
    common[2],
    common[11],
    "str_luckland_card_enemy_11",
    common[1],
    "str_luckland_buff_desc11",
    nil,
    common[18]
  },
  [112] = {
    112,
    4,
    common[3],
    common[11],
    "str_luckland_card_enemy_12",
    "n11_juzd_buff06",
    "str_luckland_buff_desc12",
    common[19],
    common[20]
  },
  [117] = {
    117,
    1,
    common[4],
    common[11],
    "str_luckland_card_enemy_17",
    "n11_juzd_buff01",
    "str_luckland_buff_desc17",
    nil,
    {
      [1] = {
        logic = "GenerateCard",
        type = 2,
        id = 101
      }
    }
  },
  [401] = {
    401,
    1,
    common[5],
    common[12],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "SetResType",
        resType = 3,
        value = 20
      }
    }
  },
  [402] = {
    402,
    1,
    common[5],
    common[12],
    nil,
    nil,
    nil,
    nil,
    common[21]
  },
  [403] = {
    403,
    1,
    common[5],
    common[12],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "SetResType",
        resType = 3,
        value = 90
      }
    }
  },
  [501] = {
    501,
    6,
    common[6],
    common[13],
    nil,
    nil,
    nil,
    common[22],
    {
      [1] = {
        logic = "IncreaseProduction",
        incType = 2,
        fixVal = 0,
        perVal = 0.1
      }
    }
  },
  [502] = {
    502,
    6,
    common[6],
    common[13],
    nil,
    nil,
    nil,
    common[22],
    common[23]
  },
  [503] = {
    503,
    6,
    common[6],
    common[13],
    nil,
    nil,
    nil,
    common[22],
    common[24]
  },
  [601] = {
    601,
    1,
    common[5],
    common[14],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "SetResType",
        resType = 3,
        value = 15
      }
    }
  },
  [602] = {
    602,
    1,
    common[5],
    common[14],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "SetResType",
        resType = 3,
        value = 30
      }
    }
  },
  [603] = {
    603,
    1,
    common[5],
    common[14],
    nil,
    nil,
    nil,
    nil,
    common[21]
  },
  [801] = {
    801,
    1,
    common[5],
    common[11],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "AddInterest",
        perVal = 0.03
      }
    }
  },
  [802] = {
    802,
    1,
    common[5],
    common[11],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "AddInterest",
        perVal = 0.05
      }
    }
  },
  [803] = {
    803,
    1,
    common[5],
    common[11],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "AddInterest",
        perVal = 0.07
      }
    }
  },
  [901] = {
    901,
    9,
    common[6],
    common[11],
    nil,
    nil,
    nil,
    common[25],
    common[23]
  },
  [902] = {
    902,
    9,
    common[6],
    common[11],
    nil,
    nil,
    nil,
    common[25],
    {
      [1] = {
        logic = "IncreaseProduction",
        incType = 2,
        fixVal = 0,
        perVal = 0.25
      }
    }
  },
  [903] = {
    903,
    9,
    common[6],
    common[11],
    nil,
    nil,
    nil,
    common[25],
    {
      [1] = {
        logic = "IncreaseProduction",
        incType = 2,
        fixVal = 0,
        perVal = 0.4
      }
    }
  },
  [1001] = {
    1001,
    4,
    common[6],
    common[11],
    nil,
    nil,
    nil,
    common[19],
    {
      [1] = {
        logic = "IncreaseProduction",
        incType = 1,
        fixVal = 1,
        perVal = 0
      }
    }
  },
  [1002] = {
    1002,
    4,
    common[6],
    common[11],
    nil,
    nil,
    nil,
    common[19],
    common[26]
  },
  [1003] = {
    1003,
    4,
    common[6],
    common[11],
    nil,
    nil,
    nil,
    common[19],
    common[27]
  },
  [1101] = {
    1101,
    1,
    common[4],
    common[11],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "SetTempValue",
        key = "ExtraDrawCard",
        value = true
      }
    }
  },
  [1120151] = {
    1120151,
    1,
    common[6],
    {
      {7, 1}
    },
    nil,
    nil,
    nil,
    nil,
    common[17]
  },
  [1120161] = {
    1120161,
    1,
    common[6],
    common[11],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "IncreaseProductionPet",
        id = 112016,
        incType = 2,
        fixVal = 0,
        perVal = 0.3
      }
    }
  },
  [1310241] = {
    1310241,
    1,
    common[6],
    common[11],
    nil,
    nil,
    nil,
    nil,
    common[26]
  },
  [1320521] = {
    1320521,
    2,
    common[7],
    common[11],
    nil,
    nil,
    nil,
    {
      tagList = {
        {type = 1, param = 2}
      }
    },
    common[24]
  },
  [1310531] = {
    1310531,
    2,
    common[7],
    common[11],
    nil,
    nil,
    nil,
    {
      tagList = {
        {type = 1, param = 4}
      }
    },
    common[24]
  },
  [1310541] = {
    1310541,
    2,
    common[7],
    common[11],
    nil,
    nil,
    nil,
    {
      tagList = {
        {type = 1, param = 3}
      }
    },
    common[24]
  },
  [1330561] = {
    1330561,
    2,
    common[7],
    common[11],
    nil,
    nil,
    nil,
    {
      tagList = {
        {type = 1, param = 1}
      }
    },
    common[24]
  },
  [1120141] = {
    1120141,
    1,
    common[4],
    common[11],
    nil,
    nil,
    nil,
    nil,
    common[20]
  },
  [1240091] = {
    1240091,
    1,
    common[6],
    {
      {
        3,
        121007,
        5,
        1
      }
    },
    nil,
    nil,
    nil,
    nil,
    common[17]
  },
  [1230071] = {
    1230071,
    1,
    common[6],
    {
      {
        3,
        121009,
        5,
        1
      }
    },
    nil,
    nil,
    nil,
    nil,
    common[17]
  },
  [1240221] = {
    1240221,
    2,
    common[7],
    common[11],
    nil,
    nil,
    nil,
    {
      tagList = {
        {type = 2, param = 1003}
      },
      isAnd = 0,
      containSelf = 0
    },
    common[26]
  },
  [1240222] = {
    1240222,
    1,
    common[4],
    common[11],
    nil,
    nil,
    nil,
    nil,
    common[20]
  },
  [1240261] = {
    1240261,
    1,
    common[6],
    {
      {7, 2}
    },
    nil,
    nil,
    nil,
    nil,
    common[17]
  },
  [1210281] = {
    1210281,
    1,
    common[6],
    common[15],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "IncreaseProduction",
        incType = 2,
        fixVal = 0,
        perVal = 2
      }
    }
  },
  [1220311] = {
    1220311,
    1,
    common[6],
    common[11],
    nil,
    nil,
    nil,
    nil,
    common[27]
  },
  [1220312] = {
    1220312,
    1,
    common[8],
    common[11],
    nil,
    nil,
    nil,
    nil,
    common[27]
  },
  [1220313] = {
    1220313,
    1,
    common[4],
    common[11],
    nil,
    nil,
    nil,
    nil,
    common[20]
  },
  [1320371] = {
    1320371,
    1,
    common[6],
    common[11],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "IncreaseProduction",
        incType = 1,
        fixVal = 10,
        perVal = 0
      },
      [2] = {
        logic = "IncreaseProduction",
        incType = 2,
        fixVal = 0,
        perVal = 1
      }
    }
  },
  [1230081] = {
    1230081,
    1,
    common[6],
    common[15],
    nil,
    nil,
    nil,
    nil,
    common[28]
  },
  [1230211] = {
    1230211,
    1,
    common[6],
    common[11],
    nil,
    nil,
    nil,
    nil,
    common[18]
  },
  [1240511] = {
    1240511,
    1,
    common[6],
    common[11],
    nil,
    nil,
    nil,
    nil,
    common[29]
  },
  [1130351] = {
    1130351,
    1,
    common[6],
    {
      {8}
    },
    nil,
    nil,
    nil,
    nil,
    common[30]
  },
  [1130352] = {
    1130352,
    1,
    common[6],
    {
      {9}
    },
    nil,
    nil,
    nil,
    nil,
    common[30]
  },
  [1130353] = {
    1130353,
    1,
    common[4],
    common[11],
    nil,
    nil,
    nil,
    nil,
    common[20]
  },
  [1330061] = {
    1330061,
    1,
    common[9],
    {
      {
        3,
        111001,
        3,
        0
      }
    },
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "GenerateCard",
        type = 1,
        id = 111001
      }
    }
  },
  [1320041] = {
    1320041,
    3,
    common[9],
    common[11],
    nil,
    nil,
    nil,
    {
      IDList = {111001}
    },
    {
      [1] = {
        logic = "DestroyTarget",
        incType = 1,
        fixVal = 12,
        perVal = 0
      }
    }
  },
  [1330181] = {
    1330181,
    2,
    common[9],
    common[11],
    nil,
    nil,
    nil,
    {
      tagList = {
        {type = 2, param = 1007}
      },
      isAnd = 0,
      containSelf = 0,
      dis = 4
    },
    {
      [1] = {
        logic = "DestroyTarget",
        incType = 1,
        fixVal = 10,
        perVal = 0
      }
    }
  },
  [1120191] = {
    1120191,
    1,
    common[6],
    common[11],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "IncreaseProductionEmptyPos",
        incType = 2,
        fixVal = 0,
        perVal = 0.2
      }
    }
  },
  [1320381] = {
    1320381,
    1,
    common[6],
    common[11],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "IncreaseProductionPet",
        id = 132040,
        incType = 2,
        fixVal = 0,
        perVal = 1
      }
    }
  },
  [1340401] = {
    1340401,
    1,
    common[6],
    common[11],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "IncreaseProductionPet",
        id = 131038,
        incType = 2,
        fixVal = 0,
        perVal = 1
      }
    }
  },
  [1330031] = {
    1330031,
    1,
    common[6],
    common[11],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "IncreaseProductionTagDistance",
        tagType = 2,
        tagParam = 1006,
        incType = 2,
        fixVal = 0,
        perVal = 0.15
      }
    }
  },
  [1110101] = {
    1110101,
    1,
    common[6],
    common[11],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "IncreaseProductionElement",
        incType = 1,
        fixVal = 4,
        perVal = 0
      }
    }
  },
  [1110481] = {
    1110481,
    1,
    common[6],
    common[11],
    nil,
    nil,
    nil,
    nil,
    common[26]
  },
  [1310491] = {
    1310491,
    1,
    {1},
    common[11],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "MoveTarget",
        moveType = "MoveToFirst",
        incType = 2,
        fixVal = 0,
        perVal = 0.2
      }
    }
  },
  [1130431] = {
    1130431,
    1,
    common[10],
    common[16],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {logic = "AddMoney", fixVal = 30}
    }
  },
  [1230441] = {
    1230441,
    1,
    common[4],
    common[11],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "IncreaseProduction",
        incType = 2,
        fixVal = 40,
        perVal = 0
      }
    }
  },
  [1220421] = {
    1220421,
    1,
    {13},
    common[11],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "GenerateCard",
        type = 1,
        id = 113043
      },
      [2] = {
        logic = "GenerateCard",
        type = 1,
        id = 113043
      },
      [3] = {
        logic = "GenerateCard",
        type = 1,
        id = 113043
      }
    }
  },
  [1230451] = {
    1230451,
    1,
    common[6],
    common[11],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "GenerateCard",
        type = 1,
        id = 113043
      },
      [2] = {
        logic = "DestroyTarget"
      }
    }
  },
  [1310411] = {
    1310411,
    2,
    common[9],
    common[11],
    nil,
    nil,
    nil,
    {
      tagList = {
        {type = 3, param = 1}
      },
      isAnd = 0,
      containSelf = 0,
      dis = 4
    },
    {
      [1] = {
        logic = "DestroyTarget",
        incType = 2,
        fixVal = 0,
        perVal = 1.5
      }
    }
  },
  [1330461] = {
    1330461,
    1,
    common[10],
    common[11],
    nil,
    nil,
    nil,
    nil,
    common[17]
  },
  [1100571] = {
    1100571,
    1,
    common[6],
    common[11],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "IncreaseProductionPet",
        id = 110058,
        incType = 2,
        fixVal = 0,
        perVal = 0.5
      }
    }
  },
  [1100581] = {
    1100581,
    1,
    common[6],
    common[11],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "IncreaseProductionPet",
        id = 110057,
        incType = 2,
        fixVal = 0,
        perVal = 0.5
      }
    }
  },
  [1210361] = {
    1210361,
    1,
    common[6],
    common[11],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "IncreaseProductionPet",
        id = 120059,
        incType = 1,
        fixVal = 2,
        perVal = 0
      }
    }
  },
  [1200591] = {
    1200591,
    1,
    common[6],
    common[11],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "IncreaseProductionPet",
        id = 121036,
        incType = 1,
        fixVal = 2,
        perVal = 0
      }
    }
  },
  [1100601] = {
    1100601,
    1,
    common[4],
    common[11],
    nil,
    nil,
    nil,
    nil,
    common[20]
  },
  [1220321] = {
    1220321,
    8,
    common[6],
    common[11],
    nil,
    nil,
    nil,
    {dis = 2, containSelf = 0},
    {
      [1] = {
        logic = "AddLifeCountDown",
        fixVal = 1
      }
    }
  },
  [1120251] = {
    1120251,
    1,
    {16},
    common[11],
    nil,
    nil,
    nil,
    nil,
    common[28]
  },
  [1120301] = {
    1120301,
    1,
    common[6],
    common[11],
    nil,
    nil,
    nil,
    nil,
    common[27]
  },
  [1120302] = {
    1120302,
    1,
    common[8],
    common[11],
    nil,
    nil,
    nil,
    nil,
    common[20]
  },
  [1320341] = {
    1320341,
    6,
    common[4],
    common[11],
    nil,
    nil,
    nil,
    common[22],
    {
      [1] = {
        logic = "AddLifeCountDown",
        fixVal = 3
      }
    }
  },
  [1320342] = {
    1320342,
    1,
    common[4],
    common[11],
    nil,
    nil,
    nil,
    nil,
    common[20]
  },
  [1110201] = {
    1110201,
    1,
    {15},
    common[11],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "AddMoney",
        fixVal = 60,
        addToTotal = true
      }
    }
  },
  [1110202] = {
    1110202,
    1,
    common[4],
    common[11],
    nil,
    nil,
    nil,
    nil,
    common[20]
  },
  [1320131] = {
    1320131,
    1,
    common[6],
    common[11],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "IncreaseProductionTag",
        tagType = 2,
        tagParam = 1002,
        containself = false,
        incType = 1,
        fixVal = 2,
        perVal = 0
      }
    }
  },
  [1110011] = {
    1110011,
    1,
    common[6],
    common[11],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "IncreaseProductionLossHp",
        coefficient = 1
      }
    }
  },
  [1130051] = {
    1130051,
    1,
    common[6],
    common[11],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "IncreaseProductionTagLink",
        tagType = 1,
        tagParam = 2,
        incType = 1,
        fixVal = 1,
        perVal = 0
      }
    }
  },
  [1310021] = {
    1310021,
    1,
    common[6],
    {
      {
        4,
        2,
        1006,
        2,
        5,
        2
      }
    },
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {logic = "AddMoney", fixVal = 100},
      [2] = {
        logic = "DestroyTarget"
      }
    }
  },
  [1230291] = {
    1230291,
    1,
    common[9],
    common[11],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "GetGoldByNeighbor",
        multiple = 1
      }
    }
  },
  [1230292] = {
    1230292,
    1,
    common[9],
    common[11],
    nil,
    nil,
    nil,
    nil,
    common[20]
  },
  [1300611] = {
    1300611,
    1,
    common[10],
    common[11],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "IncreaseProductionToDeleteSource",
        incType = 1,
        fixVal = 30,
        perVal = 0
      }
    }
  },
  [1220121] = {
    1220121,
    1,
    common[6],
    common[11],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "IncreaseProductionTagNeighbor",
        tagType = 1,
        tagParam = 1,
        distance = 1,
        incType = 1,
        fixVal = 1,
        perVal = 0
      }
    }
  },
  [1220122] = {
    1220122,
    1,
    common[6],
    common[11],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "IncreaseProductionTagNeighbor",
        tagType = 2,
        tagParam = 1002,
        distance = 1,
        incType = 1,
        fixVal = 1,
        perVal = 0
      }
    }
  },
  [1220171] = {
    1220171,
    1,
    common[4],
    common[11],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "GenerateCard",
        type = 1,
        id = 122017
      }
    }
  },
  [1320331] = {
    1320331,
    8,
    common[6],
    common[11],
    nil,
    nil,
    nil,
    {dis = 1, containSelf = 0},
    {
      [1] = {
        logic = "IncreaseProduction",
        incType = 2,
        fixVal = 0,
        perVal = 0.3
      }
    }
  },
  [1320332] = {
    1320332,
    1,
    common[4],
    common[11],
    nil,
    nil,
    nil,
    nil,
    common[20]
  },
  [1100621] = {
    1100621,
    1,
    common[4],
    common[11],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "IncreaseProduction",
        incType = 2,
        fixVal = 20,
        perVal = 0
      }
    }
  },
  [1100631] = {
    1100631,
    1,
    common[4],
    common[11],
    nil,
    nil,
    nil,
    nil,
    common[20]
  },
  [1100651] = {
    1100651,
    1,
    common[6],
    common[11],
    nil,
    nil,
    nil,
    nil,
    common[29]
  },
  [1100661] = {
    1100661,
    1,
    common[4],
    common[11],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "SetTempValue",
        key = "ExtraDrawCard",
        value = true
      },
      [2] = {
        logic = "DestroyTarget"
      }
    }
  },
  [1300671] = {
    1300671,
    2,
    common[7],
    common[11],
    nil,
    nil,
    nil,
    {
      tagList = {
        {type = 2, param = 1003}
      }
    },
    common[23]
  },
  [1200681] = {
    1200681,
    2,
    common[7],
    common[11],
    nil,
    nil,
    nil,
    {
      tagList = {
        {type = 2, param = 1004}
      },
      isAnd = 0,
      containSelf = 0,
      dis = 3
    },
    common[27]
  },
  [1200682] = {
    1200682,
    1,
    common[4],
    common[11],
    nil,
    nil,
    nil,
    nil,
    common[20]
  },
  [1300691] = {
    1300691,
    1,
    common[8],
    common[11],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "IncreaseProduction",
        incType = 1,
        fixVal = 20,
        perVal = 0
      }
    }
  },
  [1100701] = {
    1100701,
    1,
    common[10],
    common[16],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "GenerateCard",
        type = 1,
        id = 120068
      }
    }
  },
  [1100711] = {
    1100711,
    3,
    common[9],
    {
      {
        3,
        110071,
        5,
        3
      }
    },
    nil,
    nil,
    nil,
    {
      IDList = {110071},
      containSelf = 1
    },
    {
      [1] = {
        logic = "DestroyTarget"
      },
      [2] = {
        logic = "RandomCard",
        castNum = 3,
        cardPoolID = 1000
      }
    }
  },
  [1300721] = {
    1300721,
    1,
    common[6],
    common[11],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "IncreaseProductionPet",
        id = 130073,
        incType = 2,
        fixVal = 0,
        perVal = 0.25
      },
      [2] = {
        logic = "IncreaseProductionPet",
        id = 130074,
        incType = 2,
        fixVal = 0,
        perVal = 0.25
      },
      [3] = {
        logic = "IncreaseProductionPet",
        id = 130075,
        incType = 2,
        fixVal = 0,
        perVal = 0.25
      }
    }
  },
  [1300731] = {
    1300731,
    1,
    common[6],
    common[11],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "IncreaseProductionPet",
        id = 130072,
        incType = 2,
        fixVal = 0,
        perVal = 0.25
      },
      [2] = {
        logic = "IncreaseProductionPet",
        id = 130074,
        incType = 2,
        fixVal = 0,
        perVal = 0.25
      },
      [3] = {
        logic = "IncreaseProductionPet",
        id = 130075,
        incType = 2,
        fixVal = 0,
        perVal = 0.25
      }
    }
  },
  [1300741] = {
    1300741,
    1,
    common[6],
    common[11],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "IncreaseProductionPet",
        id = 130072,
        incType = 2,
        fixVal = 0,
        perVal = 0.25
      },
      [2] = {
        logic = "IncreaseProductionPet",
        id = 130073,
        incType = 2,
        fixVal = 0,
        perVal = 0.25
      },
      [3] = {
        logic = "IncreaseProductionPet",
        id = 130075,
        incType = 2,
        fixVal = 0,
        perVal = 0.25
      }
    }
  },
  [1300751] = {
    1300751,
    1,
    common[6],
    common[11],
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        logic = "IncreaseProductionPet",
        id = 130072,
        incType = 2,
        fixVal = 0,
        perVal = 0.25
      },
      [2] = {
        logic = "IncreaseProductionPet",
        id = 130073,
        incType = 2,
        fixVal = 0,
        perVal = 0.25
      },
      [3] = {
        logic = "IncreaseProductionPet",
        id = 130074,
        incType = 2,
        fixVal = 0,
        perVal = 0.25
      }
    }
  },
  [1200761] = {
    1200761,
    1,
    common[10],
    common[11],
    nil,
    nil,
    nil,
    nil,
    common[26]
  }
}
return config, "ID", key
