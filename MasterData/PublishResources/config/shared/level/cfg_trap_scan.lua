local key = {
  ID = 1,
  SortOrder = 2,
  Energy = 3,
  Name = 4,
  Desc = 5,
  Icon = 6,
  PetID = 7,
  PickUpScopeType = 8,
  PickUpInvalidScopeList = 9,
  GlobalMaxCount = 10,
  Buff = 11,
  PreviewList = 12
}
local common = {
  "str_skill_desc_1601751004",
  "str_skill_desc_160175104",
  "str_skill_desc_1601751005",
  "str_skill_desc_160175105",
  "str_skill_desc_1601751009",
  "str_skill_desc_160175109",
  "str_skill_desc_1601751006",
  "str_skill_desc_160175106",
  "str_skill_desc_1601751007",
  "str_skill_desc_160175107",
  "str_skill_desc_1601751008",
  "str_skill_desc_160175108",
  {
    [1] = {
      ScopeType = 4,
      ScopeParam = {0},
      TargetType = 5,
      ScopeCenterType = 1
    }
  },
  {
    [1] = {
      ScopeType = 36,
      ScopeParam = {},
      TargetType = 5,
      ScopeCenterType = 1
    }
  },
  {
    [1] = {
      ScopeType = 5,
      ScopeParam = {3},
      TargetType = 5,
      ScopeCenterType = 1,
      OnlyCanMove = true
    }
  },
  {
    [1] = {
      ScopeType = 31,
      ScopeParam = {},
      TargetType = 5,
      ScopeCenterType = 1
    },
    [2] = {
      ScopeType = 118,
      ScopeParam = {15014911, 15014912},
      TargetType = 5,
      ScopeCenterType = 1
    }
  },
  {
    [1] = {
      PreviewType = 0,
      Param = "30017533,30017532"
    }
  },
  {
    [1] = {
      ScopeType = 31,
      ScopeParam = {},
      TargetType = 5,
      ScopeCenterType = 1
    },
    [2] = {
      ScopeType = 118,
      ScopeParam = {8001651, 8001652},
      TargetType = 5,
      ScopeCenterType = 1
    }
  },
  {
    [1] = {
      ScopeType = 31,
      ScopeParam = {},
      TargetType = 5,
      ScopeCenterType = 1
    },
    [2] = {
      ScopeType = 118,
      ScopeParam = {
        2236,
        2237,
        22372,
        22373,
        22374
      },
      TargetType = 5,
      ScopeCenterType = 1
    }
  },
  {
    [1] = {
      ScopeType = 31,
      ScopeParam = {},
      TargetType = 5,
      ScopeCenterType = 1
    },
    [2] = {
      ScopeType = 118,
      ScopeParam = {
        2235,
        2238,
        22382,
        22383,
        22384,
        2239,
        22392,
        22393,
        22394
      },
      TargetType = 5,
      ScopeCenterType = 1
    }
  },
  {400080},
  {4001652},
  {160175115, 400080}
}
local config = {
  [62] = {
    62,
    1,
    2,
    "str_skill_desc_1601751001",
    "str_skill_desc_160175101",
    "head1_attice01",
    nil,
    common[13]
  },
  [621] = {
    621,
    2,
    3,
    "str_skill_desc_1601751002",
    "str_skill_desc_160175102",
    "head1_attice03",
    nil,
    common[13]
  },
  [2803501] = {
    2803501,
    3,
    2,
    "str_skill_desc_1601751010",
    "str_skill_desc_160175110",
    "head1_attice04",
    nil,
    common[13]
  },
  [16014511] = {
    16014511,
    4,
    2,
    "str_skill_desc_1601751003",
    "str_skill_desc_160175103",
    nil,
    1601451,
    common[14],
    {
      [1] = {
        ScopeType = 31,
        ScopeParam = {},
        TargetType = 5,
        ScopeCenterType = 1
      },
      [2] = {
        ScopeType = 118,
        ScopeParam = {16014511},
        TargetType = 5,
        ScopeCenterType = 1
      }
    }
  },
  [16015310] = {
    16015310,
    5,
    1,
    common[1],
    common[2],
    nil,
    1601531,
    common[13],
    {
      [1] = {
        ScopeType = 118,
        ScopeParam = {16015310},
        TargetType = 5,
        ScopeCenterType = 1
      }
    }
  },
  [16015311] = {
    16015311,
    6,
    1,
    common[1],
    common[2],
    nil,
    1601531,
    common[13],
    {
      [1] = {
        ScopeType = 118,
        ScopeParam = {16015311},
        TargetType = 5,
        ScopeCenterType = 1
      }
    }
  },
  [15014911] = {
    15014911,
    7,
    1,
    common[3],
    common[4],
    nil,
    1501491,
    common[15],
    common[16],
    5,
    nil,
    common[17]
  },
  [15014912] = {
    15014912,
    8,
    1,
    common[3],
    common[4],
    nil,
    1501491,
    common[15],
    common[16],
    5,
    nil,
    common[17]
  },
  [15020811] = {
    15020811,
    9,
    2,
    common[5],
    common[6],
    nil,
    1502081,
    common[14],
    {
      [1] = {
        ScopeType = 31,
        ScopeParam = {},
        TargetType = 5,
        ScopeCenterType = 1
      },
      [2] = {
        ScopeType = 118,
        ScopeParam = {15020811},
        TargetType = 5,
        ScopeCenterType = 1
      }
    },
    1,
    common[21]
  },
  [15020815] = {
    15020815,
    10,
    2,
    common[5],
    common[6],
    nil,
    1502081,
    common[14],
    {
      [1] = {
        ScopeType = 31,
        ScopeParam = {},
        TargetType = 5,
        ScopeCenterType = 1
      },
      [2] = {
        ScopeType = 118,
        ScopeParam = {15020815},
        TargetType = 5,
        ScopeCenterType = 1
      }
    },
    1,
    common[21]
  },
  [15120811] = {
    15120811,
    11,
    2,
    common[5],
    common[6],
    nil,
    1502081,
    common[14],
    {
      [1] = {
        ScopeType = 31,
        ScopeParam = {},
        TargetType = 5,
        ScopeCenterType = 1
      },
      [2] = {
        ScopeType = 118,
        ScopeParam = {15120811},
        TargetType = 5,
        ScopeCenterType = 1
      }
    },
    1,
    common[21]
  },
  [15120815] = {
    15120815,
    12,
    2,
    common[5],
    common[6],
    nil,
    1502081,
    common[14],
    {
      [1] = {
        ScopeType = 31,
        ScopeParam = {},
        TargetType = 5,
        ScopeCenterType = 1
      },
      [2] = {
        ScopeType = 118,
        ScopeParam = {15120815},
        TargetType = 5,
        ScopeCenterType = 1
      }
    },
    1,
    common[21]
  },
  [15220811] = {
    15220811,
    13,
    2,
    common[5],
    common[6],
    nil,
    1502081,
    common[14],
    {
      [1] = {
        ScopeType = 31,
        ScopeParam = {},
        TargetType = 5,
        ScopeCenterType = 1
      },
      [2] = {
        ScopeType = 118,
        ScopeParam = {15220811},
        TargetType = 5,
        ScopeCenterType = 1
      }
    },
    1,
    common[21]
  },
  [15220815] = {
    15220815,
    14,
    2,
    common[5],
    common[6],
    nil,
    1502081,
    common[14],
    {
      [1] = {
        ScopeType = 31,
        ScopeParam = {},
        TargetType = 5,
        ScopeCenterType = 1
      },
      [2] = {
        ScopeType = 118,
        ScopeParam = {15220815},
        TargetType = 5,
        ScopeCenterType = 1
      }
    },
    1,
    common[21]
  },
  [15320811] = {
    15320811,
    15,
    2,
    common[5],
    common[6],
    nil,
    1502081,
    common[14],
    {
      [1] = {
        ScopeType = 31,
        ScopeParam = {},
        TargetType = 5,
        ScopeCenterType = 1
      },
      [2] = {
        ScopeType = 118,
        ScopeParam = {15320811},
        TargetType = 5,
        ScopeCenterType = 1
      }
    },
    1,
    common[21]
  },
  [15320815] = {
    15320815,
    16,
    2,
    common[5],
    common[6],
    nil,
    1502081,
    common[14],
    {
      [1] = {
        ScopeType = 31,
        ScopeParam = {},
        TargetType = 5,
        ScopeCenterType = 1
      },
      [2] = {
        ScopeType = 118,
        ScopeParam = {15320815},
        TargetType = 5,
        ScopeCenterType = 1
      }
    },
    1,
    common[21]
  },
  [8001651] = {
    8001651,
    17,
    1,
    common[7],
    common[8],
    nil,
    1501651,
    common[14],
    common[18],
    nil,
    common[22]
  },
  [8001652] = {
    8001652,
    18,
    1,
    common[7],
    common[8],
    nil,
    1501651,
    common[14],
    common[18],
    nil,
    common[22]
  },
  [2236] = {
    2236,
    19,
    3,
    common[9],
    common[10],
    nil,
    1300581,
    common[14],
    common[19],
    1,
    {40017502}
  },
  [2237] = {
    2237,
    20,
    3,
    common[9],
    common[10],
    nil,
    1300581,
    common[14],
    common[19],
    1,
    {40017503}
  },
  [22372] = {
    22372,
    21,
    3,
    common[9],
    common[10],
    nil,
    1300581,
    common[14],
    common[19],
    1,
    {40017504}
  },
  [22373] = {
    22373,
    22,
    3,
    common[9],
    common[10],
    nil,
    1300581,
    common[14],
    common[19],
    1,
    {40017505}
  },
  [22374] = {
    22374,
    23,
    3,
    common[9],
    common[10],
    nil,
    1300581,
    common[14],
    common[19],
    1,
    {40017506}
  },
  [2235] = {
    2235,
    24,
    4,
    common[11],
    common[12],
    nil,
    1400541,
    common[14],
    common[20],
    1,
    common[23]
  },
  [2238] = {
    2238,
    25,
    4,
    common[11],
    common[12],
    nil,
    1400541,
    common[14],
    common[20],
    1,
    common[23]
  },
  [22382] = {
    22382,
    26,
    4,
    common[11],
    common[12],
    nil,
    1400541,
    {
      [1] = {
        ScopeType = 36,
        ScopeParam = {},
        TargetType = 5,
        ScopeCenterType = 1
      }
    },
    common[20],
    1,
    common[23]
  },
  [22383] = {
    22383,
    27,
    4,
    common[11],
    common[12],
    nil,
    1400541,
    common[14],
    common[20],
    1,
    common[23]
  },
  [22384] = {
    22384,
    28,
    4,
    common[11],
    common[12],
    nil,
    1400541,
    common[14],
    common[20],
    1,
    common[23]
  },
  [2239] = {
    2239,
    29,
    4,
    common[11],
    common[12],
    nil,
    1400541,
    common[14],
    common[20],
    1,
    common[23]
  },
  [22392] = {
    22392,
    30,
    4,
    common[11],
    common[12],
    nil,
    1400541,
    common[14],
    common[20],
    1,
    common[23]
  },
  [22393] = {
    22393,
    31,
    4,
    common[11],
    common[12],
    nil,
    1400541,
    common[14],
    common[20],
    1,
    common[23]
  },
  [22394] = {
    22394,
    32,
    4,
    common[11],
    common[12],
    nil,
    1400541,
    common[14],
    common[20],
    1,
    common[23]
  }
}
return config, "ID", key
