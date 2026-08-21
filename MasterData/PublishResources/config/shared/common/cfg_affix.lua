local key = {
  ID = 1,
  Type = 2,
  Level = 3,
  Desc = 4,
  EntryParam = 5
}
local common = {
  "str_summer_activity_two_affix_des100301",
  "str_summer_activity_two_affix_des100401",
  "str_summer_activity_two_affix_des100601",
  "str_summer_activity_two_affix_des100701",
  "str_summer_activity_two_affix_des100801",
  "str_n20_crisis_contract_affix_des_5122402",
  "str_n20_crisis_contract_affix_des_5122405",
  "str_n20_crisis_contract_affix_des_5122408",
  "str_n20_crisis_contract_affix_des_5122409",
  "str_n20_crisis_contract_affix_des_5122410",
  "str_n20_crisis_contract_affix_des_5122411",
  "str_n20_crisis_contract_affix_des_5122413",
  "str_n20_crisis_contract_affix_des_5122414",
  "str_n20_crisis_contract_affix_des_5122417",
  "str_n20_crisis_contract_affix_des_5122419",
  "str_n20_crisis_contract_affix_des_5122420",
  "str_n20_crisis_contract_affix_des_5122421",
  "str_n20_crisis_contract_affix_des_5122422",
  "str_n20_crisis_contract_affix_des_5122423",
  "str_n20_crisis_contract_affix_des_5122424",
  "str_n20_crisis_contract_affix_des_5122427",
  "str_n20_crisis_contract_affix_des_51222011",
  "str_n20_crisis_contract_affix_des_51222021",
  "str_n20_crisis_contract_affix_des_51222031",
  "str_n20_crisis_contract_affix_des_51222041",
  "str_n20_crisis_contract_affix_des_51222051",
  "str_n20_crisis_contract_affix_des_51222061",
  "str_n20_crisis_contract_affix_des_51222071",
  "str_n20_crisis_contract_affix_des_51222081",
  "str_n20_crisis_contract_affix_des_51222091",
  "str_n20_crisis_contract_affix_des_51222101",
  "str_n20_crisis_contract_affix_des_51222111",
  "str_n20_crisis_contract_affix_des_51222121",
  "str_n20_crisis_contract_affix_des_51222131",
  "str_n20_crisis_contract_affix_des_51222141",
  "str_n20_crisis_contract_affix_des_51222151",
  "str_n20_crisis_contract_affix_des_51222161",
  "str_n20_crisis_contract_affix_des_51222171",
  "str_n20_crisis_contract_affix_des_51222181",
  "str_n20_crisis_contract_affix_des_51222191",
  "str_n20_crisis_contract_affix_des_51222201",
  "str_n20_crisis_contract_affix_des_51222211",
  "str_n20_crisis_contract_affix_des_51222221",
  "str_n20_crisis_contract_affix_des_51222231",
  "str_n20_crisis_contract_affix_des_51222241",
  "str_n20_crisis_contract_affix_des_10103",
  "str_n20_crisis_contract_affix_des_10104",
  "str_n20_crisis_contract_affix_des_11104",
  "str_n20_crisis_contract_affix_des_10105",
  "str_n20_crisis_contract_affix_des_10601",
  "str_n20_crisis_contract_affix_des_10801",
  "str_n20_crisis_contract_affix_des_10901",
  "str_n20_crisis_contract_affix_des_11001",
  "str_n20_crisis_contract_affix_des_11002",
  "str_n20_crisis_contract_affix_des_11003",
  "str_n20_crisis_contract_affix_des_11101",
  "str_n20_crisis_contract_affix_des_11102",
  "str_n20_crisis_contract_affix_des_11103",
  "str_n20_crisis_contract_affix_des_11201",
  "str_n20_crisis_contract_affix_des_11301",
  "str_n20_crisis_contract_affix_des_5122303",
  "str_n20_crisis_contract_affix_des_5122304",
  "str_n20_crisis_contract_affix_des_5122305",
  "str_n20_crisis_contract_affix_des_5122309",
  "str_n20_crisis_contract_affix_des_5122310",
  "str_n20_crisis_contract_affix_des_5122311",
  "str_n20_crisis_contract_affix_des_5122313",
  "str_n20_crisis_contract_affix_des_5122314",
  "str_n20_crisis_contract_affix_des_5122315",
  "str_n20_crisis_contract_affix_des_5122316",
  "str_n20_crisis_contract_affix_des_5122317",
  "str_n20_crisis_contract_affix_des_5122318",
  "str_n20_crisis_contract_affix_des_5122319",
  "str_n20_crisis_contract_affix_des_5122320",
  "str_n20_crisis_contract_affix_des_5122321",
  "str_n20_crisis_contract_affix_des_5122322",
  "str_n20_crisis_contract_affix_des_5122323",
  "str_n20_crisis_contract_affix_des_5122324",
  "str_n20_crisis_contract_affix_des_51225031",
  "str_n20_crisis_contract_affix_des_51225061",
  "str_n20_crisis_contract_affix_des_51225091",
  "str_n20_crisis_contract_affix_des_51225101",
  "str_n20_crisis_contract_affix_des_51225111",
  "str_n20_crisis_contract_affix_des_51225121",
  "str_n20_crisis_contract_affix_des_51325131",
  "str_n20_crisis_contract_affix_des_51325141",
  "str_n20_crisis_contract_affix_des_51325161",
  "str_n20_crisis_contract_affix_des_51325171",
  "str_n20_crisis_contract_affix_des_51325181",
  "str_n20_crisis_contract_affix_des_51325191",
  "str_n20_crisis_contract_affix_des_51325201",
  "str_n20_crisis_contract_affix_des_51325211",
  "str_n20_crisis_contract_affix_des_51325221",
  "str_n20_crisis_contract_affix_des_51325231",
  "str_n20_crisis_contract_affix_des_88888888",
  "str_n20_crisis_contract_affix_des_52124111",
  "str_n20_crisis_contract_affix_des_52124121",
  "str_n20_crisis_contract_affix_des_52124141",
  "str_n20_crisis_contract_affix_des_52124161",
  "str_n20_crisis_contract_affix_des_52124171",
  "str_n20_crisis_contract_affix_des_52124181",
  "str_n20_crisis_contract_affix_des_52124191",
  "str_n20_crisis_contract_affix_des_52124201",
  "str_n20_crisis_contract_affix_des_52124211",
  "str_n20_crisis_contract_affix_des_52124221",
  "str_n20_crisis_contract_affix_des_52124231",
  "str_n20_crisis_contract_affix_des_52124241",
  "str_n20_crisis_contract_affix_des_52124251",
  "str_n20_crisis_contract_affix_des_52121031",
  "str_n20_crisis_contract_affix_des_52121041",
  "str_n20_crisis_contract_affix_des_52121051",
  "str_n20_crisis_contract_affix_des_52121061",
  "str_n20_crisis_contract_affix_des_52121071",
  "str_n20_crisis_contract_affix_des_52121081",
  "str_n20_crisis_contract_affix_des_52121091",
  "str_n20_crisis_contract_affix_des_52121101",
  "str_n20_crisis_contract_affix_des_52121111",
  "str_n20_crisis_contract_affix_des_52121121",
  "str_n20_crisis_contract_affix_des_52121131",
  "str_n20_crisis_contract_affix_des_52121151",
  "str_n20_crisis_contract_affix_des_52121161",
  "str_n20_crisis_contract_affix_des_52121171",
  "str_n20_crisis_contract_affix_des_52121181",
  "str_n20_crisis_contract_affix_des_52121191",
  "str_n20_crisis_contract_affix_des_52121201",
  "str_n20_crisis_contract_affix_des_52121211",
  "str_n20_crisis_contract_affix_des_52121221",
  "str_crisis_contract_affix_des543302",
  {
    [1] = {},
    [2] = {affixType = 3}
  },
  {
    [1] = {},
    [2] = {affixType = 4}
  },
  {
    [1] = {
      [1] = 2
    },
    [2] = {affixType = 2, count = 2}
  },
  {
    [1] = {
      [1] = 1
    },
    [2] = {
      affixType = 1,
      type = 1,
      percent = 0.3
    }
  },
  {
    [1] = {
      [1] = 3
    },
    [2] = {
      affixType = 20,
      paramY = 0,
      paramZ = 1
    }
  },
  {
    [1] = {
      [1] = 10
    },
    [2] = {affixType = 21, change = -10}
  },
  {
    [1] = {}
  },
  {
    [1] = {
      [1] = 30
    },
    [2] = {
      affixType = 26,
      monsterID = 512200314,
      buffList = {1041011}
    },
    [3] = {
      affixType = 26,
      monsterID = 512200414,
      buffList = {1041011}
    },
    [4] = {
      affixType = 26,
      monsterID = 512200514,
      buffList = {1041011}
    },
    [5] = {
      affixType = 26,
      monsterID = 512200515,
      buffList = {1041011}
    }
  },
  {
    [1] = {
      [1] = 50
    },
    [2] = {
      affixType = 26,
      monsterID = 512200314,
      buffList = {1041021}
    },
    [3] = {
      affixType = 26,
      monsterID = 512200414,
      buffList = {1041021}
    },
    [4] = {
      affixType = 26,
      monsterID = 512200514,
      buffList = {1041021}
    },
    [5] = {
      affixType = 26,
      monsterID = 512200515,
      buffList = {1041021}
    }
  },
  {
    [1] = {
      [1] = 50
    },
    [2] = {
      affixType = 26,
      monsterID = 512200314,
      buffList = {1041031}
    },
    [3] = {
      affixType = 26,
      monsterID = 512200414,
      buffList = {1041031}
    },
    [4] = {
      affixType = 26,
      monsterID = 512200514,
      buffList = {1041031}
    },
    [5] = {
      affixType = 26,
      monsterID = 512200515,
      buffList = {1041031}
    }
  },
  {
    [1] = {
      [1] = 5
    },
    [2] = {
      affixType = 30,
      trapID = 11901,
      buffList = {1051011}
    },
    [3] = {
      affixType = 30,
      trapID = 11902,
      buffList = {1051011}
    }
  },
  {
    [1] = {
      [1] = 15
    },
    [2] = {
      affixType = 30,
      trapID = 11901,
      buffList = {1051021}
    },
    [3] = {
      affixType = 30,
      trapID = 11902,
      buffList = {1051021}
    }
  },
  {
    [1] = {},
    [2] = {
      affixType = 18,
      waveNum = 1,
      id = 11501,
      pos = {3, 4},
      rotation = {0, 1}
    },
    [3] = {
      affixType = 18,
      waveNum = 1,
      id = 11501,
      pos = {7, 4},
      rotation = {0, 1}
    }
  },
  {
    [1] = {},
    [2] = {
      affixType = 14,
      waveNum = 1,
      sourceID = 2800506,
      targetID = 2800507
    }
  },
  {
    [1] = {
      [1] = 3
    },
    [2] = {
      affixType = 28,
      trapID = 141,
      Trigger = 5212309
    }
  },
  {
    [1] = {},
    [2] = {
      affixType = 26,
      monsterID = 2001505,
      buffList = {521201101}
    }
  },
  {
    [1] = {},
    [2] = {
      affixType = 26,
      monsterID = 2001505,
      buffList = {52120108}
    }
  },
  {
    [1] = {},
    [2] = {
      affixType = 26,
      monsterID = 2001505,
      buffList = {52120102}
    }
  },
  {
    [1] = {},
    [2] = {
      affixType = 33,
      configTable = {
        [1] = {
          EnterState = 2,
          DayRound = 1,
          NightRound = 20
        }
      }
    }
  },
  {
    [1] = {},
    [2] = {
      affixType = 28,
      trapID = 2800608,
      Active = {
        282060103,
        282060105,
        282060110
      }
    },
    [3] = {
      affixType = 28,
      trapID = 2800609,
      Active = {
        282060103,
        282060105,
        281060110
      }
    }
  },
  {
    [1] = {},
    [2] = {
      affixType = 14,
      waveNum = 1,
      sourceID = 2800608,
      targetID = 2800609
    }
  },
  {
    [1] = {},
    [2] = {
      affixType = 16,
      waveNum = 1,
      id = 521201413,
      pos = {4, 6}
    }
  },
  {
    [1] = {
      [1] = 1
    },
    [2] = {
      affixType = 1,
      type = 1,
      percent = 0.2
    }
  },
  {
    [1] = {
      [1] = 1
    },
    [2] = {
      affixType = 1,
      type = 1,
      percent = 0.5
    }
  },
  {
    [1] = {
      [1] = 1
    },
    [2] = {
      affixType = 11,
      affixBuffIDList = {543302}
    }
  },
  {
    [1] = {},
    [2] = {affixType = 36, IncreasePercent = 1}
  }
}
local config = {
  [100101] = {
    100101,
    1001,
    1,
    "str_summer_activity_two_affix_des100101",
    common[129]
  },
  [100201] = {
    100201,
    1002,
    1,
    "str_summer_activity_two_affix_des100201",
    common[130]
  },
  [100301] = {
    100301,
    1003,
    1,
    common[1],
    common[131]
  },
  [100302] = {
    100302,
    1003,
    2,
    common[1],
    {
      [1] = {
        [1] = 5
      },
      [2] = {affixType = 2, count = 5}
    }
  },
  [100401] = {
    100401,
    1004,
    1,
    common[2],
    {
      [1] = {
        [1] = 20
      },
      [2] = {
        affixType = 1,
        type = 1,
        percent = 0.2
      }
    }
  },
  [100402] = {
    100402,
    1004,
    2,
    common[2],
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 1,
        type = 1,
        percent = 0.011
      }
    }
  },
  [100403] = {
    100403,
    1004,
    2,
    common[2],
    common[132]
  },
  [100501] = {
    100501,
    1005,
    1,
    "str_summer_activity_two_affix_des100501",
    common[133]
  },
  [100502] = {
    100502,
    1005,
    1,
    "str_summer_activity_two_affix_des100502",
    common[133]
  },
  [100503] = {
    100503,
    1005,
    1,
    "str_summer_activity_two_affix_des100503",
    common[133]
  },
  [100601] = {
    100601,
    1006,
    1,
    common[3],
    {
      [1] = {
        [1] = 30,
        [2] = 30
      },
      [2] = {
        affixType = 1,
        type = 3,
        percent = 0.7
      },
      [3] = {
        affixType = 1,
        type = 2,
        percent = 0.7
      }
    }
  },
  [100602] = {
    100602,
    1006,
    2,
    common[3],
    {
      [1] = {
        [1] = 100,
        [2] = 50
      },
      [2] = {
        affixType = 1,
        type = 3,
        percent = 0
      },
      [3] = {
        affixType = 1,
        type = 2,
        percent = 0.5
      }
    }
  },
  [100603] = {
    100603,
    1006,
    2,
    common[3],
    {
      [1] = {
        [1] = 50,
        [2] = 50
      },
      [2] = {
        affixType = 1,
        type = 3,
        percent = 0.5
      },
      [3] = {
        affixType = 1,
        type = 2,
        percent = 0.5
      }
    }
  },
  [100701] = {
    100701,
    1007,
    1,
    common[4],
    {
      [1] = {
        [1] = 3
      },
      [2] = {affixType = 10, beHitCount = 5}
    }
  },
  [100702] = {
    100702,
    1007,
    2,
    common[4],
    {
      [1] = {
        [1] = 2
      },
      [2] = {affixType = 10, beHitCount = 2}
    }
  },
  [100703] = {
    100703,
    1007,
    3,
    common[4],
    {
      [1] = {
        [1] = 5
      },
      [2] = {affixType = 10, beHitCount = 5}
    }
  },
  [100801] = {
    100801,
    1008,
    1,
    common[5],
    {
      [1] = {
        [1] = 6
      },
      [2] = {affixType = 21, change = -6}
    }
  },
  [100802] = {
    100802,
    1008,
    2,
    "str_summer_activity_two_affix_des100802",
    common[134]
  },
  [100803] = {
    100803,
    1008,
    3,
    common[5],
    common[134]
  },
  [100901] = {
    100901,
    1009,
    1,
    "str_summer_activity_two_affix_des100901",
    {
      [1] = {
        [1] = 3
      },
      [2] = {
        affixType = 11,
        affixBuffIDList = {6661004}
      },
      [3] = {
        affixType = 11,
        affixBuffIDList = {66610042}
      }
    }
  },
  [100902] = {
    100902,
    1009,
    2,
    "str_summer_activity_two_affix_des100902",
    {
      [1] = {
        [1] = 3,
        [2] = 2
      },
      [2] = {
        affixType = 11,
        affixBuffIDList = {6661004}
      },
      [3] = {
        affixType = 11,
        affixBuffIDList = {66610042}
      },
      [4] = {
        affixType = 11,
        affixBuffIDList = {6661005}
      }
    }
  },
  [230101] = {
    230101,
    151,
    1,
    "str_summer_activity_two_affix_des230101",
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 12,
        waveNum = 1,
        sourceID = 504115101,
        targetID = 504115102
      },
      [3] = {
        affixType = 8,
        type = 5,
        param = {504115101, 504115102}
      }
    }
  },
  [230201] = {
    230201,
    152,
    1,
    "str_summer_activity_two_affix_des230201",
    {
      [1] = {
        [1] = 2
      },
      [2] = {
        affixType = 11,
        affixBuffIDList = {6661001}
      },
      [3] = {
        affixType = 11,
        affixBuffIDList = {6661002}
      }
    }
  },
  [230301] = {
    230301,
    153,
    1,
    "str_summer_activity_two_affix_des230301",
    {
      [1] = {
        [1] = 4
      },
      [2] = {
        affixType = 7,
        monsterID = 504115101,
        sourceSkillID = 500145,
        targetSkillID = 50014501
      },
      [3] = {
        affixType = 7,
        monsterID = 504115102,
        sourceSkillID = 590044405,
        targetSkillID = 591044405
      }
    }
  },
  [240101] = {
    240101,
    201,
    1,
    "str_summer_activity_two_affix_des240101",
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 12,
        waveNum = 1,
        sourceID = 504120101,
        targetID = 504120102
      },
      [3] = {
        affixType = 8,
        type = 5,
        param = {504120101, 504120102}
      }
    }
  },
  [240201] = {
    240201,
    202,
    1,
    "str_summer_activity_two_affix_des240201",
    {
      [1] = {
        [1] = 4
      },
      [2] = {
        affixType = 7,
        monsterID = 504120101,
        sourceSkillID = 501085,
        targetSkillID = 50108501
      },
      [3] = {
        affixType = 7,
        monsterID = 504120102,
        sourceSkillID = 501085,
        targetSkillID = 50108501
      }
    }
  },
  [240301] = {
    240301,
    203,
    1,
    "str_summer_activity_two_affix_des240301",
    {
      [1] = {
        [1] = 4
      },
      [2] = {
        affixType = 7,
        monsterID = 504120101,
        sourceSkillID = 501085,
        targetSkillID = 50108502
      },
      [3] = {
        affixType = 7,
        monsterID = 504120101,
        sourceSkillID = 50108501,
        targetSkillID = 50108503
      },
      [4] = {
        affixType = 7,
        monsterID = 504120102,
        sourceSkillID = 501085,
        targetSkillID = 50108502
      },
      [5] = {
        affixType = 7,
        monsterID = 504120102,
        sourceSkillID = 50108501,
        targetSkillID = 50108503
      }
    }
  },
  [5041051] = {
    5041051,
    51,
    1,
    "str_summer_activity_two_affix_des5041051",
    {
      [1] = {},
      [2] = {
        affixType = 12,
        waveNum = 1,
        sourceID = 50410512,
        targetID = 50410515
      },
      [3] = {
        affixType = 12,
        waveNum = 1,
        sourceID = 50410513,
        targetID = 50410516
      }
    }
  },
  [5041052] = {
    5041052,
    52,
    1,
    "str_summer_activity_two_affix_des5041052",
    {
      [1] = {},
      [2] = {
        affixType = 23,
        waveNum = 1,
        refreshID = 5041052,
        type = 5,
        param = {2}
      },
      [3] = {
        affixType = 23,
        waveNum = 1,
        refreshID = 5041052,
        type = 5,
        param = {4}
      },
      [4] = {
        affixType = 23,
        waveNum = 1,
        refreshID = 5041052,
        type = 5,
        param = {6}
      },
      [5] = {
        affixType = 23,
        waveNum = 1,
        refreshID = 5041052,
        type = 5,
        param = {8}
      },
      [6] = {
        affixType = 23,
        waveNum = 1,
        refreshID = 5041052,
        type = 5,
        param = {10}
      },
      [7] = {
        affixType = 23,
        waveNum = 1,
        refreshID = 5041052,
        type = 5,
        param = {12}
      },
      [8] = {
        affixType = 23,
        waveNum = 1,
        refreshID = 5041052,
        type = 5,
        param = {14}
      }
    }
  },
  [5041053] = {
    5041053,
    53,
    1,
    "str_summer_activity_two_affix_des5041053",
    {
      [1] = {},
      [2] = {
        affixType = 12,
        waveNum = 1,
        sourceID = 50410511,
        targetID = 50410514
      },
      [3] = {
        affixType = 8,
        type = 5,
        param = {50410511, 50410514}
      }
    }
  },
  [5041101] = {
    5041101,
    101,
    1,
    "str_summer_activity_two_affix_des5041101",
    {
      [1] = {},
      [2] = {
        affixType = 12,
        waveNum = 1,
        sourceID = 50411012,
        targetID = 50411017
      },
      [3] = {
        affixType = 12,
        waveNum = 1,
        sourceID = 50411013,
        targetID = 50411018
      },
      [4] = {
        affixType = 12,
        waveNum = 1,
        sourceID = 50411014,
        targetID = 50411019
      }
    }
  },
  [5041102] = {
    5041102,
    102,
    1,
    "str_summer_activity_two_affix_des5041102",
    {
      [1] = {},
      [2] = {
        affixType = 23,
        waveNum = 1,
        refreshID = 5041102,
        type = 5,
        param = {2}
      },
      [3] = {
        affixType = 23,
        waveNum = 1,
        refreshID = 5041102,
        type = 5,
        param = {4}
      },
      [4] = {
        affixType = 23,
        waveNum = 1,
        refreshID = 5041102,
        type = 5,
        param = {6}
      },
      [5] = {
        affixType = 23,
        waveNum = 1,
        refreshID = 5041102,
        type = 5,
        param = {8}
      },
      [6] = {
        affixType = 23,
        waveNum = 1,
        refreshID = 5041102,
        type = 5,
        param = {10}
      },
      [7] = {
        affixType = 23,
        waveNum = 1,
        refreshID = 5041102,
        type = 5,
        param = {12}
      },
      [8] = {
        affixType = 23,
        waveNum = 1,
        refreshID = 5041102,
        type = 5,
        param = {14}
      }
    }
  },
  [5041103] = {
    5041103,
    103,
    1,
    "str_summer_activity_two_affix_des5041103",
    {
      [1] = {},
      [2] = {
        affixType = 12,
        waveNum = 1,
        sourceID = 50411011,
        targetID = 50411016
      },
      [3] = {
        affixType = 8,
        type = 5,
        param = {50411011, 50411016}
      }
    }
  },
  [5041251] = {
    5041251,
    251,
    1,
    "str_summer_activity_two_affix_des5041251",
    {
      [1] = {},
      [2] = {
        affixType = 12,
        waveNum = 1,
        sourceID = 50412514,
        targetID = 50412518
      },
      [3] = {
        affixType = 12,
        waveNum = 1,
        sourceID = 50412515,
        targetID = 50412519
      },
      [4] = {
        affixType = 12,
        waveNum = 1,
        sourceID = 50412516,
        targetID = 50412520
      }
    }
  },
  [5041252] = {
    5041252,
    252,
    1,
    "str_summer_activity_two_affix_des5041252",
    {
      [1] = {},
      [2] = {
        affixType = 12,
        waveNum = 1,
        sourceID = 50412511,
        targetID = 50412512
      },
      [3] = {
        affixType = 8,
        type = 5,
        param = {50412512}
      }
    }
  },
  [5041253] = {
    5041253,
    253,
    1,
    "str_summer_activity_two_affix_des5041253",
    {
      [1] = {},
      [2] = {
        affixType = 23,
        waveNum = 1,
        refreshID = 5041252,
        type = 5,
        param = {2}
      },
      [3] = {
        affixType = 23,
        waveNum = 1,
        refreshID = 5041252,
        type = 5,
        param = {4}
      },
      [4] = {
        affixType = 23,
        waveNum = 1,
        refreshID = 5041252,
        type = 5,
        param = {6}
      },
      [5] = {
        affixType = 23,
        waveNum = 1,
        refreshID = 5041252,
        type = 5,
        param = {8}
      },
      [6] = {
        affixType = 23,
        waveNum = 1,
        refreshID = 5041252,
        type = 5,
        param = {10}
      },
      [7] = {
        affixType = 23,
        waveNum = 1,
        refreshID = 5041252,
        type = 5,
        param = {12}
      },
      [8] = {
        affixType = 23,
        waveNum = 1,
        refreshID = 5041252,
        type = 5,
        param = {14}
      }
    }
  },
  [5041261] = {
    5041261,
    261,
    1,
    "str_summer_activity_two_affix_des5041261",
    {
      [1] = {},
      [2] = {
        affixType = 14,
        waveNum = 1,
        sourceID = 2800316,
        targetID = 2800315
      }
    }
  },
  [5041262] = {
    5041262,
    262,
    1,
    "str_summer_activity_two_affix_des5041262",
    {
      [1] = {},
      [2] = {
        affixType = 16,
        waveNum = 1,
        id = 50412612,
        pos = {2, 3}
      },
      [3] = {
        affixType = 16,
        waveNum = 1,
        id = 50412613,
        pos = {7, 3}
      },
      [4] = {
        affixType = 16,
        waveNum = 1,
        id = 50412614,
        pos = {2, 5}
      },
      [5] = {
        affixType = 16,
        waveNum = 1,
        id = 50412615,
        pos = {7, 5}
      },
      [6] = {
        affixType = 16,
        waveNum = 1,
        id = 50412616,
        pos = {2, 7}
      },
      [7] = {
        affixType = 16,
        waveNum = 1,
        id = 50412617,
        pos = {7, 7}
      }
    }
  },
  [5041263] = {
    5041263,
    263,
    1,
    "str_summer_activity_two_affix_des5041263",
    {
      [1] = {},
      [2] = {
        affixType = 16,
        waveNum = 1,
        id = 50412618,
        pos = {6, 8}
      }
    }
  },
  [51213010] = {
    51213010,
    301,
    1,
    "str_n20_crisis_contract_affix_des_5121300",
    common[135]
  },
  [51213011] = {
    51213011,
    301,
    1,
    "str_n20_crisis_contract_affix_des_5121301",
    common[135]
  },
  [51213021] = {
    51213021,
    302,
    1,
    "str_n20_crisis_contract_affix_des_5121302",
    common[135]
  },
  [51213031] = {
    51213031,
    303,
    1,
    "str_n20_crisis_contract_affix_des_5121303",
    common[135]
  },
  [51213041] = {
    51213041,
    304,
    1,
    "str_n20_crisis_contract_affix_des_5121304",
    common[135]
  },
  [51213051] = {
    51213051,
    305,
    1,
    "str_n20_crisis_contract_affix_des_5121305",
    common[135]
  },
  [51213061] = {
    51213061,
    306,
    1,
    "str_n20_crisis_contract_affix_des_5121306",
    common[135]
  },
  [51213071] = {
    51213071,
    307,
    1,
    "str_n20_crisis_contract_affix_des_5121307",
    common[135]
  },
  [51213081] = {
    51213081,
    308,
    1,
    "str_n20_crisis_contract_affix_des_5121308",
    common[135]
  },
  [51213091] = {
    51213091,
    309,
    1,
    "str_n20_crisis_contract_affix_des_5121309",
    common[135]
  },
  [51213101] = {
    51213101,
    310,
    1,
    "str_n20_crisis_contract_affix_des_5121310",
    common[135]
  },
  [51213111] = {
    51213111,
    311,
    1,
    "str_n20_crisis_contract_affix_des_5121311",
    common[135]
  },
  [51213121] = {
    51213121,
    312,
    1,
    "str_n20_crisis_contract_affix_des_5121312",
    common[135]
  },
  [51213131] = {
    51213131,
    313,
    1,
    "str_n20_crisis_contract_affix_des_5121313",
    common[135]
  },
  [51213141] = {
    51213141,
    314,
    1,
    "str_n20_crisis_contract_affix_des_5121314",
    common[135]
  },
  [51213151] = {
    51213151,
    315,
    1,
    "str_n20_crisis_contract_affix_des_5121315",
    common[135]
  },
  [51213161] = {
    51213161,
    316,
    1,
    "str_n20_crisis_contract_affix_des_5121316",
    common[135]
  },
  [51213171] = {
    51213171,
    317,
    1,
    "str_n20_crisis_contract_affix_des_5121317",
    common[135]
  },
  [51213181] = {
    51213181,
    318,
    1,
    "str_n20_crisis_contract_affix_des_5121318",
    common[135]
  },
  [51213191] = {
    51213191,
    319,
    1,
    "str_n20_crisis_contract_affix_des_5121319",
    common[135]
  },
  [51213201] = {
    51213201,
    320,
    1,
    "str_n20_crisis_contract_affix_des_5121320",
    common[135]
  },
  [51213211] = {
    51213211,
    321,
    1,
    "str_n20_crisis_contract_affix_des_5121321",
    common[135]
  },
  [51213221] = {
    51213221,
    322,
    1,
    "str_n20_crisis_contract_affix_des_5121322",
    common[135]
  },
  [51213231] = {
    51213231,
    323,
    1,
    "str_n20_crisis_contract_affix_des_5121323",
    common[135]
  },
  [51213241] = {
    51213241,
    324,
    1,
    "str_n20_crisis_contract_affix_des_5121324",
    common[135]
  },
  [51213251] = {
    51213251,
    325,
    1,
    "str_n20_crisis_contract_affix_des_5121325",
    common[135]
  },
  [51213261] = {
    51213261,
    326,
    1,
    "str_n20_crisis_contract_affix_des_5121326",
    common[135]
  },
  [51224011] = {
    51224011,
    401,
    1,
    "str_n20_crisis_contract_affix_des_5122401",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512201611,
        buffList = {51224011}
      }
    }
  },
  [51224023] = {
    51224023,
    402,
    1,
    common[6],
    {
      [1] = {
        [1] = 10
      },
      [2] = {
        affixType = 26,
        monsterID = 512201811,
        buffList = {51224021}
      }
    }
  },
  [51224024] = {
    51224024,
    402,
    1,
    common[6],
    {
      [1] = {
        [1] = 10
      },
      [2] = {
        affixType = 26,
        monsterID = 512201911,
        buffList = {51224021}
      }
    }
  },
  [51224025] = {
    51224025,
    402,
    1,
    common[6],
    {
      [1] = {
        [1] = 10
      },
      [2] = {
        affixType = 26,
        monsterID = 512202011,
        buffList = {51224021}
      }
    }
  },
  [51224033] = {
    51224033,
    402,
    1,
    common[6],
    {
      [1] = {
        [1] = 30
      },
      [2] = {
        affixType = 26,
        monsterID = 512201811,
        buffList = {51224031}
      }
    }
  },
  [51224034] = {
    51224034,
    402,
    1,
    common[6],
    {
      [1] = {
        [1] = 30
      },
      [2] = {
        affixType = 26,
        monsterID = 512201911,
        buffList = {51224031}
      }
    }
  },
  [51224035] = {
    51224035,
    402,
    1,
    common[6],
    {
      [1] = {
        [1] = 30
      },
      [2] = {
        affixType = 26,
        monsterID = 512202011,
        buffList = {51224031}
      }
    }
  },
  [51224043] = {
    51224043,
    402,
    1,
    common[6],
    {
      [1] = {
        [1] = 50
      },
      [2] = {
        affixType = 26,
        monsterID = 512201811,
        buffList = {51224041}
      }
    }
  },
  [51224044] = {
    51224044,
    402,
    1,
    common[6],
    {
      [1] = {
        [1] = 50
      },
      [2] = {
        affixType = 26,
        monsterID = 512201911,
        buffList = {51224041}
      }
    }
  },
  [51224045] = {
    51224045,
    402,
    1,
    common[6],
    {
      [1] = {
        [1] = 50
      },
      [2] = {
        affixType = 26,
        monsterID = 512202011,
        buffList = {51224041}
      }
    }
  },
  [51224051] = {
    51224051,
    405,
    1,
    common[7],
    {
      [1] = {
        [1] = 5,
        [2] = 10,
        [3] = 10
      },
      [2] = {
        affixType = 26,
        monsterID = 512201611,
        buffList = {51224050}
      }
    }
  },
  [51224052] = {
    51224052,
    405,
    1,
    common[7],
    {
      [1] = {
        [1] = 5,
        [2] = 10,
        [3] = 10
      },
      [2] = {
        affixType = 26,
        monsterID = 512201711,
        buffList = {51224050}
      }
    }
  },
  [51224053] = {
    51224053,
    405,
    1,
    common[7],
    {
      [1] = {
        [1] = 5,
        [2] = 10,
        [3] = 10
      },
      [2] = {
        affixType = 26,
        monsterID = 512201811,
        buffList = {51224050}
      }
    }
  },
  [51224054] = {
    51224054,
    405,
    1,
    common[7],
    {
      [1] = {
        [1] = 5,
        [2] = 10,
        [3] = 10
      },
      [2] = {
        affixType = 26,
        monsterID = 512201911,
        buffList = {51224050}
      }
    }
  },
  [51224055] = {
    51224055,
    405,
    1,
    common[7],
    {
      [1] = {
        [1] = 5,
        [2] = 10,
        [3] = 10
      },
      [2] = {
        affixType = 26,
        monsterID = 512202011,
        buffList = {51224050}
      }
    }
  },
  [51224061] = {
    51224061,
    405,
    1,
    common[7],
    {
      [1] = {
        [1] = 10,
        [2] = 30,
        [3] = 30
      },
      [2] = {
        affixType = 26,
        monsterID = 512201611,
        buffList = {51224060}
      }
    }
  },
  [51224062] = {
    51224062,
    405,
    1,
    common[7],
    {
      [1] = {
        [1] = 10,
        [2] = 30,
        [3] = 30
      },
      [2] = {
        affixType = 26,
        monsterID = 512201711,
        buffList = {51224060}
      }
    }
  },
  [51224063] = {
    51224063,
    405,
    1,
    common[7],
    {
      [1] = {
        [1] = 10,
        [2] = 30,
        [3] = 30
      },
      [2] = {
        affixType = 26,
        monsterID = 512201811,
        buffList = {51224060}
      }
    }
  },
  [51224064] = {
    51224064,
    405,
    1,
    common[7],
    {
      [1] = {
        [1] = 10,
        [2] = 30,
        [3] = 30
      },
      [2] = {
        affixType = 26,
        monsterID = 512201911,
        buffList = {51224060}
      }
    }
  },
  [51224065] = {
    51224065,
    405,
    1,
    common[7],
    {
      [1] = {
        [1] = 10,
        [2] = 30,
        [3] = 30
      },
      [2] = {
        affixType = 26,
        monsterID = 512202011,
        buffList = {51224060}
      }
    }
  },
  [51224071] = {
    51224071,
    405,
    1,
    common[7],
    {
      [1] = {
        [1] = 20,
        [2] = 50,
        [3] = 50
      },
      [2] = {
        affixType = 26,
        monsterID = 512201611,
        buffList = {51224070}
      }
    }
  },
  [51224072] = {
    51224072,
    405,
    1,
    common[7],
    {
      [1] = {
        [1] = 20,
        [2] = 50,
        [3] = 50
      },
      [2] = {
        affixType = 26,
        monsterID = 512201711,
        buffList = {51224070}
      }
    }
  },
  [51224073] = {
    51224073,
    405,
    1,
    common[7],
    {
      [1] = {
        [1] = 20,
        [2] = 50,
        [3] = 50
      },
      [2] = {
        affixType = 26,
        monsterID = 512201811,
        buffList = {51224070}
      }
    }
  },
  [51224074] = {
    51224074,
    405,
    1,
    common[7],
    {
      [1] = {
        [1] = 20,
        [2] = 50,
        [3] = 50
      },
      [2] = {
        affixType = 26,
        monsterID = 512201911,
        buffList = {51224070}
      }
    }
  },
  [51224075] = {
    51224075,
    405,
    1,
    common[7],
    {
      [1] = {
        [1] = 20,
        [2] = 50,
        [3] = 50
      },
      [2] = {
        affixType = 26,
        monsterID = 512202011,
        buffList = {51224070}
      }
    }
  },
  [51224082] = {
    51224082,
    408,
    1,
    common[8],
    {
      [1] = {
        [1] = 10
      },
      [2] = {
        affixType = 27,
        monsterID = 512201711,
        eliteBuffList = {104801}
      }
    }
  },
  [51224083] = {
    51224083,
    408,
    1,
    common[8],
    {
      [1] = {
        [1] = 10
      },
      [2] = {
        affixType = 27,
        monsterID = 512201811,
        eliteBuffList = {104801}
      }
    }
  },
  [51224084] = {
    51224084,
    408,
    1,
    common[8],
    {
      [1] = {
        [1] = 10
      },
      [2] = {
        affixType = 27,
        monsterID = 512201911,
        eliteBuffList = {104801}
      }
    }
  },
  [51224092] = {
    51224092,
    408,
    1,
    common[9],
    {
      [1] = {
        [1] = 25
      },
      [2] = {
        affixType = 27,
        monsterID = 512201711,
        eliteBuffList = {104802}
      }
    }
  },
  [51224093] = {
    51224093,
    408,
    1,
    common[9],
    {
      [1] = {
        [1] = 25
      },
      [2] = {
        affixType = 27,
        monsterID = 512201811,
        eliteBuffList = {104802}
      }
    }
  },
  [51224094] = {
    51224094,
    408,
    1,
    common[9],
    {
      [1] = {
        [1] = 25
      },
      [2] = {
        affixType = 27,
        monsterID = 512201911,
        eliteBuffList = {104802}
      }
    }
  },
  [51224102] = {
    51224102,
    408,
    1,
    common[10],
    {
      [1] = {
        [1] = 40
      },
      [2] = {
        affixType = 27,
        monsterID = 512201711,
        eliteBuffList = {104803}
      }
    }
  },
  [51224103] = {
    51224103,
    408,
    1,
    common[10],
    {
      [1] = {
        [1] = 40
      },
      [2] = {
        affixType = 27,
        monsterID = 512201811,
        eliteBuffList = {104803}
      }
    }
  },
  [51224104] = {
    51224104,
    408,
    1,
    common[10],
    {
      [1] = {
        [1] = 40
      },
      [2] = {
        affixType = 27,
        monsterID = 512201911,
        eliteBuffList = {104803}
      }
    }
  },
  [51224111] = {
    51224111,
    411,
    1,
    common[11],
    {
      [1] = {
        [1] = 1.5
      },
      [2] = {
        affixType = 26,
        monsterID = 512201611,
        buffList = {51224111}
      }
    }
  },
  [51224112] = {
    51224112,
    411,
    1,
    common[11],
    {
      [1] = {
        [1] = 1.5
      },
      [2] = {
        affixType = 26,
        monsterID = 512201711,
        buffList = {51224111}
      }
    }
  },
  [51224113] = {
    51224113,
    411,
    1,
    common[11],
    {
      [1] = {
        [1] = 1.5
      },
      [2] = {
        affixType = 26,
        monsterID = 512201811,
        buffList = {51224111}
      }
    }
  },
  [51224114] = {
    51224114,
    411,
    1,
    common[11],
    {
      [1] = {
        [1] = 1.5
      },
      [2] = {
        affixType = 26,
        monsterID = 512201911,
        buffList = {51224111}
      }
    }
  },
  [51224115] = {
    51224115,
    411,
    1,
    common[11],
    {
      [1] = {
        [1] = 1.5
      },
      [2] = {
        affixType = 26,
        monsterID = 512202011,
        buffList = {51224111}
      }
    }
  },
  [51224121] = {
    51224121,
    411,
    1,
    common[11],
    {
      [1] = {
        [1] = 2
      },
      [2] = {
        affixType = 26,
        monsterID = 512201611,
        buffList = {51224121}
      }
    }
  },
  [51224122] = {
    51224122,
    411,
    1,
    common[11],
    {
      [1] = {
        [1] = 2
      },
      [2] = {
        affixType = 26,
        monsterID = 512201711,
        buffList = {51224121}
      }
    }
  },
  [51224123] = {
    51224123,
    411,
    1,
    common[11],
    {
      [1] = {
        [1] = 2
      },
      [2] = {
        affixType = 26,
        monsterID = 512201811,
        buffList = {51224121}
      }
    }
  },
  [51224124] = {
    51224124,
    411,
    1,
    common[11],
    {
      [1] = {
        [1] = 2
      },
      [2] = {
        affixType = 26,
        monsterID = 512201911,
        buffList = {51224121}
      }
    }
  },
  [51224125] = {
    51224125,
    411,
    1,
    common[11],
    {
      [1] = {
        [1] = 2
      },
      [2] = {
        affixType = 26,
        monsterID = 512202011,
        buffList = {51224121}
      }
    }
  },
  [51224133] = {
    51224133,
    413,
    1,
    common[12],
    {
      [1] = {},
      [2] = {
        affixType = 6,
        monsterID = 512201811,
        sourceAIID = 2910681,
        targetAIID = 2910682,
        aiType = 1
      }
    }
  },
  [51224134] = {
    51224134,
    413,
    1,
    common[12],
    {
      [1] = {},
      [2] = {
        affixType = 6,
        monsterID = 512201911,
        sourceAIID = 2910681,
        targetAIID = 2910682,
        aiType = 1
      }
    }
  },
  [51224135] = {
    51224135,
    413,
    1,
    common[12],
    {
      [1] = {},
      [2] = {
        affixType = 6,
        monsterID = 512202011,
        sourceAIID = 2910681,
        targetAIID = 2910682,
        aiType = 1
      }
    }
  },
  [51224141] = {
    51224141,
    414,
    1,
    common[13],
    {
      [1] = {
        [1] = 10
      },
      [2] = {
        affixType = 26,
        monsterID = 512201611,
        buffList = {51224141}
      }
    }
  },
  [51224152] = {
    51224152,
    414,
    1,
    common[13],
    {
      [1] = {
        [1] = 20
      },
      [2] = {
        affixType = 26,
        monsterID = 512201711,
        buffList = {51224142}
      }
    }
  },
  [51224153] = {
    51224153,
    414,
    1,
    common[13],
    {
      [1] = {
        [1] = 20
      },
      [2] = {
        affixType = 26,
        monsterID = 512201811,
        buffList = {51224142}
      }
    }
  },
  [51224164] = {
    51224164,
    414,
    1,
    common[13],
    {
      [1] = {
        [1] = 30
      },
      [2] = {
        affixType = 26,
        monsterID = 512201911,
        buffList = {51224143}
      }
    }
  },
  [51224165] = {
    51224165,
    414,
    1,
    common[13],
    {
      [1] = {
        [1] = 30
      },
      [2] = {
        affixType = 26,
        monsterID = 512202011,
        buffList = {51224143}
      }
    }
  },
  [51224173] = {
    51224173,
    417,
    1,
    common[14],
    {
      [1] = {},
      [2] = {
        affixType = 7,
        monsterID = 512201811,
        sourceSkillID = 29106812,
        targetSkillID = 29106815
      }
    }
  },
  [51224174] = {
    51224174,
    417,
    1,
    common[14],
    {
      [1] = {},
      [2] = {
        affixType = 7,
        monsterID = 512201911,
        sourceSkillID = 29106812,
        targetSkillID = 29106815
      }
    }
  },
  [51224175] = {
    51224175,
    417,
    1,
    common[14],
    {
      [1] = {},
      [2] = {
        affixType = 7,
        monsterID = 512202011,
        sourceSkillID = 29106813,
        targetSkillID = 29106816
      }
    }
  },
  [51224185] = {
    51224185,
    418,
    1,
    "str_n20_crisis_contract_affix_des_5122418",
    common[130]
  },
  [51224191] = {
    51224191,
    419,
    1,
    common[15],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201611,
        eliteBuffList = {100301}
      }
    }
  },
  [51224192] = {
    51224192,
    419,
    1,
    common[15],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201711,
        eliteBuffList = {100301}
      }
    }
  },
  [51224193] = {
    51224193,
    419,
    1,
    common[15],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201811,
        eliteBuffList = {100301}
      }
    }
  },
  [51224201] = {
    51224201,
    419,
    1,
    common[16],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201611,
        eliteBuffList = {100302}
      }
    }
  },
  [51224202] = {
    51224202,
    419,
    1,
    common[16],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201711,
        eliteBuffList = {100302}
      }
    }
  },
  [51224203] = {
    51224203,
    419,
    1,
    common[16],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201811,
        eliteBuffList = {100302}
      }
    }
  },
  [51224211] = {
    51224211,
    419,
    1,
    common[17],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201611,
        eliteBuffList = {100303}
      }
    }
  },
  [51224212] = {
    51224212,
    419,
    1,
    common[17],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201711,
        eliteBuffList = {100303}
      }
    }
  },
  [51224213] = {
    51224213,
    419,
    1,
    common[17],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201811,
        eliteBuffList = {100303}
      }
    }
  },
  [51224222] = {
    51224222,
    422,
    1,
    common[18],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201711,
        eliteBuffList = {103001}
      }
    }
  },
  [51224223] = {
    51224223,
    422,
    1,
    common[18],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201811,
        eliteBuffList = {103001}
      }
    }
  },
  [51224224] = {
    51224224,
    422,
    1,
    common[18],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201911,
        eliteBuffList = {103001}
      }
    }
  },
  [51224225] = {
    51224225,
    422,
    1,
    common[18],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512202011,
        eliteBuffList = {103001}
      }
    }
  },
  [51224232] = {
    51224232,
    422,
    1,
    common[19],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201711,
        eliteBuffList = {103002}
      }
    }
  },
  [51224233] = {
    51224233,
    422,
    1,
    common[19],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201811,
        eliteBuffList = {103002}
      }
    }
  },
  [51224234] = {
    51224234,
    422,
    1,
    common[19],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201911,
        eliteBuffList = {103002}
      }
    }
  },
  [51224235] = {
    51224235,
    422,
    1,
    common[19],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512202011,
        eliteBuffList = {103002}
      }
    }
  },
  [51224242] = {
    51224242,
    422,
    1,
    common[20],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201711,
        eliteBuffList = {103003}
      }
    }
  },
  [51224243] = {
    51224243,
    422,
    1,
    common[20],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201811,
        eliteBuffList = {103003}
      }
    }
  },
  [51224244] = {
    51224244,
    422,
    1,
    common[20],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201911,
        eliteBuffList = {103003}
      }
    }
  },
  [51224245] = {
    51224245,
    422,
    1,
    common[20],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512202011,
        eliteBuffList = {103003}
      }
    }
  },
  [51224251] = {
    51224251,
    425,
    1,
    "str_n20_crisis_contract_affix_des_5122425",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201611,
        eliteBuffList = {100901}
      }
    }
  },
  [51224261] = {
    51224261,
    425,
    1,
    "str_n20_crisis_contract_affix_des_5122426",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201611,
        eliteBuffList = {100902}
      }
    }
  },
  [51224274] = {
    51224274,
    427,
    1,
    common[21],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201911,
        eliteBuffList = {1012}
      }
    }
  },
  [51224275] = {
    51224275,
    427,
    1,
    common[21],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512202011,
        eliteBuffList = {1012}
      }
    }
  },
  [51222011] = {
    51222011,
    201,
    1,
    common[22],
    {
      [1] = {},
      [2] = {
        affixType = 30,
        trapID = 21101,
        buffList = {51222041}
      }
    }
  },
  [51222012] = {
    51222012,
    201,
    1,
    common[22],
    {
      [1] = {},
      [2] = {
        affixType = 30,
        trapID = 21102,
        buffList = {51222041}
      }
    }
  },
  [51222013] = {
    51222013,
    201,
    1,
    common[22],
    {
      [1] = {},
      [2] = {
        affixType = 30,
        trapID = 21103,
        buffList = {51222041}
      }
    }
  },
  [51222014] = {
    51222014,
    201,
    1,
    common[22],
    {
      [1] = {},
      [2] = {
        affixType = 30,
        trapID = 21104,
        buffList = {51222041}
      }
    }
  },
  [51222015] = {
    51222015,
    201,
    1,
    common[22],
    {
      [1] = {},
      [2] = {
        affixType = 30,
        trapID = 21105,
        buffList = {51222041}
      }
    }
  },
  [51222021] = {
    51222021,
    202,
    1,
    common[23],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512200611,
        buffList = {51222011}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200612,
        buffList = {51222011}
      }
    }
  },
  [51222022] = {
    51222022,
    202,
    1,
    common[23],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512200711,
        buffList = {51222011}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200712,
        buffList = {51222011}
      }
    }
  },
  [51222023] = {
    51222023,
    202,
    1,
    common[23],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512200811,
        buffList = {51222011}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200812,
        buffList = {51222011}
      }
    }
  },
  [51222024] = {
    51222024,
    202,
    1,
    common[23],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512200911,
        buffList = {51222011}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200912,
        buffList = {51222011}
      }
    }
  },
  [51222025] = {
    51222025,
    202,
    1,
    common[23],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512201011,
        buffList = {51222011}
      },
      [3] = {
        affixType = 26,
        monsterID = 512201012,
        buffList = {51222011}
      }
    }
  },
  [51222031] = {
    51222031,
    203,
    1,
    common[24],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200611,
        eliteBuffList = {100701}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200612,
        eliteBuffList = {100701}
      }
    }
  },
  [51222032] = {
    51222032,
    203,
    1,
    common[24],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200711,
        eliteBuffList = {100701}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200712,
        eliteBuffList = {100701}
      }
    }
  },
  [51222033] = {
    51222033,
    203,
    1,
    common[24],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200811,
        eliteBuffList = {100701}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200812,
        eliteBuffList = {100701}
      }
    }
  },
  [51222034] = {
    51222034,
    203,
    1,
    common[24],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200911,
        eliteBuffList = {100701}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200912,
        eliteBuffList = {100701}
      }
    }
  },
  [51222035] = {
    51222035,
    203,
    1,
    common[24],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201011,
        eliteBuffList = {100701}
      },
      [3] = {
        affixType = 27,
        monsterID = 512201012,
        eliteBuffList = {100701}
      }
    }
  },
  [51222041] = {
    51222041,
    204,
    1,
    common[25],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200611,
        eliteBuffList = {100702}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200612,
        eliteBuffList = {100702}
      }
    }
  },
  [51222042] = {
    51222042,
    204,
    1,
    common[25],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200711,
        eliteBuffList = {100702}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200712,
        eliteBuffList = {100702}
      }
    }
  },
  [51222043] = {
    51222043,
    204,
    1,
    common[25],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200811,
        eliteBuffList = {100702}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200812,
        eliteBuffList = {100702}
      }
    }
  },
  [51222044] = {
    51222044,
    204,
    1,
    common[25],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200911,
        eliteBuffList = {100702}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200912,
        eliteBuffList = {100702}
      }
    }
  },
  [51222045] = {
    51222045,
    204,
    1,
    common[25],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201011,
        eliteBuffList = {100702}
      },
      [3] = {
        affixType = 27,
        monsterID = 512201012,
        eliteBuffList = {100702}
      }
    }
  },
  [51222051] = {
    51222051,
    205,
    1,
    common[26],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200611,
        eliteBuffList = {100703}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200612,
        eliteBuffList = {100703}
      }
    }
  },
  [51222052] = {
    51222052,
    205,
    1,
    common[26],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200711,
        eliteBuffList = {100703}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200712,
        eliteBuffList = {100703}
      }
    }
  },
  [51222053] = {
    51222053,
    205,
    1,
    common[26],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200811,
        eliteBuffList = {100703}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200812,
        eliteBuffList = {100703}
      }
    }
  },
  [51222054] = {
    51222054,
    205,
    1,
    common[26],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200911,
        eliteBuffList = {100703}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200912,
        eliteBuffList = {100703}
      }
    }
  },
  [51222055] = {
    51222055,
    205,
    1,
    common[26],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201011,
        eliteBuffList = {100703}
      },
      [3] = {
        affixType = 27,
        monsterID = 512201012,
        eliteBuffList = {100703}
      }
    }
  },
  [51222061] = {
    51222061,
    206,
    1,
    common[27],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200611,
        eliteBuffList = {103401}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200612,
        eliteBuffList = {103401}
      }
    }
  },
  [51222062] = {
    51222062,
    206,
    1,
    common[27],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200711,
        eliteBuffList = {103401}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200712,
        eliteBuffList = {103401}
      }
    }
  },
  [51222063] = {
    51222063,
    206,
    1,
    common[27],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200811,
        eliteBuffList = {103401}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200812,
        eliteBuffList = {103401}
      }
    }
  },
  [51222064] = {
    51222064,
    206,
    1,
    common[27],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200911,
        eliteBuffList = {103401}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200912,
        eliteBuffList = {103401}
      }
    }
  },
  [51222065] = {
    51222065,
    206,
    1,
    common[27],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201011,
        eliteBuffList = {103401}
      },
      [3] = {
        affixType = 27,
        monsterID = 512201012,
        eliteBuffList = {103401}
      }
    }
  },
  [51222071] = {
    51222071,
    207,
    1,
    common[28],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200611,
        eliteBuffList = {103402}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200612,
        eliteBuffList = {103402}
      }
    }
  },
  [51222072] = {
    51222072,
    207,
    1,
    common[28],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200711,
        eliteBuffList = {103402}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200712,
        eliteBuffList = {103402}
      }
    }
  },
  [51222073] = {
    51222073,
    207,
    1,
    common[28],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200811,
        eliteBuffList = {103402}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200812,
        eliteBuffList = {103402}
      }
    }
  },
  [51222074] = {
    51222074,
    207,
    1,
    common[28],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200911,
        eliteBuffList = {103402}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200912,
        eliteBuffList = {103402}
      }
    }
  },
  [51222075] = {
    51222075,
    207,
    1,
    common[28],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201011,
        eliteBuffList = {103402}
      },
      [3] = {
        affixType = 27,
        monsterID = 512201012,
        eliteBuffList = {103402}
      }
    }
  },
  [51222081] = {
    51222081,
    208,
    1,
    common[29],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200611,
        eliteBuffList = {103403}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200612,
        eliteBuffList = {103403}
      }
    }
  },
  [51222082] = {
    51222082,
    208,
    1,
    common[29],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200711,
        eliteBuffList = {103403}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200712,
        eliteBuffList = {103403}
      }
    }
  },
  [51222083] = {
    51222083,
    208,
    1,
    common[29],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200811,
        eliteBuffList = {103403}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200812,
        eliteBuffList = {103403}
      }
    }
  },
  [51222084] = {
    51222084,
    208,
    1,
    common[29],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200911,
        eliteBuffList = {103403}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200912,
        eliteBuffList = {103403}
      }
    }
  },
  [51222085] = {
    51222085,
    208,
    1,
    common[29],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201011,
        eliteBuffList = {103403}
      },
      [3] = {
        affixType = 27,
        monsterID = 512201012,
        eliteBuffList = {103403}
      }
    }
  },
  [51222091] = {
    51222091,
    209,
    1,
    common[30],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200611,
        eliteBuffList = {1014}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200612,
        eliteBuffList = {1014}
      }
    }
  },
  [51222092] = {
    51222092,
    209,
    1,
    common[30],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200711,
        eliteBuffList = {1014}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200712,
        eliteBuffList = {1014}
      }
    }
  },
  [51222093] = {
    51222093,
    209,
    1,
    common[30],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200811,
        eliteBuffList = {1014}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200812,
        eliteBuffList = {1014}
      }
    }
  },
  [51222094] = {
    51222094,
    209,
    1,
    common[30],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200911,
        eliteBuffList = {1014}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200912,
        eliteBuffList = {1014}
      }
    }
  },
  [51222095] = {
    51222095,
    209,
    1,
    common[30],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201011,
        eliteBuffList = {1014}
      },
      [3] = {
        affixType = 27,
        monsterID = 512201012,
        eliteBuffList = {1014}
      }
    }
  },
  [51222101] = {
    51222101,
    210,
    1,
    common[31],
    {
      [1] = {},
      [2] = {
        affixType = 16,
        waveNum = 1,
        id = 512200613,
        pos = {3, 5}
      },
      [3] = {
        affixType = 16,
        waveNum = 1,
        id = 512200613,
        pos = {5, 4}
      },
      [4] = {
        affixType = 16,
        waveNum = 1,
        id = 512200613,
        pos = {7, 5}
      },
      [5] = {
        affixType = 16,
        waveNum = 1,
        id = 512200616,
        pos = {5, 2}
      }
    }
  },
  [51222102] = {
    51222102,
    210,
    1,
    common[31],
    {
      [1] = {},
      [2] = {
        affixType = 16,
        waveNum = 1,
        id = 512200713,
        pos = {3, 5}
      },
      [3] = {
        affixType = 16,
        waveNum = 1,
        id = 512200713,
        pos = {5, 4}
      },
      [4] = {
        affixType = 16,
        waveNum = 1,
        id = 512200713,
        pos = {7, 5}
      },
      [5] = {
        affixType = 16,
        waveNum = 1,
        id = 512200716,
        pos = {5, 2}
      }
    }
  },
  [51222103] = {
    51222103,
    210,
    1,
    common[31],
    {
      [1] = {},
      [2] = {
        affixType = 16,
        waveNum = 1,
        id = 512200813,
        pos = {3, 5}
      },
      [3] = {
        affixType = 16,
        waveNum = 1,
        id = 512200813,
        pos = {5, 4}
      },
      [4] = {
        affixType = 16,
        waveNum = 1,
        id = 512200813,
        pos = {7, 5}
      },
      [5] = {
        affixType = 16,
        waveNum = 1,
        id = 512200816,
        pos = {5, 2}
      }
    }
  },
  [51222104] = {
    51222104,
    210,
    1,
    common[31],
    {
      [1] = {},
      [2] = {
        affixType = 16,
        waveNum = 1,
        id = 512200913,
        pos = {3, 5}
      },
      [3] = {
        affixType = 16,
        waveNum = 1,
        id = 512200913,
        pos = {5, 4}
      },
      [4] = {
        affixType = 16,
        waveNum = 1,
        id = 512200913,
        pos = {7, 5}
      },
      [5] = {
        affixType = 16,
        waveNum = 1,
        id = 512200916,
        pos = {5, 2}
      }
    }
  },
  [51222105] = {
    51222105,
    210,
    1,
    common[31],
    {
      [1] = {},
      [2] = {
        affixType = 16,
        waveNum = 1,
        id = 512201013,
        pos = {3, 5}
      },
      [3] = {
        affixType = 16,
        waveNum = 1,
        id = 512201013,
        pos = {5, 4}
      },
      [4] = {
        affixType = 16,
        waveNum = 1,
        id = 512201013,
        pos = {7, 5}
      },
      [5] = {
        affixType = 16,
        waveNum = 1,
        id = 512201016,
        pos = {5, 2}
      }
    }
  },
  [51222111] = {
    51222111,
    211,
    1,
    common[32],
    {
      [1] = {},
      [2] = {
        affixType = 28,
        trapID = 21101,
        Active = {
          50015012,
          50015112,
          50015212
        }
      }
    }
  },
  [51222112] = {
    51222112,
    211,
    1,
    common[32],
    {
      [1] = {},
      [2] = {
        affixType = 28,
        trapID = 21102,
        Active = {
          50015012,
          50015112,
          50015212
        }
      }
    }
  },
  [51222113] = {
    51222113,
    211,
    1,
    common[32],
    {
      [1] = {},
      [2] = {
        affixType = 28,
        trapID = 21103,
        Active = {
          50015012,
          50015112,
          50015212
        }
      }
    }
  },
  [51222114] = {
    51222114,
    211,
    1,
    common[32],
    {
      [1] = {},
      [2] = {
        affixType = 28,
        trapID = 21104,
        Active = {
          50015012,
          50015112,
          50015212
        }
      }
    }
  },
  [51222115] = {
    51222115,
    211,
    1,
    common[32],
    {
      [1] = {},
      [2] = {
        affixType = 28,
        trapID = 21105,
        Active = {
          50015012,
          50015112,
          50015212
        }
      }
    }
  },
  [51222121] = {
    51222121,
    212,
    1,
    common[33],
    {
      [1] = {},
      [2] = {
        affixType = 9,
        trapID = 21101,
        trapPower = 3
      }
    }
  },
  [51222122] = {
    51222122,
    212,
    1,
    common[33],
    {
      [1] = {},
      [2] = {
        affixType = 9,
        trapID = 21102,
        trapPower = 3
      }
    }
  },
  [51222123] = {
    51222123,
    212,
    1,
    common[33],
    {
      [1] = {},
      [2] = {
        affixType = 9,
        trapID = 21103,
        trapPower = 3
      }
    }
  },
  [51222124] = {
    51222124,
    212,
    1,
    common[33],
    {
      [1] = {},
      [2] = {
        affixType = 9,
        trapID = 21104,
        trapPower = 3
      }
    }
  },
  [51222125] = {
    51222125,
    212,
    1,
    common[33],
    {
      [1] = {},
      [2] = {
        affixType = 9,
        trapID = 21105,
        trapPower = 3
      }
    }
  },
  [51222131] = {
    51222131,
    213,
    1,
    common[34],
    {
      [1] = {},
      [2] = {
        affixType = 9,
        trapID = 21101,
        trapPower = 0
      }
    }
  },
  [51222132] = {
    51222132,
    213,
    1,
    common[34],
    {
      [1] = {},
      [2] = {
        affixType = 9,
        trapID = 21102,
        trapPower = 0
      }
    }
  },
  [51222133] = {
    51222133,
    213,
    1,
    common[34],
    {
      [1] = {},
      [2] = {
        affixType = 9,
        trapID = 21103,
        trapPower = 0
      }
    }
  },
  [51222134] = {
    51222134,
    213,
    1,
    common[34],
    {
      [1] = {},
      [2] = {
        affixType = 9,
        trapID = 21104,
        trapPower = 0
      }
    }
  },
  [51222135] = {
    51222135,
    213,
    1,
    common[34],
    {
      [1] = {},
      [2] = {
        affixType = 9,
        trapID = 21105,
        trapPower = 0
      }
    }
  },
  [51222141] = {
    51222141,
    214,
    1,
    common[35],
    {
      [1] = {},
      [2] = {
        affixType = 31,
        monsterID = 512200611,
        skillType = 1,
        skillID = 5100362
      },
      [3] = {
        affixType = 31,
        monsterID = 512200612,
        skillType = 1,
        skillID = 5100462
      },
      [4] = {
        affixType = 26,
        monsterID = 512200611,
        buffList = {51222061}
      },
      [5] = {
        affixType = 26,
        monsterID = 512200612,
        buffList = {51222061}
      },
      [6] = {
        affixType = 26,
        monsterID = 512200611,
        buffList = {1031041}
      },
      [7] = {
        affixType = 26,
        monsterID = 512200612,
        buffList = {1031041}
      }
    }
  },
  [51222142] = {
    51222142,
    214,
    1,
    common[35],
    {
      [1] = {},
      [2] = {
        affixType = 31,
        monsterID = 512200711,
        skillType = 1,
        skillID = 5100362
      },
      [3] = {
        affixType = 31,
        monsterID = 512200712,
        skillType = 1,
        skillID = 5100462
      },
      [4] = {
        affixType = 26,
        monsterID = 512200711,
        buffList = {51222061}
      },
      [5] = {
        affixType = 26,
        monsterID = 512200712,
        buffList = {51222061}
      },
      [6] = {
        affixType = 26,
        monsterID = 512200711,
        buffList = {1031041}
      },
      [7] = {
        affixType = 26,
        monsterID = 512200712,
        buffList = {1031041}
      }
    }
  },
  [51222143] = {
    51222143,
    214,
    1,
    common[35],
    {
      [1] = {},
      [2] = {
        affixType = 31,
        monsterID = 512200811,
        skillType = 1,
        skillID = 5100362
      },
      [3] = {
        affixType = 31,
        monsterID = 512200812,
        skillType = 1,
        skillID = 5100462
      },
      [4] = {
        affixType = 26,
        monsterID = 512200811,
        buffList = {51222061}
      },
      [5] = {
        affixType = 26,
        monsterID = 512200812,
        buffList = {51222061}
      },
      [6] = {
        affixType = 26,
        monsterID = 512200811,
        buffList = {1031041}
      },
      [7] = {
        affixType = 26,
        monsterID = 512200812,
        buffList = {1031041}
      }
    }
  },
  [51222144] = {
    51222144,
    214,
    1,
    common[35],
    {
      [1] = {},
      [2] = {
        affixType = 31,
        monsterID = 512200911,
        skillType = 1,
        skillID = 5100362
      },
      [3] = {
        affixType = 31,
        monsterID = 512200912,
        skillType = 1,
        skillID = 5100462
      },
      [4] = {
        affixType = 26,
        monsterID = 512200911,
        buffList = {51222061}
      },
      [5] = {
        affixType = 26,
        monsterID = 512200912,
        buffList = {51222061}
      },
      [6] = {
        affixType = 26,
        monsterID = 512200911,
        buffList = {1031041}
      },
      [7] = {
        affixType = 26,
        monsterID = 512200912,
        buffList = {1031041}
      }
    }
  },
  [51222145] = {
    51222145,
    214,
    1,
    common[35],
    {
      [1] = {},
      [2] = {
        affixType = 31,
        monsterID = 512201011,
        skillType = 1,
        skillID = 5100362
      },
      [3] = {
        affixType = 31,
        monsterID = 512201012,
        skillType = 1,
        skillID = 5100462
      },
      [4] = {
        affixType = 26,
        monsterID = 512201011,
        buffList = {51222061}
      },
      [5] = {
        affixType = 26,
        monsterID = 512201012,
        buffList = {51222061}
      },
      [6] = {
        affixType = 26,
        monsterID = 512201011,
        buffList = {1031041}
      },
      [7] = {
        affixType = 26,
        monsterID = 512201012,
        buffList = {1031041}
      }
    }
  },
  [51222151] = {
    51222151,
    215,
    1,
    common[36],
    {
      [1] = {},
      [2] = {
        affixType = 24,
        monsterID = 512200611,
        buffList = {2900142}
      },
      [3] = {
        affixType = 24,
        monsterID = 512200612,
        buffList = {2900182}
      }
    }
  },
  [51222152] = {
    51222152,
    215,
    1,
    common[36],
    {
      [1] = {},
      [2] = {
        affixType = 24,
        monsterID = 512200711,
        buffList = {2900142}
      },
      [3] = {
        affixType = 24,
        monsterID = 512200712,
        buffList = {2900182}
      }
    }
  },
  [51222153] = {
    51222153,
    215,
    1,
    common[36],
    {
      [1] = {},
      [2] = {
        affixType = 24,
        monsterID = 512200811,
        buffList = {2900142}
      },
      [3] = {
        affixType = 24,
        monsterID = 512200812,
        buffList = {2900182}
      }
    }
  },
  [51222154] = {
    51222154,
    215,
    1,
    common[36],
    {
      [1] = {},
      [2] = {
        affixType = 24,
        monsterID = 512200911,
        buffList = {2900142}
      },
      [3] = {
        affixType = 24,
        monsterID = 512200912,
        buffList = {2900182}
      }
    }
  },
  [51222155] = {
    51222155,
    215,
    1,
    common[36],
    {
      [1] = {},
      [2] = {
        affixType = 24,
        monsterID = 512201011,
        buffList = {2900142}
      },
      [3] = {
        affixType = 24,
        monsterID = 512201012,
        buffList = {2900182}
      }
    }
  },
  [51222161] = {
    51222161,
    216,
    1,
    common[37],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512200611,
        buffList = {51222021}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200612,
        buffList = {51222021}
      }
    }
  },
  [51222162] = {
    51222162,
    216,
    1,
    common[37],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512200711,
        buffList = {51222021}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200712,
        buffList = {51222021}
      }
    }
  },
  [51222163] = {
    51222163,
    216,
    1,
    common[37],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512200811,
        buffList = {51222021}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200812,
        buffList = {51222021}
      }
    }
  },
  [51222164] = {
    51222164,
    216,
    1,
    common[37],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512200911,
        buffList = {51222021}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200912,
        buffList = {51222021}
      }
    }
  },
  [51222165] = {
    51222165,
    216,
    1,
    common[37],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512201011,
        buffList = {51222021}
      },
      [3] = {
        affixType = 26,
        monsterID = 512201012,
        buffList = {51222021}
      }
    }
  },
  [51222171] = {
    51222171,
    217,
    1,
    common[38],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512200611,
        buffList = {51222022}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200612,
        buffList = {51222022}
      }
    }
  },
  [51222172] = {
    51222172,
    217,
    1,
    common[38],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512200711,
        buffList = {51222022}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200712,
        buffList = {51222022}
      }
    }
  },
  [51222173] = {
    51222173,
    217,
    1,
    common[38],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512200811,
        buffList = {51222022}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200812,
        buffList = {51222022}
      }
    }
  },
  [51222174] = {
    51222174,
    217,
    1,
    common[38],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512200911,
        buffList = {51222022}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200912,
        buffList = {51222022}
      }
    }
  },
  [51222175] = {
    51222175,
    217,
    1,
    common[38],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512201011,
        buffList = {51222022}
      },
      [3] = {
        affixType = 26,
        monsterID = 512201012,
        buffList = {51222022}
      }
    }
  },
  [51222181] = {
    51222181,
    218,
    1,
    common[39],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512200611,
        buffList = {51222023}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200612,
        buffList = {51222023}
      }
    }
  },
  [51222182] = {
    51222182,
    218,
    1,
    common[39],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512200711,
        buffList = {51222023}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200712,
        buffList = {51222023}
      }
    }
  },
  [51222183] = {
    51222183,
    218,
    1,
    common[39],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512200811,
        buffList = {51222023}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200812,
        buffList = {51222023}
      }
    }
  },
  [51222184] = {
    51222184,
    218,
    1,
    common[39],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512200911,
        buffList = {51222023}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200912,
        buffList = {51222023}
      }
    }
  },
  [51222185] = {
    51222185,
    218,
    1,
    common[39],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512201011,
        buffList = {51222023}
      },
      [3] = {
        affixType = 26,
        monsterID = 512201012,
        buffList = {51222023}
      }
    }
  },
  [51222191] = {
    51222191,
    219,
    1,
    common[40],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512200611,
        buffList = {51222031}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200612,
        buffList = {51222031}
      }
    }
  },
  [51222192] = {
    51222192,
    219,
    1,
    common[40],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512200711,
        buffList = {51222031}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200712,
        buffList = {51222031}
      }
    }
  },
  [51222193] = {
    51222193,
    219,
    1,
    common[40],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512200811,
        buffList = {51222031}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200812,
        buffList = {51222031}
      }
    }
  },
  [51222194] = {
    51222194,
    219,
    1,
    common[40],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512200911,
        buffList = {51222031}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200912,
        buffList = {51222031}
      }
    }
  },
  [51222195] = {
    51222195,
    219,
    1,
    common[40],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512201011,
        buffList = {51222031}
      },
      [3] = {
        affixType = 26,
        monsterID = 512201012,
        buffList = {51222031}
      }
    }
  },
  [51222201] = {
    51222201,
    220,
    1,
    common[41],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512200611,
        buffList = {51222032}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200612,
        buffList = {51222032}
      }
    }
  },
  [51222202] = {
    51222202,
    220,
    1,
    common[41],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512200711,
        buffList = {51222032}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200712,
        buffList = {51222032}
      }
    }
  },
  [51222203] = {
    51222203,
    220,
    1,
    common[41],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512200811,
        buffList = {51222032}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200812,
        buffList = {51222032}
      }
    }
  },
  [51222204] = {
    51222204,
    220,
    1,
    common[41],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512200911,
        buffList = {51222032}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200912,
        buffList = {51222032}
      }
    }
  },
  [51222205] = {
    51222205,
    220,
    1,
    common[41],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512201011,
        buffList = {51222032}
      },
      [3] = {
        affixType = 26,
        monsterID = 512201012,
        buffList = {51222032}
      }
    }
  },
  [51222211] = {
    51222211,
    221,
    1,
    common[42],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512200611,
        buffList = {51222033}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200612,
        buffList = {51222033}
      }
    }
  },
  [51222212] = {
    51222212,
    221,
    1,
    common[42],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512200711,
        buffList = {51222033}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200712,
        buffList = {51222033}
      }
    }
  },
  [51222213] = {
    51222213,
    221,
    1,
    common[42],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512200811,
        buffList = {51222033}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200812,
        buffList = {51222033}
      }
    }
  },
  [51222214] = {
    51222214,
    221,
    1,
    common[42],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512200911,
        buffList = {51222033}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200912,
        buffList = {51222033}
      }
    }
  },
  [51222215] = {
    51222215,
    221,
    1,
    common[42],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512201011,
        buffList = {51222033}
      },
      [3] = {
        affixType = 26,
        monsterID = 512201012,
        buffList = {51222033}
      }
    }
  },
  [51222221] = {
    51222221,
    222,
    1,
    common[43],
    {
      [1] = {},
      [2] = {
        affixType = 30,
        trapID = 21101,
        buffList = {51222051}
      },
      [3] = {
        affixType = 1,
        type = 1,
        percent = 0.6
      }
    }
  },
  [51222222] = {
    51222222,
    222,
    1,
    common[43],
    {
      [1] = {},
      [2] = {
        affixType = 30,
        trapID = 21102,
        buffList = {51222051}
      },
      [3] = {
        affixType = 1,
        type = 1,
        percent = 0.6
      }
    }
  },
  [51222223] = {
    51222223,
    222,
    1,
    common[43],
    {
      [1] = {},
      [2] = {
        affixType = 30,
        trapID = 21103,
        buffList = {51222051}
      },
      [3] = {
        affixType = 1,
        type = 1,
        percent = 0.6
      }
    }
  },
  [51222224] = {
    51222224,
    222,
    1,
    common[43],
    {
      [1] = {},
      [2] = {
        affixType = 30,
        trapID = 21104,
        buffList = {51222051}
      },
      [3] = {
        affixType = 1,
        type = 1,
        percent = 0.6
      }
    }
  },
  [51222225] = {
    51222225,
    222,
    1,
    common[43],
    {
      [1] = {},
      [2] = {
        affixType = 30,
        trapID = 21105,
        buffList = {51222051}
      },
      [3] = {
        affixType = 1,
        type = 1,
        percent = 0.6
      }
    }
  },
  [51222231] = {
    51222231,
    223,
    1,
    common[44],
    {
      [1] = {},
      [2] = {
        affixType = 30,
        trapID = 21101,
        buffList = {51222052}
      },
      [3] = {
        affixType = 1,
        type = 1,
        percent = 0.4
      }
    }
  },
  [51222232] = {
    51222232,
    223,
    1,
    common[44],
    {
      [1] = {},
      [2] = {
        affixType = 30,
        trapID = 21102,
        buffList = {51222052}
      },
      [3] = {
        affixType = 1,
        type = 1,
        percent = 0.4
      }
    }
  },
  [51222233] = {
    51222233,
    223,
    1,
    common[44],
    {
      [1] = {},
      [2] = {
        affixType = 30,
        trapID = 21103,
        buffList = {51222052}
      },
      [3] = {
        affixType = 1,
        type = 1,
        percent = 0.4
      }
    }
  },
  [51222234] = {
    51222234,
    223,
    1,
    common[44],
    {
      [1] = {},
      [2] = {
        affixType = 30,
        trapID = 21104,
        buffList = {51222052}
      },
      [3] = {
        affixType = 1,
        type = 1,
        percent = 0.4
      }
    }
  },
  [51222235] = {
    51222235,
    223,
    1,
    common[44],
    {
      [1] = {},
      [2] = {
        affixType = 30,
        trapID = 21105,
        buffList = {51222052}
      },
      [3] = {
        affixType = 1,
        type = 1,
        percent = 0.4
      }
    }
  },
  [51222241] = {
    51222241,
    224,
    1,
    common[45],
    {
      [1] = {},
      [2] = {
        affixType = 30,
        trapID = 21101,
        buffList = {51222053}
      },
      [3] = {
        affixType = 1,
        type = 1,
        percent = 0.2
      }
    }
  },
  [51222242] = {
    51222242,
    224,
    1,
    common[45],
    {
      [1] = {},
      [2] = {
        affixType = 30,
        trapID = 21102,
        buffList = {51222053}
      },
      [3] = {
        affixType = 1,
        type = 1,
        percent = 0.2
      }
    }
  },
  [51222243] = {
    51222243,
    224,
    1,
    common[45],
    {
      [1] = {},
      [2] = {
        affixType = 30,
        trapID = 21103,
        buffList = {51222053}
      },
      [3] = {
        affixType = 1,
        type = 1,
        percent = 0.2
      }
    }
  },
  [51222244] = {
    51222244,
    224,
    1,
    common[45],
    {
      [1] = {},
      [2] = {
        affixType = 30,
        trapID = 21104,
        buffList = {51222053}
      },
      [3] = {
        affixType = 1,
        type = 1,
        percent = 0.2
      }
    }
  },
  [51222245] = {
    51222245,
    224,
    1,
    common[45],
    {
      [1] = {},
      [2] = {
        affixType = 30,
        trapID = 21105,
        buffList = {51222053}
      },
      [3] = {
        affixType = 1,
        type = 1,
        percent = 0.2
      }
    }
  },
  [1011011] = {
    1011011,
    10101,
    1,
    "str_n20_crisis_contract_affix_des_10101",
    {
      [1] = {
        [1] = 30
      },
      [2] = {
        affixType = 26,
        monsterID = 512200111,
        buffList = {1011011}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200112,
        buffList = {1011011}
      },
      [4] = {
        affixType = 26,
        monsterID = 512200113,
        buffList = {1011011}
      }
    }
  },
  [1021011] = {
    1021011,
    10102,
    1,
    "str_n20_crisis_contract_affix_des_10102",
    {
      [1] = {
        [1] = 50
      },
      [2] = {
        affixType = 26,
        monsterID = 512200111,
        buffList = {1021011}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200112,
        buffList = {1021011}
      },
      [4] = {
        affixType = 26,
        monsterID = 512200113,
        buffList = {1021011}
      }
    }
  },
  [1031010] = {
    1031010,
    10103,
    1,
    common[46],
    {
      [1] = {
        [1] = 15
      },
      [2] = {
        affixType = 26,
        monsterID = 512200111,
        buffList = {1031011}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200112,
        buffList = {1031011}
      },
      [4] = {
        affixType = 26,
        monsterID = 512200113,
        buffList = {1031011}
      }
    }
  },
  [1031011] = {
    1031011,
    10103,
    1,
    common[46],
    {
      [1] = {
        [1] = 15
      },
      [2] = {
        affixType = 26,
        monsterID = 512200211,
        buffList = {1031011}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200212,
        buffList = {1031011}
      },
      [4] = {
        affixType = 26,
        monsterID = 512200213,
        buffList = {1031011}
      }
    }
  },
  [1031012] = {
    1031012,
    10103,
    1,
    common[46],
    {
      [1] = {
        [1] = 15
      },
      [2] = {
        affixType = 26,
        monsterID = 512200311,
        buffList = {1031011}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200312,
        buffList = {1031011}
      },
      [4] = {
        affixType = 26,
        monsterID = 512200313,
        buffList = {1031011}
      }
    }
  },
  [1031013] = {
    1031013,
    10103,
    1,
    common[46],
    {
      [1] = {
        [1] = 15
      },
      [2] = {
        affixType = 26,
        monsterID = 512200411,
        buffList = {1031011}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200412,
        buffList = {1031011}
      },
      [4] = {
        affixType = 26,
        monsterID = 512200413,
        buffList = {1031011}
      }
    }
  },
  [1031020] = {
    1031020,
    10103,
    1,
    common[46],
    {
      [1] = {
        [1] = 30
      },
      [2] = {
        affixType = 26,
        monsterID = 512200111,
        buffList = {1031021}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200112,
        buffList = {1031021}
      },
      [4] = {
        affixType = 26,
        monsterID = 512200113,
        buffList = {1031021}
      }
    }
  },
  [1031021] = {
    1031021,
    10103,
    1,
    common[46],
    {
      [1] = {
        [1] = 30
      },
      [2] = {
        affixType = 26,
        monsterID = 512200211,
        buffList = {1031021}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200212,
        buffList = {1031021}
      },
      [4] = {
        affixType = 26,
        monsterID = 512200213,
        buffList = {1031021}
      }
    }
  },
  [1031022] = {
    1031022,
    10103,
    1,
    common[46],
    {
      [1] = {
        [1] = 30
      },
      [2] = {
        affixType = 26,
        monsterID = 512200311,
        buffList = {1031021}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200312,
        buffList = {1031021}
      },
      [4] = {
        affixType = 26,
        monsterID = 512200313,
        buffList = {1031021}
      }
    }
  },
  [1031023] = {
    1031023,
    10103,
    1,
    common[46],
    {
      [1] = {
        [1] = 30
      },
      [2] = {
        affixType = 26,
        monsterID = 512200411,
        buffList = {1031021}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200412,
        buffList = {1031021}
      },
      [4] = {
        affixType = 26,
        monsterID = 512200413,
        buffList = {1031021}
      }
    }
  },
  [1031030] = {
    1031030,
    10103,
    1,
    common[46],
    {
      [1] = {
        [1] = 50
      },
      [2] = {
        affixType = 26,
        monsterID = 512200111,
        buffList = {1031031}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200112,
        buffList = {1031031}
      },
      [4] = {
        affixType = 26,
        monsterID = 512200113,
        buffList = {1031031}
      }
    }
  },
  [1031031] = {
    1031031,
    10103,
    1,
    common[46],
    {
      [1] = {
        [1] = 50
      },
      [2] = {
        affixType = 26,
        monsterID = 512200211,
        buffList = {1031031}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200212,
        buffList = {1031031}
      },
      [4] = {
        affixType = 26,
        monsterID = 512200213,
        buffList = {1031031}
      }
    }
  },
  [1031032] = {
    1031032,
    10103,
    1,
    common[46],
    {
      [1] = {
        [1] = 50
      },
      [2] = {
        affixType = 26,
        monsterID = 512200311,
        buffList = {1031031}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200312,
        buffList = {1031031}
      },
      [4] = {
        affixType = 26,
        monsterID = 512200313,
        buffList = {1031031}
      }
    }
  },
  [1031033] = {
    1031033,
    10103,
    1,
    common[46],
    {
      [1] = {
        [1] = 50
      },
      [2] = {
        affixType = 26,
        monsterID = 512200411,
        buffList = {1031031}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200412,
        buffList = {1031031}
      },
      [4] = {
        affixType = 26,
        monsterID = 512200413,
        buffList = {1031031}
      }
    }
  },
  [1041011] = {
    1041011,
    10104,
    1,
    common[47],
    common[136]
  },
  [1041012] = {
    1041012,
    10104,
    1,
    common[47],
    common[136]
  },
  [1041013] = {
    1041013,
    10104,
    1,
    common[47],
    common[136]
  },
  [1041021] = {
    1041021,
    10104,
    1,
    common[47],
    common[137]
  },
  [1041022] = {
    1041022,
    10104,
    1,
    common[47],
    common[137]
  },
  [1041023] = {
    1041023,
    10104,
    1,
    common[47],
    common[137]
  },
  [1041031] = {
    1041031,
    11104,
    1,
    common[48],
    common[138]
  },
  [1041032] = {
    1041032,
    11104,
    1,
    common[48],
    common[138]
  },
  [1041033] = {
    1041033,
    11104,
    1,
    common[48],
    common[138]
  },
  [1051011] = {
    1051011,
    10105,
    1,
    common[49],
    common[139]
  },
  [1051012] = {
    1051012,
    10105,
    1,
    common[49],
    common[139]
  },
  [1051013] = {
    1051013,
    10105,
    1,
    common[49],
    common[139]
  },
  [1051014] = {
    1051014,
    10105,
    1,
    common[49],
    common[139]
  },
  [1051015] = {
    1051015,
    10105,
    1,
    common[49],
    common[139]
  },
  [1051021] = {
    1051021,
    10105,
    1,
    common[49],
    common[140]
  },
  [1051022] = {
    1051022,
    10105,
    1,
    common[49],
    common[140]
  },
  [1051023] = {
    1051023,
    10105,
    1,
    common[49],
    common[140]
  },
  [1051024] = {
    1051024,
    10105,
    1,
    common[49],
    common[140]
  },
  [1051025] = {
    1051025,
    10105,
    1,
    common[49],
    common[140]
  },
  [1061011] = {
    1061011,
    10601,
    1,
    common[50],
    common[141]
  },
  [1061012] = {
    1061012,
    10601,
    1,
    common[50],
    common[141]
  },
  [1061013] = {
    1061013,
    10601,
    1,
    common[50],
    common[141]
  },
  [1071011] = {
    1071011,
    10701,
    1,
    "str_n20_crisis_contract_affix_des_10701",
    {
      [1] = {},
      [2] = {
        affixType = 16,
        waveNum = 1,
        id = 512200515,
        pos = {5, 5}
      }
    }
  },
  [1081011] = {
    1081011,
    10801,
    1,
    common[51],
    {
      [1] = {
        [1] = 15
      },
      [2] = {
        affixType = 26,
        monsterID = 512200111,
        buffList = {1081011}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200112,
        buffList = {1081011}
      },
      [4] = {
        affixType = 26,
        monsterID = 512200113,
        buffList = {1081011}
      }
    }
  },
  [1081012] = {
    1081012,
    10801,
    1,
    common[51],
    {
      [1] = {
        [1] = 15
      },
      [2] = {
        affixType = 26,
        monsterID = 512200211,
        buffList = {1081011}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200212,
        buffList = {1081011}
      },
      [4] = {
        affixType = 26,
        monsterID = 512200213,
        buffList = {1081011}
      }
    }
  },
  [1081013] = {
    1081013,
    10801,
    1,
    common[51],
    {
      [1] = {
        [1] = 15
      },
      [2] = {
        affixType = 26,
        monsterID = 512200311,
        buffList = {1081011}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200312,
        buffList = {1081011}
      },
      [4] = {
        affixType = 26,
        monsterID = 512200313,
        buffList = {1081011}
      }
    }
  },
  [1081014] = {
    1081014,
    10801,
    1,
    common[51],
    {
      [1] = {
        [1] = 15
      },
      [2] = {
        affixType = 26,
        monsterID = 512200411,
        buffList = {1081011}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200412,
        buffList = {1081011}
      },
      [4] = {
        affixType = 26,
        monsterID = 512200413,
        buffList = {1081011}
      }
    }
  },
  [1081015] = {
    1081015,
    10801,
    1,
    common[51],
    {
      [1] = {
        [1] = 15
      },
      [2] = {
        affixType = 26,
        monsterID = 512200511,
        buffList = {1081011}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200512,
        buffList = {1081011}
      },
      [4] = {
        affixType = 26,
        monsterID = 512200513,
        buffList = {1081011}
      }
    }
  },
  [1081021] = {
    1081021,
    10801,
    1,
    common[51],
    {
      [1] = {
        [1] = 30
      },
      [2] = {
        affixType = 26,
        monsterID = 512200111,
        buffList = {1081021}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200112,
        buffList = {1081021}
      },
      [4] = {
        affixType = 26,
        monsterID = 512200113,
        buffList = {1081021}
      }
    }
  },
  [1081022] = {
    1081022,
    10801,
    1,
    common[51],
    {
      [1] = {
        [1] = 30
      },
      [2] = {
        affixType = 26,
        monsterID = 512200211,
        buffList = {1081021}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200212,
        buffList = {1081021}
      },
      [4] = {
        affixType = 26,
        monsterID = 512200213,
        buffList = {1081021}
      }
    }
  },
  [1081023] = {
    1081023,
    10801,
    1,
    common[51],
    {
      [1] = {
        [1] = 30
      },
      [2] = {
        affixType = 26,
        monsterID = 512200311,
        buffList = {1081021}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200312,
        buffList = {1081021}
      },
      [4] = {
        affixType = 26,
        monsterID = 512200313,
        buffList = {1081021}
      }
    }
  },
  [1081024] = {
    1081024,
    10801,
    1,
    common[51],
    {
      [1] = {
        [1] = 30
      },
      [2] = {
        affixType = 26,
        monsterID = 512200411,
        buffList = {1081021}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200412,
        buffList = {1081021}
      },
      [4] = {
        affixType = 26,
        monsterID = 512200413,
        buffList = {1081021}
      }
    }
  },
  [1081025] = {
    1081025,
    10801,
    1,
    common[51],
    {
      [1] = {
        [1] = 30
      },
      [2] = {
        affixType = 26,
        monsterID = 512200511,
        buffList = {1081021}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200512,
        buffList = {1081021}
      },
      [4] = {
        affixType = 26,
        monsterID = 512200513,
        buffList = {1081021}
      }
    }
  },
  [1081031] = {
    1081031,
    10801,
    1,
    common[51],
    {
      [1] = {
        [1] = 50
      },
      [2] = {
        affixType = 26,
        monsterID = 512200111,
        buffList = {1081031}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200112,
        buffList = {1081031}
      },
      [4] = {
        affixType = 26,
        monsterID = 512200113,
        buffList = {1081031}
      }
    }
  },
  [1081032] = {
    1081032,
    10801,
    1,
    common[51],
    {
      [1] = {
        [1] = 50
      },
      [2] = {
        affixType = 26,
        monsterID = 512200211,
        buffList = {1081031}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200212,
        buffList = {1081031}
      },
      [4] = {
        affixType = 26,
        monsterID = 512200213,
        buffList = {1081031}
      }
    }
  },
  [1081033] = {
    1081033,
    10801,
    1,
    common[51],
    {
      [1] = {
        [1] = 50
      },
      [2] = {
        affixType = 26,
        monsterID = 512200311,
        buffList = {1081031}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200312,
        buffList = {1081031}
      },
      [4] = {
        affixType = 26,
        monsterID = 512200313,
        buffList = {1081031}
      }
    }
  },
  [1081034] = {
    1081034,
    10801,
    1,
    common[51],
    {
      [1] = {
        [1] = 50
      },
      [2] = {
        affixType = 26,
        monsterID = 512200411,
        buffList = {1081031}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200412,
        buffList = {1081031}
      },
      [4] = {
        affixType = 26,
        monsterID = 512200413,
        buffList = {1081031}
      }
    }
  },
  [1081035] = {
    1081035,
    10801,
    1,
    common[51],
    {
      [1] = {
        [1] = 50
      },
      [2] = {
        affixType = 26,
        monsterID = 512200511,
        buffList = {1081031}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200512,
        buffList = {1081031}
      },
      [4] = {
        affixType = 26,
        monsterID = 512200513,
        buffList = {1081031}
      }
    }
  },
  [1091011] = {
    1091011,
    10901,
    1,
    common[52],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512200411,
        buffList = {30172}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200412,
        buffList = {30172}
      },
      [4] = {
        affixType = 26,
        monsterID = 512200413,
        buffList = {30172}
      }
    }
  },
  [1091012] = {
    1091012,
    10901,
    1,
    common[52],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512200511,
        buffList = {30172}
      },
      [3] = {
        affixType = 26,
        monsterID = 512200512,
        buffList = {30172}
      },
      [4] = {
        affixType = 26,
        monsterID = 512200513,
        buffList = {30172}
      }
    }
  },
  [1101011] = {
    1101011,
    11001,
    1,
    common[53],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200211,
        eliteBuffList = {100101}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200212,
        eliteBuffList = {100101}
      },
      [4] = {
        affixType = 27,
        monsterID = 512200213,
        eliteBuffList = {100101}
      }
    }
  },
  [1101012] = {
    1101012,
    11001,
    1,
    common[53],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200311,
        eliteBuffList = {100101}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200312,
        eliteBuffList = {100101}
      },
      [4] = {
        affixType = 27,
        monsterID = 512200313,
        eliteBuffList = {100101}
      }
    }
  },
  [1101013] = {
    1101013,
    11001,
    1,
    common[53],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200411,
        eliteBuffList = {100101}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200412,
        eliteBuffList = {100101}
      },
      [4] = {
        affixType = 27,
        monsterID = 512200413,
        eliteBuffList = {100101}
      }
    }
  },
  [1101014] = {
    1101014,
    11001,
    1,
    common[53],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200511,
        eliteBuffList = {100101}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200512,
        eliteBuffList = {100101}
      },
      [4] = {
        affixType = 27,
        monsterID = 512200513,
        eliteBuffList = {100101}
      }
    }
  },
  [1101021] = {
    1101021,
    11002,
    1,
    common[54],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200211,
        eliteBuffList = {100102}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200212,
        eliteBuffList = {100102}
      },
      [4] = {
        affixType = 27,
        monsterID = 512200213,
        eliteBuffList = {100102}
      }
    }
  },
  [1101022] = {
    1101022,
    11002,
    1,
    common[54],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200311,
        eliteBuffList = {100102}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200312,
        eliteBuffList = {100102}
      },
      [4] = {
        affixType = 27,
        monsterID = 512200313,
        eliteBuffList = {100102}
      }
    }
  },
  [1101023] = {
    1101023,
    11002,
    1,
    common[54],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200411,
        eliteBuffList = {100102}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200412,
        eliteBuffList = {100102}
      },
      [4] = {
        affixType = 27,
        monsterID = 512200413,
        eliteBuffList = {100102}
      }
    }
  },
  [1101024] = {
    1101024,
    11002,
    1,
    common[54],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200511,
        eliteBuffList = {100102}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200512,
        eliteBuffList = {100102}
      },
      [4] = {
        affixType = 27,
        monsterID = 512200513,
        eliteBuffList = {100102}
      }
    }
  },
  [1101031] = {
    1101031,
    11003,
    1,
    common[55],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200211,
        eliteBuffList = {100103}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200212,
        eliteBuffList = {100103}
      },
      [4] = {
        affixType = 27,
        monsterID = 512200213,
        eliteBuffList = {100103}
      }
    }
  },
  [1101032] = {
    1101032,
    11003,
    1,
    common[55],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200311,
        eliteBuffList = {100103}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200312,
        eliteBuffList = {100103}
      },
      [4] = {
        affixType = 27,
        monsterID = 512200313,
        eliteBuffList = {100103}
      }
    }
  },
  [1101033] = {
    1101033,
    11003,
    1,
    common[55],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200411,
        eliteBuffList = {100103}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200412,
        eliteBuffList = {100103}
      },
      [4] = {
        affixType = 27,
        monsterID = 512200413,
        eliteBuffList = {100103}
      }
    }
  },
  [1101034] = {
    1101034,
    11003,
    1,
    common[55],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200511,
        eliteBuffList = {100103}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200512,
        eliteBuffList = {100103}
      },
      [4] = {
        affixType = 27,
        monsterID = 512200513,
        eliteBuffList = {100103}
      }
    }
  },
  [1111011] = {
    1111011,
    11101,
    1,
    common[56],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200111,
        eliteBuffList = {101501}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200112,
        eliteBuffList = {101501}
      },
      [4] = {
        affixType = 27,
        monsterID = 512200113,
        eliteBuffList = {101501}
      }
    }
  },
  [1111012] = {
    1111012,
    11101,
    1,
    common[56],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200211,
        eliteBuffList = {101501}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200212,
        eliteBuffList = {101501}
      },
      [4] = {
        affixType = 27,
        monsterID = 512200213,
        eliteBuffList = {101501}
      }
    }
  },
  [1111013] = {
    1111013,
    11101,
    1,
    common[56],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200311,
        eliteBuffList = {101501}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200312,
        eliteBuffList = {101501}
      },
      [4] = {
        affixType = 27,
        monsterID = 512200313,
        eliteBuffList = {101501}
      }
    }
  },
  [1111021] = {
    1111021,
    11102,
    1,
    common[57],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200111,
        eliteBuffList = {101502}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200112,
        eliteBuffList = {101502}
      },
      [4] = {
        affixType = 27,
        monsterID = 512200113,
        eliteBuffList = {101502}
      }
    }
  },
  [1111022] = {
    1111022,
    11102,
    1,
    common[57],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200211,
        eliteBuffList = {101502}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200212,
        eliteBuffList = {101502}
      },
      [4] = {
        affixType = 27,
        monsterID = 512200213,
        eliteBuffList = {101502}
      }
    }
  },
  [1111023] = {
    1111023,
    11102,
    1,
    common[57],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200311,
        eliteBuffList = {101502}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200312,
        eliteBuffList = {101502}
      },
      [4] = {
        affixType = 27,
        monsterID = 512200313,
        eliteBuffList = {101502}
      }
    }
  },
  [1111031] = {
    1111031,
    11103,
    1,
    common[58],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200111,
        eliteBuffList = {101503}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200112,
        eliteBuffList = {101503}
      },
      [4] = {
        affixType = 27,
        monsterID = 512200113,
        eliteBuffList = {101503}
      }
    }
  },
  [1111032] = {
    1111032,
    11103,
    1,
    common[58],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200211,
        eliteBuffList = {101503}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200212,
        eliteBuffList = {101503}
      },
      [4] = {
        affixType = 27,
        monsterID = 512200213,
        eliteBuffList = {101503}
      }
    }
  },
  [1111033] = {
    1111033,
    11103,
    1,
    common[58],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200311,
        eliteBuffList = {101503}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200312,
        eliteBuffList = {101503}
      },
      [4] = {
        affixType = 27,
        monsterID = 512200313,
        eliteBuffList = {101503}
      }
    }
  },
  [1121011] = {
    1121011,
    11201,
    1,
    common[59],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200111,
        eliteBuffList = {1029}
      }
    }
  },
  [1121012] = {
    1121012,
    11201,
    1,
    common[59],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200211,
        eliteBuffList = {1029}
      }
    }
  },
  [1121013] = {
    1121013,
    11201,
    1,
    common[59],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200311,
        eliteBuffList = {1029}
      }
    }
  },
  [1121014] = {
    1121014,
    11201,
    1,
    common[59],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200411,
        eliteBuffList = {1029}
      }
    }
  },
  [1121015] = {
    1121015,
    11201,
    1,
    common[59],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200511,
        eliteBuffList = {1029}
      }
    }
  },
  [1131011] = {
    1131011,
    11301,
    1,
    common[60],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200311,
        eliteBuffList = {1027}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200312,
        eliteBuffList = {1027}
      },
      [4] = {
        affixType = 27,
        monsterID = 512200313,
        eliteBuffList = {1027}
      }
    }
  },
  [1131012] = {
    1131012,
    11301,
    1,
    common[60],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200411,
        eliteBuffList = {1027}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200412,
        eliteBuffList = {1027}
      },
      [4] = {
        affixType = 27,
        monsterID = 512200413,
        eliteBuffList = {1027}
      }
    }
  },
  [1131013] = {
    1131013,
    11301,
    1,
    common[60],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512200511,
        eliteBuffList = {1027}
      },
      [3] = {
        affixType = 27,
        monsterID = 512200512,
        eliteBuffList = {1027}
      },
      [4] = {
        affixType = 27,
        monsterID = 512200513,
        eliteBuffList = {1027}
      }
    }
  },
  [51223011] = {
    51223011,
    301,
    1,
    "str_n20_crisis_contract_affix_des_5122301",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512201111,
        buffList = {51223021}
      }
    }
  },
  [51223021] = {
    51223021,
    302,
    1,
    "str_n20_crisis_contract_affix_des_5122302",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512201111,
        buffList = {51223011}
      }
    }
  },
  [51223031] = {
    51223031,
    303,
    1,
    common[61],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512201211,
        buffList = {51223033}
      },
      [3] = {
        affixType = 26,
        monsterID = 512201212,
        buffList = {51223031}
      },
      [4] = {
        affixType = 26,
        monsterID = 512201213,
        buffList = {51223031}
      },
      [5] = {
        affixType = 26,
        monsterID = 512201214,
        buffList = {51223031}
      },
      [6] = {
        affixType = 26,
        monsterID = 512201215,
        buffList = {51223031}
      }
    }
  },
  [51223032] = {
    51223032,
    303,
    1,
    common[61],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512201311,
        buffList = {51223033}
      },
      [3] = {
        affixType = 26,
        monsterID = 512201312,
        buffList = {51223031}
      },
      [4] = {
        affixType = 26,
        monsterID = 512201313,
        buffList = {51223031}
      },
      [5] = {
        affixType = 26,
        monsterID = 512201314,
        buffList = {51223031}
      },
      [6] = {
        affixType = 26,
        monsterID = 512201315,
        buffList = {51223031}
      }
    }
  },
  [51223033] = {
    51223033,
    303,
    1,
    common[61],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512201411,
        buffList = {51223033}
      },
      [3] = {
        affixType = 26,
        monsterID = 512201412,
        buffList = {51223031}
      },
      [4] = {
        affixType = 26,
        monsterID = 512201413,
        buffList = {51223031}
      },
      [5] = {
        affixType = 26,
        monsterID = 512201414,
        buffList = {51223031}
      },
      [6] = {
        affixType = 26,
        monsterID = 512201415,
        buffList = {51223031}
      }
    }
  },
  [51223041] = {
    51223041,
    304,
    1,
    common[62],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512201211,
        buffList = {51223034}
      },
      [3] = {
        affixType = 26,
        monsterID = 512201212,
        buffList = {51223032}
      },
      [4] = {
        affixType = 26,
        monsterID = 512201213,
        buffList = {51223032}
      },
      [5] = {
        affixType = 26,
        monsterID = 512201214,
        buffList = {51223032}
      },
      [6] = {
        affixType = 26,
        monsterID = 512201215,
        buffList = {51223032}
      }
    }
  },
  [51223042] = {
    51223042,
    304,
    1,
    common[62],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512201311,
        buffList = {51223034}
      },
      [3] = {
        affixType = 26,
        monsterID = 512201312,
        buffList = {51223032}
      },
      [4] = {
        affixType = 26,
        monsterID = 512201313,
        buffList = {51223032}
      },
      [5] = {
        affixType = 26,
        monsterID = 512201314,
        buffList = {51223032}
      },
      [6] = {
        affixType = 26,
        monsterID = 512201315,
        buffList = {51223032}
      }
    }
  },
  [51223043] = {
    51223043,
    304,
    1,
    common[62],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512201411,
        buffList = {51223034}
      },
      [3] = {
        affixType = 26,
        monsterID = 512201412,
        buffList = {51223032}
      },
      [4] = {
        affixType = 26,
        monsterID = 512201413,
        buffList = {51223032}
      },
      [5] = {
        affixType = 26,
        monsterID = 512201414,
        buffList = {51223032}
      },
      [6] = {
        affixType = 26,
        monsterID = 512201415,
        buffList = {51223032}
      }
    }
  },
  [51223051] = {
    51223051,
    305,
    1,
    common[63],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512201211,
        buffList = {51223035}
      },
      [3] = {
        affixType = 26,
        monsterID = 512201212,
        buffList = {51223033}
      },
      [4] = {
        affixType = 26,
        monsterID = 512201213,
        buffList = {51223033}
      },
      [5] = {
        affixType = 26,
        monsterID = 512201214,
        buffList = {51223033}
      },
      [6] = {
        affixType = 26,
        monsterID = 512201215,
        buffList = {51223033}
      }
    }
  },
  [51223052] = {
    51223052,
    305,
    1,
    common[63],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512201311,
        buffList = {51223035}
      },
      [3] = {
        affixType = 26,
        monsterID = 512201312,
        buffList = {51223033}
      },
      [4] = {
        affixType = 26,
        monsterID = 512201313,
        buffList = {51223033}
      },
      [5] = {
        affixType = 26,
        monsterID = 512201314,
        buffList = {51223033}
      },
      [6] = {
        affixType = 26,
        monsterID = 512201315,
        buffList = {51223033}
      }
    }
  },
  [51223053] = {
    51223053,
    305,
    1,
    common[63],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512201411,
        buffList = {51223035}
      },
      [3] = {
        affixType = 26,
        monsterID = 512201412,
        buffList = {51223033}
      },
      [4] = {
        affixType = 26,
        monsterID = 512201413,
        buffList = {51223033}
      },
      [5] = {
        affixType = 26,
        monsterID = 512201414,
        buffList = {51223033}
      },
      [6] = {
        affixType = 26,
        monsterID = 512201415,
        buffList = {51223033}
      }
    }
  },
  [51223061] = {
    51223061,
    306,
    1,
    "str_n20_crisis_contract_affix_des_5122306",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 39104511,
        buffList = {51223041}
      },
      [3] = {
        affixType = 26,
        monsterID = 39104512,
        buffList = {51223041}
      },
      [4] = {
        affixType = 26,
        monsterID = 39104513,
        buffList = {51223041}
      },
      [5] = {
        affixType = 26,
        monsterID = 39104514,
        buffList = {51223041}
      },
      [6] = {
        affixType = 26,
        monsterID = 39104515,
        buffList = {51223041}
      },
      [7] = {
        affixType = 26,
        monsterID = 39104516,
        buffList = {51223041}
      },
      [8] = {
        affixType = 26,
        monsterID = 39104517,
        buffList = {51223041}
      },
      [9] = {
        affixType = 26,
        monsterID = 39104518,
        buffList = {51223041}
      }
    }
  },
  [51223071] = {
    51223071,
    307,
    1,
    "str_n20_crisis_contract_affix_des_5122307",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 39104511,
        buffList = {51223042}
      },
      [3] = {
        affixType = 26,
        monsterID = 39104512,
        buffList = {51223042}
      },
      [4] = {
        affixType = 26,
        monsterID = 39104513,
        buffList = {51223042}
      },
      [5] = {
        affixType = 26,
        monsterID = 39104514,
        buffList = {51223042}
      },
      [6] = {
        affixType = 26,
        monsterID = 39104515,
        buffList = {51223042}
      },
      [7] = {
        affixType = 26,
        monsterID = 39104516,
        buffList = {51223042}
      },
      [8] = {
        affixType = 26,
        monsterID = 39104517,
        buffList = {51223042}
      },
      [9] = {
        affixType = 26,
        monsterID = 39104518,
        buffList = {51223042}
      }
    }
  },
  [51223081] = {
    51223081,
    308,
    1,
    "str_n20_crisis_contract_affix_des_5122308",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 39104511,
        buffList = {51223043}
      },
      [3] = {
        affixType = 26,
        monsterID = 39104512,
        buffList = {51223043}
      },
      [4] = {
        affixType = 26,
        monsterID = 39104513,
        buffList = {51223043}
      },
      [5] = {
        affixType = 26,
        monsterID = 39104514,
        buffList = {51223043}
      },
      [6] = {
        affixType = 26,
        monsterID = 39104515,
        buffList = {51223043}
      },
      [7] = {
        affixType = 26,
        monsterID = 39104516,
        buffList = {51223043}
      },
      [8] = {
        affixType = 26,
        monsterID = 39104517,
        buffList = {51223043}
      },
      [9] = {
        affixType = 26,
        monsterID = 39104518,
        buffList = {51223043}
      }
    }
  },
  [51223091] = {
    51223091,
    309,
    1,
    common[64],
    {
      [1] = {},
      [2] = {
        affixType = 24,
        monsterID = 512201112,
        buffList = {214521}
      },
      [3] = {
        affixType = 24,
        monsterID = 512201113,
        buffList = {214522}
      },
      [4] = {
        affixType = 24,
        monsterID = 512201114,
        buffList = {214523}
      },
      [5] = {
        affixType = 24,
        monsterID = 512201115,
        buffList = {214524}
      }
    }
  },
  [51223092] = {
    51223092,
    309,
    1,
    common[64],
    {
      [1] = {},
      [2] = {
        affixType = 24,
        monsterID = 512201212,
        buffList = {214521}
      },
      [3] = {
        affixType = 24,
        monsterID = 512201213,
        buffList = {214522}
      },
      [4] = {
        affixType = 24,
        monsterID = 512201214,
        buffList = {214523}
      },
      [5] = {
        affixType = 24,
        monsterID = 512201215,
        buffList = {214524}
      }
    }
  },
  [51223093] = {
    51223093,
    309,
    1,
    common[64],
    {
      [1] = {},
      [2] = {
        affixType = 24,
        monsterID = 512201312,
        buffList = {214521}
      },
      [3] = {
        affixType = 24,
        monsterID = 512201313,
        buffList = {214522}
      },
      [4] = {
        affixType = 24,
        monsterID = 512201314,
        buffList = {214523}
      },
      [5] = {
        affixType = 24,
        monsterID = 512201315,
        buffList = {214524}
      }
    }
  },
  [51223094] = {
    51223094,
    309,
    1,
    common[64],
    {
      [1] = {},
      [2] = {
        affixType = 24,
        monsterID = 512201412,
        buffList = {214521}
      },
      [3] = {
        affixType = 24,
        monsterID = 512201413,
        buffList = {214522}
      },
      [4] = {
        affixType = 24,
        monsterID = 512201414,
        buffList = {214523}
      },
      [5] = {
        affixType = 24,
        monsterID = 512201415,
        buffList = {214524}
      }
    }
  },
  [51223095] = {
    51223095,
    309,
    1,
    common[64],
    {
      [1] = {},
      [2] = {
        affixType = 24,
        monsterID = 512201512,
        buffList = {214521}
      },
      [3] = {
        affixType = 24,
        monsterID = 512201513,
        buffList = {214522}
      },
      [4] = {
        affixType = 24,
        monsterID = 512201514,
        buffList = {214523}
      },
      [5] = {
        affixType = 24,
        monsterID = 512201515,
        buffList = {214524}
      }
    }
  },
  [51223101] = {
    51223101,
    310,
    1,
    common[65],
    {
      [1] = {},
      [2] = {
        affixType = 24,
        monsterID = 512201112,
        buffList = {224521}
      },
      [3] = {
        affixType = 24,
        monsterID = 512201113,
        buffList = {224522}
      },
      [4] = {
        affixType = 24,
        monsterID = 512201114,
        buffList = {224523}
      },
      [5] = {
        affixType = 24,
        monsterID = 512201115,
        buffList = {224524}
      }
    }
  },
  [51223102] = {
    51223102,
    310,
    1,
    common[65],
    {
      [1] = {},
      [2] = {
        affixType = 24,
        monsterID = 512201212,
        buffList = {224521}
      },
      [3] = {
        affixType = 24,
        monsterID = 512201213,
        buffList = {224522}
      },
      [4] = {
        affixType = 24,
        monsterID = 512201214,
        buffList = {224523}
      },
      [5] = {
        affixType = 24,
        monsterID = 512201215,
        buffList = {224524}
      }
    }
  },
  [51223103] = {
    51223103,
    310,
    1,
    common[65],
    {
      [1] = {},
      [2] = {
        affixType = 24,
        monsterID = 512201312,
        buffList = {224521}
      },
      [3] = {
        affixType = 24,
        monsterID = 512201313,
        buffList = {224522}
      },
      [4] = {
        affixType = 24,
        monsterID = 512201314,
        buffList = {224523}
      },
      [5] = {
        affixType = 24,
        monsterID = 512201315,
        buffList = {224524}
      }
    }
  },
  [51223104] = {
    51223104,
    310,
    1,
    common[65],
    {
      [1] = {},
      [2] = {
        affixType = 24,
        monsterID = 512201412,
        buffList = {224521}
      },
      [3] = {
        affixType = 24,
        monsterID = 512201413,
        buffList = {224522}
      },
      [4] = {
        affixType = 24,
        monsterID = 512201414,
        buffList = {224523}
      },
      [5] = {
        affixType = 24,
        monsterID = 512201415,
        buffList = {224524}
      }
    }
  },
  [51223105] = {
    51223105,
    310,
    1,
    common[65],
    {
      [1] = {},
      [2] = {
        affixType = 24,
        monsterID = 512201512,
        buffList = {224521}
      },
      [3] = {
        affixType = 24,
        monsterID = 512201513,
        buffList = {224522}
      },
      [4] = {
        affixType = 24,
        monsterID = 512201514,
        buffList = {224523}
      },
      [5] = {
        affixType = 24,
        monsterID = 512201515,
        buffList = {224524}
      }
    }
  },
  [51223111] = {
    51223111,
    311,
    1,
    common[66],
    {
      [1] = {},
      [2] = {
        affixType = 6,
        monsterID = 512201311,
        sourceAIID = 2920451,
        targetAIID = 2920454,
        aiType = 1
      }
    }
  },
  [51223112] = {
    51223112,
    311,
    1,
    common[66],
    {
      [1] = {},
      [2] = {
        affixType = 6,
        monsterID = 512201411,
        sourceAIID = 2920451,
        targetAIID = 2920454,
        aiType = 1
      }
    }
  },
  [51223113] = {
    51223113,
    311,
    1,
    common[66],
    {
      [1] = {},
      [2] = {
        affixType = 6,
        monsterID = 512201511,
        sourceAIID = 2920451,
        targetAIID = 2920454,
        aiType = 1
      }
    }
  },
  [51223121] = {
    51223121,
    312,
    1,
    "str_n20_crisis_contract_affix_des_5122312",
    common[129]
  },
  [51223131] = {
    51223131,
    313,
    1,
    common[67],
    {
      [1] = {},
      [2] = {
        affixType = 7,
        monsterID = 512201111,
        sourceSkillID = 39104511,
        targetSkillID = 39104611
      },
      [3] = {
        affixType = 7,
        monsterID = 512201111,
        sourceSkillID = 39104512,
        targetSkillID = 39104612
      },
      [4] = {
        affixType = 7,
        monsterID = 512201111,
        sourceSkillID = 39104513,
        targetSkillID = 39104613
      },
      [5] = {
        affixType = 7,
        monsterID = 512201111,
        sourceSkillID = 39104514,
        targetSkillID = 39104614
      },
      [6] = {
        affixType = 7,
        monsterID = 512201111,
        sourceSkillID = 39104515,
        targetSkillID = 39104615
      }
    }
  },
  [51223132] = {
    51223132,
    313,
    1,
    common[67],
    {
      [1] = {},
      [2] = {
        affixType = 7,
        monsterID = 512201211,
        sourceSkillID = 39104511,
        targetSkillID = 39104611
      },
      [3] = {
        affixType = 7,
        monsterID = 512201211,
        sourceSkillID = 39104512,
        targetSkillID = 39104612
      },
      [4] = {
        affixType = 7,
        monsterID = 512201211,
        sourceSkillID = 39104513,
        targetSkillID = 39104613
      },
      [5] = {
        affixType = 7,
        monsterID = 512201211,
        sourceSkillID = 39104514,
        targetSkillID = 39104614
      },
      [6] = {
        affixType = 7,
        monsterID = 512201211,
        sourceSkillID = 39104515,
        targetSkillID = 39104615
      }
    }
  },
  [51223133] = {
    51223133,
    313,
    1,
    common[67],
    {
      [1] = {},
      [2] = {
        affixType = 7,
        monsterID = 512201311,
        sourceSkillID = 39104521,
        targetSkillID = 39104621
      },
      [3] = {
        affixType = 7,
        monsterID = 512201311,
        sourceSkillID = 39104522,
        targetSkillID = 39104622
      },
      [4] = {
        affixType = 7,
        monsterID = 512201311,
        sourceSkillID = 39104523,
        targetSkillID = 39104623
      },
      [5] = {
        affixType = 7,
        monsterID = 512201311,
        sourceSkillID = 39104524,
        targetSkillID = 39104624
      },
      [6] = {
        affixType = 7,
        monsterID = 512201311,
        sourceSkillID = 39104525,
        targetSkillID = 39104625
      }
    }
  },
  [51223134] = {
    51223134,
    313,
    1,
    common[67],
    {
      [1] = {},
      [2] = {
        affixType = 7,
        monsterID = 512201411,
        sourceSkillID = 39104521,
        targetSkillID = 39104621
      },
      [3] = {
        affixType = 7,
        monsterID = 512201411,
        sourceSkillID = 39104522,
        targetSkillID = 39104622
      },
      [4] = {
        affixType = 7,
        monsterID = 512201411,
        sourceSkillID = 39104523,
        targetSkillID = 39104623
      },
      [5] = {
        affixType = 7,
        monsterID = 512201411,
        sourceSkillID = 39104524,
        targetSkillID = 39104624
      },
      [6] = {
        affixType = 7,
        monsterID = 512201411,
        sourceSkillID = 39104525,
        targetSkillID = 39104625
      }
    }
  },
  [51223135] = {
    51223135,
    313,
    1,
    common[67],
    {
      [1] = {},
      [2] = {
        affixType = 7,
        monsterID = 512201511,
        sourceSkillID = 39104521,
        targetSkillID = 39104621
      },
      [3] = {
        affixType = 7,
        monsterID = 512201511,
        sourceSkillID = 39104522,
        targetSkillID = 39104622
      },
      [4] = {
        affixType = 7,
        monsterID = 512201511,
        sourceSkillID = 39104523,
        targetSkillID = 39104623
      },
      [5] = {
        affixType = 7,
        monsterID = 512201511,
        sourceSkillID = 39104524,
        targetSkillID = 39104624
      },
      [6] = {
        affixType = 7,
        monsterID = 512201511,
        sourceSkillID = 39104525,
        targetSkillID = 39104625
      }
    }
  },
  [51223141] = {
    51223141,
    314,
    1,
    common[68],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512201112,
        buffList = {51223061}
      },
      [3] = {
        affixType = 26,
        monsterID = 512201113,
        buffList = {51223061}
      },
      [4] = {
        affixType = 26,
        monsterID = 512201114,
        buffList = {51223061}
      },
      [5] = {
        affixType = 26,
        monsterID = 512201115,
        buffList = {51223061}
      }
    }
  },
  [51223142] = {
    51223142,
    314,
    1,
    common[68],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512201212,
        buffList = {51223061}
      },
      [3] = {
        affixType = 26,
        monsterID = 512201213,
        buffList = {51223061}
      },
      [4] = {
        affixType = 26,
        monsterID = 512201214,
        buffList = {51223061}
      },
      [5] = {
        affixType = 26,
        monsterID = 512201215,
        buffList = {51223061}
      }
    }
  },
  [51223143] = {
    51223143,
    314,
    1,
    common[68],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512201312,
        buffList = {51223061}
      },
      [3] = {
        affixType = 26,
        monsterID = 512201313,
        buffList = {51223061}
      },
      [4] = {
        affixType = 26,
        monsterID = 512201314,
        buffList = {51223061}
      },
      [5] = {
        affixType = 26,
        monsterID = 512201315,
        buffList = {51223061}
      }
    }
  },
  [51223144] = {
    51223144,
    314,
    1,
    common[68],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512201412,
        buffList = {51223061}
      },
      [3] = {
        affixType = 26,
        monsterID = 512201413,
        buffList = {51223061}
      },
      [4] = {
        affixType = 26,
        monsterID = 512201414,
        buffList = {51223061}
      },
      [5] = {
        affixType = 26,
        monsterID = 512201415,
        buffList = {51223061}
      }
    }
  },
  [51223145] = {
    51223145,
    314,
    1,
    common[68],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512201512,
        buffList = {51223061}
      },
      [3] = {
        affixType = 26,
        monsterID = 512201513,
        buffList = {51223061}
      },
      [4] = {
        affixType = 26,
        monsterID = 512201514,
        buffList = {51223061}
      },
      [5] = {
        affixType = 26,
        monsterID = 512201515,
        buffList = {51223061}
      }
    }
  },
  [51223151] = {
    51223151,
    315,
    1,
    common[69],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512201112,
        buffList = {51223063}
      },
      [3] = {
        affixType = 26,
        monsterID = 512201113,
        buffList = {51223063}
      },
      [4] = {
        affixType = 26,
        monsterID = 512201114,
        buffList = {51223063}
      },
      [5] = {
        affixType = 26,
        monsterID = 512201115,
        buffList = {51223063}
      }
    }
  },
  [51223152] = {
    51223152,
    315,
    1,
    common[69],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512201212,
        buffList = {51223063}
      },
      [3] = {
        affixType = 26,
        monsterID = 512201213,
        buffList = {51223063}
      },
      [4] = {
        affixType = 26,
        monsterID = 512201214,
        buffList = {51223063}
      },
      [5] = {
        affixType = 26,
        monsterID = 512201215,
        buffList = {51223063}
      }
    }
  },
  [51223153] = {
    51223153,
    315,
    1,
    common[69],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512201312,
        buffList = {51223063}
      },
      [3] = {
        affixType = 26,
        monsterID = 512201313,
        buffList = {51223063}
      },
      [4] = {
        affixType = 26,
        monsterID = 512201314,
        buffList = {51223063}
      },
      [5] = {
        affixType = 26,
        monsterID = 512201315,
        buffList = {51223063}
      }
    }
  },
  [51223154] = {
    51223154,
    315,
    1,
    common[69],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512201412,
        buffList = {51223063}
      },
      [3] = {
        affixType = 26,
        monsterID = 512201413,
        buffList = {51223063}
      },
      [4] = {
        affixType = 26,
        monsterID = 512201414,
        buffList = {51223063}
      },
      [5] = {
        affixType = 26,
        monsterID = 512201415,
        buffList = {51223063}
      }
    }
  },
  [51223155] = {
    51223155,
    315,
    1,
    common[69],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512201512,
        buffList = {51223063}
      },
      [3] = {
        affixType = 26,
        monsterID = 512201513,
        buffList = {51223063}
      },
      [4] = {
        affixType = 26,
        monsterID = 512201514,
        buffList = {51223063}
      },
      [5] = {
        affixType = 26,
        monsterID = 512201515,
        buffList = {51223063}
      }
    }
  },
  [51223161] = {
    51223161,
    316,
    1,
    common[70],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512201112,
        buffList = {51223065}
      },
      [3] = {
        affixType = 26,
        monsterID = 512201113,
        buffList = {51223065}
      },
      [4] = {
        affixType = 26,
        monsterID = 512201114,
        buffList = {51223065}
      },
      [5] = {
        affixType = 26,
        monsterID = 512201115,
        buffList = {51223065}
      }
    }
  },
  [51223162] = {
    51223162,
    316,
    1,
    common[70],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512201212,
        buffList = {51223065}
      },
      [3] = {
        affixType = 26,
        monsterID = 512201213,
        buffList = {51223065}
      },
      [4] = {
        affixType = 26,
        monsterID = 512201214,
        buffList = {51223065}
      },
      [5] = {
        affixType = 26,
        monsterID = 512201215,
        buffList = {51223065}
      }
    }
  },
  [51223163] = {
    51223163,
    316,
    1,
    common[70],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512201312,
        buffList = {51223065}
      },
      [3] = {
        affixType = 26,
        monsterID = 512201313,
        buffList = {51223065}
      },
      [4] = {
        affixType = 26,
        monsterID = 512201314,
        buffList = {51223065}
      },
      [5] = {
        affixType = 26,
        monsterID = 512201315,
        buffList = {51223065}
      }
    }
  },
  [51223164] = {
    51223164,
    316,
    1,
    common[70],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512201412,
        buffList = {51223065}
      },
      [3] = {
        affixType = 26,
        monsterID = 512201413,
        buffList = {51223065}
      },
      [4] = {
        affixType = 26,
        monsterID = 512201414,
        buffList = {51223065}
      },
      [5] = {
        affixType = 26,
        monsterID = 512201415,
        buffList = {51223065}
      }
    }
  },
  [51223165] = {
    51223165,
    316,
    1,
    common[70],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 512201512,
        buffList = {51223065}
      },
      [3] = {
        affixType = 26,
        monsterID = 512201513,
        buffList = {51223065}
      },
      [4] = {
        affixType = 26,
        monsterID = 512201514,
        buffList = {51223065}
      },
      [5] = {
        affixType = 26,
        monsterID = 512201515,
        buffList = {51223065}
      }
    }
  },
  [51223171] = {
    51223171,
    317,
    1,
    common[71],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201211,
        eliteBuffList = {101701}
      }
    }
  },
  [51223172] = {
    51223172,
    317,
    1,
    common[71],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201311,
        eliteBuffList = {101701}
      }
    }
  },
  [51223173] = {
    51223173,
    317,
    1,
    common[71],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201411,
        eliteBuffList = {101701}
      }
    }
  },
  [51223174] = {
    51223174,
    317,
    1,
    common[71],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201511,
        eliteBuffList = {101701}
      }
    }
  },
  [51223181] = {
    51223181,
    318,
    1,
    common[72],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201211,
        eliteBuffList = {101702}
      }
    }
  },
  [51223182] = {
    51223182,
    318,
    1,
    common[72],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201311,
        eliteBuffList = {101702}
      }
    }
  },
  [51223183] = {
    51223183,
    318,
    1,
    common[72],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201411,
        eliteBuffList = {101702}
      }
    }
  },
  [51223184] = {
    51223184,
    318,
    1,
    common[72],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201511,
        eliteBuffList = {101702}
      }
    }
  },
  [51223191] = {
    51223191,
    319,
    1,
    common[73],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201211,
        eliteBuffList = {101703}
      }
    }
  },
  [51223192] = {
    51223192,
    319,
    1,
    common[73],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201311,
        eliteBuffList = {101703}
      }
    }
  },
  [51223193] = {
    51223193,
    319,
    1,
    common[73],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201411,
        eliteBuffList = {101703}
      }
    }
  },
  [51223194] = {
    51223194,
    319,
    1,
    common[73],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201511,
        eliteBuffList = {101703}
      }
    }
  },
  [51223201] = {
    51223201,
    320,
    1,
    common[74],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201111,
        eliteBuffList = {104501}
      }
    }
  },
  [51223202] = {
    51223202,
    320,
    1,
    common[74],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201211,
        eliteBuffList = {104501}
      }
    }
  },
  [51223203] = {
    51223203,
    320,
    1,
    common[74],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201311,
        eliteBuffList = {104501}
      }
    }
  },
  [51223211] = {
    51223211,
    321,
    1,
    common[75],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201111,
        eliteBuffList = {104502}
      }
    }
  },
  [51223212] = {
    51223212,
    321,
    1,
    common[75],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201211,
        eliteBuffList = {104502}
      }
    }
  },
  [51223213] = {
    51223213,
    321,
    1,
    common[75],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201311,
        eliteBuffList = {104502}
      }
    }
  },
  [51223221] = {
    51223221,
    322,
    1,
    common[76],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201111,
        eliteBuffList = {104503}
      }
    }
  },
  [51223222] = {
    51223222,
    322,
    1,
    common[76],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201211,
        eliteBuffList = {104503}
      }
    }
  },
  [51223223] = {
    51223223,
    322,
    1,
    common[76],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201311,
        eliteBuffList = {104503}
      }
    }
  },
  [51223231] = {
    51223231,
    323,
    1,
    common[77],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201311,
        eliteBuffList = {1035}
      }
    }
  },
  [51223232] = {
    51223232,
    323,
    1,
    common[77],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201411,
        eliteBuffList = {1035}
      }
    }
  },
  [51223233] = {
    51223233,
    323,
    1,
    common[77],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201511,
        eliteBuffList = {1035}
      }
    }
  },
  [51223241] = {
    51223241,
    324,
    1,
    common[78],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201411,
        eliteBuffList = {1036}
      }
    }
  },
  [51223242] = {
    51223242,
    324,
    1,
    common[78],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512201511,
        eliteBuffList = {1036}
      }
    }
  },
  [51225011] = {
    51225011,
    501,
    1,
    "str_n20_crisis_contract_affix_des_51225011",
    {
      [1] = {
        [1] = 20,
        [2] = 30
      },
      [2] = {
        affixType = 26,
        monsterID = 512202111,
        buffList = {51225011}
      }
    }
  },
  [51225021] = {
    51225021,
    502,
    1,
    "str_n20_crisis_contract_affix_des_51225021",
    {
      [1] = {
        [1] = 20
      },
      [2] = {
        affixType = 30,
        trapID = 282051111,
        buffList = {51225021}
      },
      [3] = {
        affixType = 30,
        trapID = 282051121,
        buffList = {51225021}
      }
    }
  },
  [51225031] = {
    51225031,
    503,
    1,
    common[79],
    {
      [1] = {
        [1] = 20
      },
      [2] = {
        affixType = 26,
        monsterID = 512202111,
        buffList = {51225031}
      }
    }
  },
  [51225032] = {
    51225032,
    503,
    1,
    common[79],
    {
      [1] = {
        [1] = 20
      },
      [2] = {
        affixType = 26,
        monsterID = 512202211,
        buffList = {51225031}
      }
    }
  },
  [51225033] = {
    51225033,
    503,
    1,
    common[79],
    {
      [1] = {
        [1] = 20
      },
      [2] = {
        affixType = 26,
        monsterID = 512202311,
        buffList = {51225031}
      }
    }
  },
  [51225041] = {
    51225041,
    504,
    1,
    common[79],
    {
      [1] = {
        [1] = 40
      },
      [2] = {
        affixType = 26,
        monsterID = 512202111,
        buffList = {51225041}
      }
    }
  },
  [51225042] = {
    51225042,
    504,
    1,
    common[79],
    {
      [1] = {
        [1] = 40
      },
      [2] = {
        affixType = 26,
        monsterID = 512202211,
        buffList = {51225041}
      }
    }
  },
  [51225043] = {
    51225043,
    504,
    1,
    common[79],
    {
      [1] = {
        [1] = 40
      },
      [2] = {
        affixType = 26,
        monsterID = 512202311,
        buffList = {51225041}
      }
    }
  },
  [51225051] = {
    51225051,
    505,
    1,
    common[79],
    {
      [1] = {
        [1] = 60
      },
      [2] = {
        affixType = 26,
        monsterID = 512202111,
        buffList = {51225051}
      }
    }
  },
  [51225052] = {
    51225052,
    505,
    1,
    common[79],
    {
      [1] = {
        [1] = 60
      },
      [2] = {
        affixType = 26,
        monsterID = 512202211,
        buffList = {51225051}
      }
    }
  },
  [51225053] = {
    51225053,
    505,
    1,
    common[79],
    {
      [1] = {
        [1] = 60
      },
      [2] = {
        affixType = 26,
        monsterID = 512202311,
        buffList = {51225051}
      }
    }
  },
  [51225063] = {
    51225063,
    506,
    1,
    common[80],
    {
      [1] = {
        [1] = 15
      },
      [2] = {
        affixType = 26,
        monsterID = 512202311,
        buffList = {51225063}
      }
    }
  },
  [51225064] = {
    51225064,
    506,
    1,
    common[80],
    {
      [1] = {
        [1] = 15
      },
      [2] = {
        affixType = 26,
        monsterID = 512202411,
        buffList = {51225063}
      }
    }
  },
  [51225065] = {
    51225065,
    506,
    1,
    common[80],
    {
      [1] = {
        [1] = 15
      },
      [2] = {
        affixType = 26,
        monsterID = 512202511,
        buffList = {51225063}
      }
    }
  },
  [51225073] = {
    51225073,
    507,
    1,
    common[80],
    {
      [1] = {
        [1] = 30
      },
      [2] = {
        affixType = 26,
        monsterID = 512202311,
        buffList = {51225073}
      }
    }
  },
  [51225074] = {
    51225074,
    507,
    1,
    common[80],
    {
      [1] = {
        [1] = 30
      },
      [2] = {
        affixType = 26,
        monsterID = 512202411,
        buffList = {51225073}
      }
    }
  },
  [51225075] = {
    51225075,
    507,
    1,
    common[80],
    {
      [1] = {
        [1] = 30
      },
      [2] = {
        affixType = 26,
        monsterID = 512202511,
        buffList = {51225073}
      }
    }
  },
  [51225083] = {
    51225083,
    508,
    1,
    common[80],
    {
      [1] = {
        [1] = 60
      },
      [2] = {
        affixType = 26,
        monsterID = 512202311,
        buffList = {51225083}
      }
    }
  },
  [51225084] = {
    51225084,
    508,
    1,
    common[80],
    {
      [1] = {
        [1] = 60
      },
      [2] = {
        affixType = 26,
        monsterID = 512202411,
        buffList = {51225083}
      }
    }
  },
  [51225085] = {
    51225085,
    508,
    1,
    common[80],
    {
      [1] = {
        [1] = 60
      },
      [2] = {
        affixType = 26,
        monsterID = 512202511,
        buffList = {51225083}
      }
    }
  },
  [51225091] = {
    51225091,
    509,
    1,
    common[81],
    {
      [1] = {},
      [2] = {
        affixType = 14,
        waveNum = 1,
        sourceID = 282051111,
        targetID = 282051211
      },
      [3] = {
        affixType = 14,
        waveNum = 1,
        sourceID = 282051121,
        targetID = 282051221
      }
    }
  },
  [51225092] = {
    51225092,
    509,
    1,
    common[81],
    {
      [1] = {},
      [2] = {
        affixType = 14,
        waveNum = 1,
        sourceID = 282051112,
        targetID = 282051212
      },
      [3] = {
        affixType = 14,
        waveNum = 1,
        sourceID = 282051122,
        targetID = 282051222
      }
    }
  },
  [51225093] = {
    51225093,
    509,
    1,
    common[81],
    {
      [1] = {},
      [2] = {
        affixType = 14,
        waveNum = 1,
        sourceID = 282051113,
        targetID = 282051213
      },
      [3] = {
        affixType = 14,
        waveNum = 1,
        sourceID = 282051123,
        targetID = 282051223
      }
    }
  },
  [51225094] = {
    51225094,
    509,
    1,
    common[81],
    {
      [1] = {},
      [2] = {
        affixType = 14,
        waveNum = 1,
        sourceID = 282051114,
        targetID = 282051214
      },
      [3] = {
        affixType = 14,
        waveNum = 1,
        sourceID = 282051124,
        targetID = 282051224
      }
    }
  },
  [51225095] = {
    51225095,
    509,
    1,
    common[81],
    {
      [1] = {},
      [2] = {
        affixType = 14,
        waveNum = 1,
        sourceID = 282051115,
        targetID = 282051215
      },
      [3] = {
        affixType = 14,
        waveNum = 1,
        sourceID = 282051125,
        targetID = 282051225
      }
    }
  },
  [51225103] = {
    51225103,
    510,
    1,
    common[82],
    {
      [1] = {},
      [2] = {
        affixType = 14,
        waveNum = 1,
        sourceID = 2800503,
        targetID = 2800505
      }
    }
  },
  [51225104] = {
    51225104,
    510,
    1,
    common[82],
    common[142]
  },
  [51225105] = {
    51225105,
    510,
    1,
    common[82],
    common[142]
  },
  [51225111] = {
    51225111,
    511,
    1,
    common[83],
    {
      [1] = {},
      [2] = {
        affixType = 7,
        monsterID = 512202111,
        sourceSkillID = 290181103,
        targetSkillID = 290181113
      }
    }
  },
  [51225112] = {
    51225112,
    511,
    1,
    common[83],
    {
      [1] = {},
      [2] = {
        affixType = 7,
        monsterID = 512202211,
        sourceSkillID = 290182103,
        targetSkillID = 290182113
      }
    }
  },
  [51225113] = {
    51225113,
    511,
    1,
    common[83],
    {
      [1] = {},
      [2] = {
        affixType = 7,
        monsterID = 512202311,
        sourceSkillID = 290182103,
        targetSkillID = 290182113
      }
    }
  },
  [51225114] = {
    51225114,
    511,
    1,
    common[83],
    {
      [1] = {},
      [2] = {
        affixType = 7,
        monsterID = 512202411,
        sourceSkillID = 290183103,
        targetSkillID = 290183123
      },
      [3] = {
        affixType = 14,
        waveNum = 1,
        sourceID = 2810521,
        targetID = 2810522
      },
      [4] = {
        affixType = 14,
        waveNum = 1,
        sourceID = 2810521,
        targetID = 2810522
      },
      [5] = {
        affixType = 14,
        waveNum = 1,
        sourceID = 2810521,
        targetID = 2810522
      }
    }
  },
  [51225115] = {
    51225115,
    511,
    1,
    common[83],
    {
      [1] = {},
      [2] = {
        affixType = 7,
        monsterID = 512202511,
        sourceSkillID = 290183103,
        targetSkillID = 290183123
      },
      [3] = {
        affixType = 14,
        waveNum = 1,
        sourceID = 2810521,
        targetID = 2810522
      },
      [4] = {
        affixType = 14,
        waveNum = 1,
        sourceID = 2810521,
        targetID = 2810522
      },
      [5] = {
        affixType = 14,
        waveNum = 1,
        sourceID = 2810521,
        targetID = 2810522
      }
    }
  },
  [51225124] = {
    51225124,
    512,
    1,
    common[84],
    {
      [1] = {},
      [2] = {
        affixType = 31,
        skillType = 1,
        monsterID = 512202411,
        skillID = 290183110
      },
      [3] = {
        affixType = 7,
        monsterID = 512202411,
        sourceSkillID = 290183102,
        targetSkillID = 290183112
      }
    }
  },
  [51225125] = {
    51225125,
    512,
    1,
    common[84],
    {
      [1] = {},
      [2] = {
        affixType = 31,
        skillType = 1,
        monsterID = 512202511,
        skillID = 290183110
      },
      [3] = {
        affixType = 7,
        monsterID = 512202511,
        sourceSkillID = 290183102,
        targetSkillID = 290183112
      }
    }
  },
  [51325134] = {
    51325134,
    513,
    1,
    common[85],
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 7,
        monsterID = 512202411,
        sourceSkillID = 290183103,
        targetSkillID = 290183113
      },
      [3] = {
        affixType = 7,
        monsterID = 512202411,
        sourceSkillID = 290183123,
        targetSkillID = 290183133
      },
      [4] = {
        affixType = 14,
        waveNum = 1,
        sourceID = 2810521,
        targetID = 2820521
      },
      [5] = {
        affixType = 14,
        waveNum = 1,
        sourceID = 2810521,
        targetID = 2820521
      },
      [6] = {
        affixType = 14,
        waveNum = 1,
        sourceID = 2810521,
        targetID = 2820521
      },
      [7] = {
        affixType = 14,
        waveNum = 1,
        sourceID = 2810522,
        targetID = 2820522
      },
      [8] = {
        affixType = 14,
        waveNum = 1,
        sourceID = 2810522,
        targetID = 2820522
      },
      [9] = {
        affixType = 14,
        waveNum = 1,
        sourceID = 2810522,
        targetID = 2820522
      }
    }
  },
  [51325135] = {
    51325135,
    513,
    1,
    common[85],
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 7,
        monsterID = 512202511,
        sourceSkillID = 290183103,
        targetSkillID = 290183113
      },
      [3] = {
        affixType = 7,
        monsterID = 512202511,
        sourceSkillID = 290183123,
        targetSkillID = 290183133
      },
      [4] = {
        affixType = 14,
        waveNum = 1,
        sourceID = 2810521,
        targetID = 2820521
      },
      [5] = {
        affixType = 14,
        waveNum = 1,
        sourceID = 2810521,
        targetID = 2820521
      },
      [6] = {
        affixType = 14,
        waveNum = 1,
        sourceID = 2810521,
        targetID = 2820521
      },
      [7] = {
        affixType = 14,
        waveNum = 1,
        sourceID = 2810522,
        targetID = 2820522
      },
      [8] = {
        affixType = 14,
        waveNum = 1,
        sourceID = 2810522,
        targetID = 2820522
      },
      [9] = {
        affixType = 14,
        waveNum = 1,
        sourceID = 2810522,
        targetID = 2820522
      }
    }
  },
  [51325141] = {
    51325141,
    514,
    1,
    common[86],
    {
      [1] = {
        [1] = 1.4
      },
      [2] = {
        affixType = 26,
        monsterID = 512202111,
        buffList = {51325141}
      }
    }
  },
  [51325142] = {
    51325142,
    514,
    1,
    common[86],
    {
      [1] = {
        [1] = 1.4
      },
      [2] = {
        affixType = 26,
        monsterID = 512202211,
        buffList = {51325141}
      }
    }
  },
  [51325143] = {
    51325143,
    514,
    1,
    common[86],
    {
      [1] = {
        [1] = 1.4
      },
      [2] = {
        affixType = 26,
        monsterID = 512202311,
        buffList = {51325141}
      }
    }
  },
  [51325144] = {
    51325144,
    514,
    1,
    common[86],
    {
      [1] = {
        [1] = 1.4
      },
      [2] = {
        affixType = 26,
        monsterID = 512202411,
        buffList = {51325141}
      }
    }
  },
  [51325145] = {
    51325145,
    514,
    1,
    common[86],
    {
      [1] = {
        [1] = 1.4
      },
      [2] = {
        affixType = 26,
        monsterID = 512202511,
        buffList = {51325141}
      }
    }
  },
  [51325151] = {
    51325151,
    515,
    1,
    common[86],
    {
      [1] = {
        [1] = 1.8
      },
      [2] = {
        affixType = 26,
        monsterID = 512202111,
        buffList = {51325151}
      }
    }
  },
  [51325152] = {
    51325152,
    515,
    1,
    common[86],
    {
      [1] = {
        [1] = 1.8
      },
      [2] = {
        affixType = 26,
        monsterID = 512202211,
        buffList = {51325151}
      }
    }
  },
  [51325153] = {
    51325153,
    515,
    1,
    common[86],
    {
      [1] = {
        [1] = 1.8
      },
      [2] = {
        affixType = 26,
        monsterID = 512202311,
        buffList = {51325151}
      }
    }
  },
  [51325154] = {
    51325154,
    515,
    1,
    common[86],
    {
      [1] = {
        [1] = 1.8
      },
      [2] = {
        affixType = 26,
        monsterID = 512202411,
        buffList = {51325151}
      }
    }
  },
  [51325155] = {
    51325155,
    515,
    1,
    common[86],
    {
      [1] = {
        [1] = 1.8
      },
      [2] = {
        affixType = 26,
        monsterID = 512202511,
        buffList = {51325151}
      }
    }
  },
  [51325161] = {
    51325161,
    516,
    1,
    common[87],
    {
      [1] = {
        [1] = 1.8,
        [2] = 1
      },
      [2] = {
        affixType = 26,
        monsterID = 512202111,
        buffList = {51325151}
      },
      [3] = {
        affixType = 26,
        monsterID = 512202111,
        buffList = {51325161}
      }
    }
  },
  [51325162] = {
    51325162,
    516,
    1,
    common[87],
    {
      [1] = {
        [1] = 1.8,
        [2] = 1
      },
      [2] = {
        affixType = 26,
        monsterID = 512202211,
        buffList = {51325151}
      },
      [3] = {
        affixType = 26,
        monsterID = 512202211,
        buffList = {51325161}
      }
    }
  },
  [51325163] = {
    51325163,
    516,
    1,
    common[87],
    {
      [1] = {
        [1] = 1.8,
        [2] = 1
      },
      [2] = {
        affixType = 26,
        monsterID = 512202311,
        buffList = {51325151}
      },
      [3] = {
        affixType = 26,
        monsterID = 512202311,
        buffList = {51325161}
      }
    }
  },
  [51325164] = {
    51325164,
    516,
    1,
    common[87],
    {
      [1] = {
        [1] = 1.8,
        [2] = 1
      },
      [2] = {
        affixType = 26,
        monsterID = 512202411,
        buffList = {51325151}
      },
      [3] = {
        affixType = 26,
        monsterID = 512202411,
        buffList = {51325161}
      }
    }
  },
  [51325165] = {
    51325165,
    516,
    1,
    common[87],
    {
      [1] = {
        [1] = 1.8,
        [2] = 1
      },
      [2] = {
        affixType = 26,
        monsterID = 512202511,
        buffList = {51325151}
      },
      [3] = {
        affixType = 26,
        monsterID = 512202511,
        buffList = {51325161}
      }
    }
  },
  [51325173] = {
    51325173,
    517,
    1,
    common[88],
    common[131]
  },
  [51325174] = {
    51325174,
    517,
    1,
    common[88],
    common[131]
  },
  [51325175] = {
    51325175,
    517,
    1,
    common[88],
    common[131]
  },
  [51325181] = {
    51325181,
    518,
    1,
    common[89],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512202111,
        eliteBuffList = {104701}
      }
    }
  },
  [51325182] = {
    51325182,
    518,
    1,
    common[89],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512202211,
        eliteBuffList = {104701}
      }
    }
  },
  [51325183] = {
    51325183,
    518,
    1,
    common[89],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512202311,
        eliteBuffList = {104701}
      }
    }
  },
  [51325184] = {
    51325184,
    518,
    1,
    common[89],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512202411,
        eliteBuffList = {104701}
      }
    }
  },
  [51325185] = {
    51325185,
    518,
    1,
    common[89],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512202511,
        eliteBuffList = {104701}
      }
    }
  },
  [51325191] = {
    51325191,
    519,
    1,
    common[90],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512202111,
        eliteBuffList = {104702}
      }
    }
  },
  [51325192] = {
    51325192,
    519,
    1,
    common[90],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512202211,
        eliteBuffList = {104702}
      }
    }
  },
  [51325193] = {
    51325193,
    519,
    1,
    common[90],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512202311,
        eliteBuffList = {104702}
      }
    }
  },
  [51325194] = {
    51325194,
    519,
    1,
    common[90],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512202411,
        eliteBuffList = {104702}
      }
    }
  },
  [51325195] = {
    51325195,
    519,
    1,
    common[90],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512202511,
        eliteBuffList = {104702}
      }
    }
  },
  [51325201] = {
    51325201,
    520,
    1,
    common[91],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512202111,
        eliteBuffList = {104703}
      }
    }
  },
  [51325202] = {
    51325202,
    520,
    1,
    common[91],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512202211,
        eliteBuffList = {104703}
      }
    }
  },
  [51325203] = {
    51325203,
    520,
    1,
    common[91],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512202311,
        eliteBuffList = {104703}
      }
    }
  },
  [51325204] = {
    51325204,
    520,
    1,
    common[91],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512202411,
        eliteBuffList = {104703}
      }
    }
  },
  [51325205] = {
    51325205,
    520,
    1,
    common[91],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512202511,
        eliteBuffList = {104703}
      }
    }
  },
  [51325211] = {
    51325211,
    521,
    1,
    common[92],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512202111,
        eliteBuffList = {104301}
      }
    }
  },
  [51325212] = {
    51325212,
    521,
    1,
    common[92],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512202211,
        eliteBuffList = {104301}
      }
    }
  },
  [51325213] = {
    51325213,
    521,
    1,
    common[92],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512202311,
        eliteBuffList = {104301}
      }
    }
  },
  [51325214] = {
    51325214,
    521,
    1,
    common[92],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512202411,
        eliteBuffList = {104301}
      }
    }
  },
  [51325215] = {
    51325215,
    521,
    1,
    common[92],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512202511,
        eliteBuffList = {104301}
      }
    }
  },
  [51325221] = {
    51325221,
    522,
    1,
    common[93],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512202111,
        eliteBuffList = {104302}
      }
    }
  },
  [51325222] = {
    51325222,
    522,
    1,
    common[93],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512202211,
        eliteBuffList = {104302}
      }
    }
  },
  [51325223] = {
    51325223,
    522,
    1,
    common[93],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512202311,
        eliteBuffList = {104302}
      }
    }
  },
  [51325224] = {
    51325224,
    522,
    1,
    common[93],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512202411,
        eliteBuffList = {104302}
      }
    }
  },
  [51325225] = {
    51325225,
    522,
    1,
    common[93],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512202511,
        eliteBuffList = {104302}
      }
    }
  },
  [51325231] = {
    51325231,
    523,
    1,
    common[94],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512202111,
        eliteBuffList = {104303}
      }
    }
  },
  [51325232] = {
    51325232,
    523,
    1,
    common[94],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512202211,
        eliteBuffList = {104303}
      }
    }
  },
  [51325233] = {
    51325233,
    523,
    1,
    common[94],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512202311,
        eliteBuffList = {104303}
      }
    }
  },
  [51325234] = {
    51325234,
    523,
    1,
    common[94],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512202411,
        eliteBuffList = {104303}
      }
    }
  },
  [51325235] = {
    51325235,
    523,
    1,
    common[94],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 512202511,
        eliteBuffList = {104303}
      }
    }
  },
  [88888888] = {
    88888888,
    888,
    1,
    common[95],
    {
      [1] = {},
      [2] = {
        affixType = 32,
        dir = {0, -1}
      }
    }
  },
  [88888889] = {
    88888889,
    888,
    1,
    common[95],
    {
      [1] = {},
      [2] = {
        affixType = 32,
        dir = {0, 1}
      }
    }
  },
  [52122011] = {
    52122011,
    21201,
    1,
    "str_n20_crisis_contract_affix_des_52122011",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200411,
        buffList = {5212208}
      }
    }
  },
  [52122021] = {
    52122021,
    21202,
    1,
    "str_n20_crisis_contract_affix_des_52122021",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200411,
        buffList = {5212204}
      }
    }
  },
  [52122022] = {
    52122022,
    21202,
    1,
    "str_n20_crisis_contract_affix_des_52122022",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200511,
        buffList = {5212204}
      }
    }
  },
  [52122031] = {
    52122031,
    21203,
    1,
    "str_n20_crisis_contract_affix_des_52122031",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200411,
        buffList = {5212205}
      }
    }
  },
  [52122032] = {
    52122032,
    21203,
    1,
    "str_n20_crisis_contract_affix_des_52122032",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200511,
        buffList = {5212205}
      }
    }
  },
  [52122041] = {
    52122041,
    21204,
    1,
    "str_n20_crisis_contract_affix_des_52122041",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200411,
        buffList = {5212206}
      }
    }
  },
  [52122042] = {
    52122042,
    21204,
    1,
    "str_n20_crisis_contract_affix_des_52122042",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200511,
        buffList = {5212206}
      }
    }
  },
  [52122043] = {
    52122043,
    21204,
    1,
    "str_n20_crisis_contract_affix_des_52122043",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200611,
        buffList = {5212206}
      }
    }
  },
  [52122051] = {
    52122051,
    21205,
    1,
    "str_n20_crisis_contract_affix_des_52122051",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200411,
        buffList = {5212209}
      }
    }
  },
  [52122052] = {
    52122052,
    21205,
    1,
    "str_n20_crisis_contract_affix_des_52122052",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200511,
        buffList = {5212212}
      }
    }
  },
  [52122053] = {
    52122053,
    21205,
    1,
    "str_n20_crisis_contract_affix_des_52122053",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200611,
        buffList = {5212215}
      }
    }
  },
  [52122061] = {
    52122061,
    21206,
    1,
    "str_n20_crisis_contract_affix_des_52122061",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200411,
        buffList = {5212210}
      }
    }
  },
  [52122062] = {
    52122062,
    21206,
    1,
    "str_n20_crisis_contract_affix_des_52122062",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200511,
        buffList = {5212213}
      }
    }
  },
  [52122063] = {
    52122063,
    21206,
    1,
    "str_n20_crisis_contract_affix_des_52122063",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200611,
        buffList = {5212216}
      }
    }
  },
  [52122071] = {
    52122071,
    21207,
    1,
    "str_n20_crisis_contract_affix_des_52122071",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200411,
        buffList = {5212211}
      }
    }
  },
  [52122072] = {
    52122072,
    21207,
    1,
    "str_n20_crisis_contract_affix_des_52122072",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200511,
        buffList = {5212214}
      }
    }
  },
  [52122073] = {
    52122073,
    21207,
    1,
    "str_n20_crisis_contract_affix_des_52122073",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200611,
        buffList = {5212217}
      }
    }
  },
  [52122082] = {
    52122082,
    21208,
    1,
    "str_n20_crisis_contract_affix_des_52122081",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200511,
        buffList = {5212201}
      }
    }
  },
  [52122083] = {
    52122083,
    21208,
    1,
    "str_n20_crisis_contract_affix_des_52122082",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200611,
        buffList = {5212201}
      }
    }
  },
  [52122092] = {
    52122092,
    21209,
    1,
    "str_n20_crisis_contract_affix_des_52122091",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200511,
        buffList = {5212202}
      }
    }
  },
  [52122093] = {
    52122093,
    21209,
    1,
    "str_n20_crisis_contract_affix_des_52122092",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200611,
        buffList = {5212202}
      }
    }
  },
  [52122102] = {
    52122102,
    21210,
    1,
    "str_n20_crisis_contract_affix_des_52122101",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200511,
        buffList = {5212203}
      }
    }
  },
  [52122103] = {
    52122103,
    21210,
    1,
    "str_n20_crisis_contract_affix_des_52122102",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200611,
        buffList = {5212203}
      }
    }
  },
  [52122111] = {
    52122111,
    21211,
    1,
    "str_n20_crisis_contract_affix_des_52122111",
    {
      [1] = {},
      [2] = {
        affixType = 7,
        monsterID = 521200411,
        sourceSkillID = 10071231,
        targetSkillID = 10071232
      },
      [3] = {
        affixType = 24,
        monsterID = 521200411,
        buffList = {
          5212225,
          5212226,
          52122261,
          5212228
        }
      }
    }
  },
  [52122112] = {
    52122112,
    21211,
    1,
    "str_n20_crisis_contract_affix_des_52122112",
    {
      [1] = {},
      [2] = {
        affixType = 7,
        monsterID = 521200511,
        sourceSkillID = 10071231,
        targetSkillID = 10071232
      },
      [3] = {
        affixType = 24,
        monsterID = 521200511,
        buffList = {
          5212225,
          5212226,
          52122261,
          5212228
        }
      }
    }
  },
  [52122113] = {
    52122113,
    21211,
    1,
    "str_n20_crisis_contract_affix_des_52122113",
    {
      [1] = {},
      [2] = {
        affixType = 7,
        monsterID = 521200611,
        sourceSkillID = 10071231,
        targetSkillID = 10071232
      },
      [3] = {
        affixType = 24,
        monsterID = 521200611,
        buffList = {
          5212225,
          5212226,
          52122261,
          5212228
        }
      }
    }
  },
  [52122121] = {
    52122121,
    21212,
    1,
    "str_n20_crisis_contract_affix_des_52122121",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200411,
        buffList = {5212207}
      }
    }
  },
  [52122132] = {
    52122132,
    21213,
    1,
    "str_n20_crisis_contract_affix_des_52122131",
    {
      [1] = {},
      [2] = {
        affixType = 7,
        monsterID = 521200511,
        sourceSkillID = 10071242,
        targetSkillID = 100712421
      }
    }
  },
  [52122133] = {
    52122133,
    21213,
    1,
    "str_n20_crisis_contract_affix_des_52122132",
    {
      [1] = {},
      [2] = {
        affixType = 7,
        monsterID = 521200611,
        sourceSkillID = 10071243,
        targetSkillID = 100712431
      }
    }
  },
  [52122143] = {
    52122143,
    21214,
    1,
    "str_n20_crisis_contract_affix_des_52122141",
    {
      [1] = {},
      [2] = {affixType = 2, count = 4}
    }
  },
  [52122151] = {
    52122151,
    21215,
    1,
    "str_n20_crisis_contract_affix_des_52122151",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200411,
        buffList = {5212220}
      }
    }
  },
  [52122152] = {
    52122152,
    21215,
    1,
    "str_n20_crisis_contract_affix_des_52122152",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200511,
        buffList = {5212221}
      }
    }
  },
  [52122153] = {
    52122153,
    21215,
    1,
    "str_n20_crisis_contract_affix_des_52122153",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200611,
        buffList = {5212223}
      }
    }
  },
  [52122161] = {
    52122161,
    21216,
    1,
    "str_n20_crisis_contract_affix_des_52122161",
    {
      [1] = {},
      [2] = {
        affixType = 16,
        waveNum = 1,
        id = 521200412,
        pos = {1, 8}
      }
    }
  },
  [52122162] = {
    52122162,
    21216,
    1,
    "str_n20_crisis_contract_affix_des_52122162",
    {
      [1] = {},
      [2] = {
        affixType = 16,
        waveNum = 1,
        id = 521200512,
        pos = {1, 8}
      }
    }
  },
  [52122163] = {
    52122163,
    21216,
    1,
    "str_n20_crisis_contract_affix_des_52122163",
    {
      [1] = {},
      [2] = {
        affixType = 16,
        waveNum = 1,
        id = 521200612,
        pos = {1, 8}
      }
    }
  },
  [52122171] = {
    52122171,
    21217,
    1,
    "str_n20_crisis_contract_affix_des_52122171",
    {
      [1] = {},
      [2] = {
        affixType = 16,
        waveNum = 1,
        id = 521200413,
        pos = {8, 8}
      }
    }
  },
  [52122172] = {
    52122172,
    21217,
    1,
    "str_n20_crisis_contract_affix_des_52122172",
    {
      [1] = {},
      [2] = {
        affixType = 16,
        waveNum = 1,
        id = 521200513,
        pos = {8, 8}
      }
    }
  },
  [52122173] = {
    52122173,
    21217,
    1,
    "str_n20_crisis_contract_affix_des_52122173",
    {
      [1] = {},
      [2] = {
        affixType = 16,
        waveNum = 1,
        id = 521200613,
        pos = {8, 8}
      }
    }
  },
  [52122181] = {
    52122181,
    21218,
    1,
    "str_n20_crisis_contract_affix_des_52122181",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200411,
        eliteBuffList = {101801}
      }
    }
  },
  [52122182] = {
    52122182,
    21218,
    1,
    "str_n20_crisis_contract_affix_des_52122182",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200511,
        eliteBuffList = {101801}
      }
    }
  },
  [52122183] = {
    52122183,
    21218,
    1,
    "str_n20_crisis_contract_affix_des_52122183",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200611,
        eliteBuffList = {101801}
      }
    }
  },
  [52122191] = {
    52122191,
    21219,
    1,
    "str_n20_crisis_contract_affix_des_52122191",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200411,
        eliteBuffList = {101802}
      }
    }
  },
  [52122192] = {
    52122192,
    21219,
    1,
    "str_n20_crisis_contract_affix_des_52122192",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200511,
        eliteBuffList = {101802}
      }
    }
  },
  [52122193] = {
    52122193,
    21219,
    1,
    "str_n20_crisis_contract_affix_des_52122193",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200611,
        eliteBuffList = {101802}
      }
    }
  },
  [52122201] = {
    52122201,
    21220,
    1,
    "str_n20_crisis_contract_affix_des_52122201",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200411,
        eliteBuffList = {101803}
      }
    }
  },
  [52122202] = {
    52122202,
    21220,
    1,
    "str_n20_crisis_contract_affix_des_52122202",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200511,
        eliteBuffList = {101803}
      }
    }
  },
  [52122203] = {
    52122203,
    21220,
    1,
    "str_n20_crisis_contract_affix_des_52122203",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200611,
        eliteBuffList = {101803}
      }
    }
  },
  [52122213] = {
    52122213,
    21221,
    1,
    "str_n20_crisis_contract_affix_des_52122211",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200611,
        eliteBuffList = {103001}
      }
    }
  },
  [52122223] = {
    52122223,
    21222,
    1,
    "str_n20_crisis_contract_affix_des_52122221",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200611,
        eliteBuffList = {103002}
      }
    }
  },
  [52122233] = {
    52122233,
    21223,
    1,
    "str_n20_crisis_contract_affix_des_52122231",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200611,
        eliteBuffList = {103003}
      }
    }
  },
  [52122241] = {
    52122241,
    21224,
    1,
    "str_n20_crisis_contract_affix_des_52122241",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200411,
        eliteBuffList = {102701}
      }
    }
  },
  [52122242] = {
    52122242,
    21224,
    1,
    "str_n20_crisis_contract_affix_des_52122242",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200511,
        eliteBuffList = {102701}
      }
    }
  },
  [52122243] = {
    52122243,
    21224,
    1,
    "str_n20_crisis_contract_affix_des_52122243",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200611,
        eliteBuffList = {102701}
      }
    }
  },
  [52122251] = {
    52122251,
    21225,
    1,
    "str_n20_crisis_contract_affix_des_52122251",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200411,
        eliteBuffList = {105801}
      }
    }
  },
  [52122252] = {
    52122252,
    21225,
    1,
    "str_n20_crisis_contract_affix_des_52122252",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200511,
        eliteBuffList = {105801}
      }
    }
  },
  [52122253] = {
    52122253,
    21225,
    1,
    "str_n20_crisis_contract_affix_des_52122253",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200611,
        eliteBuffList = {105801}
      }
    }
  },
  [52123011] = {
    52123011,
    21301,
    1,
    "str_n20_crisis_contract_affix_des_52123011",
    {
      [1] = {
        [1] = 50
      },
      [2] = {
        affixType = 26,
        monsterID = 521200712,
        buffList = {5212301}
      }
    }
  },
  [52123021] = {
    52123021,
    21302,
    1,
    "str_n20_crisis_contract_affix_des_52123021",
    {
      [1] = {
        [1] = 15
      },
      [2] = {
        affixType = 26,
        monsterID = 521200711,
        buffList = {5212302}
      }
    }
  },
  [52123022] = {
    52123022,
    21302,
    1,
    "str_n20_crisis_contract_affix_des_52123022",
    {
      [1] = {
        [1] = 15
      },
      [2] = {
        affixType = 26,
        monsterID = 521200811,
        buffList = {5212302}
      }
    }
  },
  [52123031] = {
    52123031,
    21303,
    1,
    "str_n20_crisis_contract_affix_des_52123031",
    {
      [1] = {
        [1] = 30
      },
      [2] = {
        affixType = 26,
        monsterID = 521200711,
        buffList = {5212303}
      }
    }
  },
  [52123032] = {
    52123032,
    21303,
    1,
    "str_n20_crisis_contract_affix_des_52123032",
    {
      [1] = {
        [1] = 30
      },
      [2] = {
        affixType = 26,
        monsterID = 521200811,
        buffList = {5212303}
      }
    }
  },
  [52123041] = {
    52123041,
    21304,
    1,
    "str_n20_crisis_contract_affix_des_52123041",
    {
      [1] = {
        [1] = 50
      },
      [2] = {
        affixType = 26,
        monsterID = 521200711,
        buffList = {5212304}
      }
    }
  },
  [52123042] = {
    52123042,
    21304,
    1,
    "str_n20_crisis_contract_affix_des_52123042",
    {
      [1] = {
        [1] = 50
      },
      [2] = {
        affixType = 26,
        monsterID = 521200811,
        buffList = {5212304}
      }
    }
  },
  [52123052] = {
    52123052,
    21305,
    1,
    "str_n20_crisis_contract_affix_des_52123052",
    {
      [1] = {
        [1] = 60
      },
      [2] = {
        affixType = 26,
        monsterID = 521200811,
        buffList = {5212305}
      }
    }
  },
  [52123053] = {
    52123053,
    21305,
    1,
    "str_n20_crisis_contract_affix_des_52123053",
    {
      [1] = {
        [1] = 60
      },
      [2] = {
        affixType = 26,
        monsterID = 521200911,
        buffList = {5212305}
      }
    }
  },
  [52123062] = {
    52123062,
    21306,
    1,
    "str_n20_crisis_contract_affix_des_52123062",
    {
      [1] = {
        [1] = 40
      },
      [2] = {
        affixType = 26,
        monsterID = 521200811,
        buffList = {5212306}
      }
    }
  },
  [52123063] = {
    52123063,
    21306,
    1,
    "str_n20_crisis_contract_affix_des_52123063",
    {
      [1] = {
        [1] = 40
      },
      [2] = {
        affixType = 26,
        monsterID = 521200911,
        buffList = {5212306}
      }
    }
  },
  [52123072] = {
    52123072,
    21307,
    1,
    "str_n20_crisis_contract_affix_des_52123072",
    {
      [1] = {
        [1] = 20
      },
      [2] = {
        affixType = 26,
        monsterID = 521200811,
        buffList = {5212307}
      }
    }
  },
  [52123073] = {
    52123073,
    21307,
    1,
    "str_n20_crisis_contract_affix_des_52123073",
    {
      [1] = {
        [1] = 20
      },
      [2] = {
        affixType = 26,
        monsterID = 521200911,
        buffList = {5212307}
      }
    }
  },
  [52123081] = {
    52123081,
    21308,
    1,
    "str_n20_crisis_contract_affix_des_52123081",
    {
      [1] = {},
      [2] = {
        affixType = 24,
        monsterID = 521200712,
        buffList = {}
      }
    }
  },
  [52123091] = {
    52123091,
    21309,
    1,
    "str_n20_crisis_contract_affix_des_52123091",
    common[143]
  },
  [52123092] = {
    52123092,
    21309,
    1,
    "str_n20_crisis_contract_affix_des_52123092",
    common[143]
  },
  [52123093] = {
    52123093,
    21309,
    1,
    "str_n20_crisis_contract_affix_des_52123093",
    common[143]
  },
  [52123101] = {
    52123101,
    21310,
    1,
    "str_n20_crisis_contract_affix_des_52123101",
    {
      [1] = {
        [1] = 3
      },
      [2] = {
        affixType = 26,
        monsterID = 521200711,
        buffList = {5212310}
      }
    }
  },
  [52123102] = {
    52123102,
    21310,
    1,
    "str_n20_crisis_contract_affix_des_52123102",
    {
      [1] = {
        [1] = 3
      },
      [2] = {
        affixType = 26,
        monsterID = 521200811,
        buffList = {5212310}
      }
    }
  },
  [52123103] = {
    52123103,
    21310,
    1,
    "str_n20_crisis_contract_affix_des_52123103",
    {
      [1] = {
        [1] = 3
      },
      [2] = {
        affixType = 26,
        monsterID = 521200911,
        buffList = {5212310}
      }
    }
  },
  [52123111] = {
    52123111,
    21311,
    1,
    "str_n20_crisis_contract_affix_des_52123111",
    {
      [1] = {
        [1] = 1.5
      },
      [2] = {
        affixType = 26,
        monsterID = 521200711,
        buffList = {5212311}
      }
    }
  },
  [52123112] = {
    52123112,
    21311,
    1,
    "str_n20_crisis_contract_affix_des_52123112",
    {
      [1] = {
        [1] = 1.5
      },
      [2] = {
        affixType = 26,
        monsterID = 521200811,
        buffList = {5212311}
      }
    }
  },
  [52123113] = {
    52123113,
    21311,
    1,
    "str_n20_crisis_contract_affix_des_52123113",
    {
      [1] = {
        [1] = 1.5
      },
      [2] = {
        affixType = 26,
        monsterID = 521200911,
        buffList = {5212311}
      }
    }
  },
  [52123122] = {
    52123122,
    21312,
    1,
    "str_n20_crisis_contract_affix_des_52123122",
    {
      [1] = {},
      [2] = {
        affixType = 31,
        monsterID = 521200812,
        skillType = 1,
        skillID = 5212312
      }
    }
  },
  [52123123] = {
    52123123,
    21312,
    1,
    "str_n20_crisis_contract_affix_des_52123123",
    {
      [1] = {},
      [2] = {
        affixType = 31,
        monsterID = 521200912,
        skillType = 1,
        skillID = 5212312
      }
    }
  },
  [52123131] = {
    52123131,
    21313,
    1,
    "str_n20_crisis_contract_affix_des_52123131",
    {
      [1] = {
        [1] = 15
      },
      [2] = {
        affixType = 26,
        monsterID = 521200712,
        buffList = {5212313}
      }
    }
  },
  [52123132] = {
    52123132,
    21313,
    1,
    "str_n20_crisis_contract_affix_des_52123132",
    {
      [1] = {
        [1] = 15
      },
      [2] = {
        affixType = 26,
        monsterID = 521200812,
        buffList = {5212313}
      }
    }
  },
  [52123133] = {
    52123133,
    21313,
    1,
    "str_n20_crisis_contract_affix_des_52123133",
    {
      [1] = {
        [1] = 15
      },
      [2] = {
        affixType = 26,
        monsterID = 521200912,
        buffList = {5212313}
      }
    }
  },
  [52123141] = {
    52123141,
    21314,
    1,
    "str_n20_crisis_contract_affix_des_52123141",
    {
      [1] = {
        [1] = 30
      },
      [2] = {
        affixType = 26,
        monsterID = 521200712,
        buffList = {5212314}
      }
    }
  },
  [52123142] = {
    52123142,
    21314,
    1,
    "str_n20_crisis_contract_affix_des_52123142",
    {
      [1] = {
        [1] = 30
      },
      [2] = {
        affixType = 26,
        monsterID = 521200812,
        buffList = {5212314}
      }
    }
  },
  [52123143] = {
    52123143,
    21314,
    1,
    "str_n20_crisis_contract_affix_des_52123143",
    {
      [1] = {
        [1] = 30
      },
      [2] = {
        affixType = 26,
        monsterID = 521200912,
        buffList = {5212314}
      }
    }
  },
  [52123151] = {
    52123151,
    21315,
    1,
    "str_n20_crisis_contract_affix_des_52123151",
    {
      [1] = {
        [1] = 50
      },
      [2] = {
        affixType = 26,
        monsterID = 521200712,
        buffList = {5212315}
      }
    }
  },
  [52123152] = {
    52123152,
    21315,
    1,
    "str_n20_crisis_contract_affix_des_52123152",
    {
      [1] = {
        [1] = 50
      },
      [2] = {
        affixType = 26,
        monsterID = 521200812,
        buffList = {5212315}
      }
    }
  },
  [52123153] = {
    52123153,
    21315,
    1,
    "str_n20_crisis_contract_affix_des_52123153",
    {
      [1] = {
        [1] = 50
      },
      [2] = {
        affixType = 26,
        monsterID = 521200912,
        buffList = {5212315}
      }
    }
  },
  [52123161] = {
    52123161,
    21316,
    1,
    "str_n20_crisis_contract_affix_des_52123161",
    {
      [1] = {
        [1] = 30
      },
      [2] = {
        affixType = 7,
        monsterID = 521200712,
        sourceSkillID = 200134101,
        targetSkillID = 52123161
      }
    }
  },
  [52123162] = {
    52123162,
    21316,
    1,
    "str_n20_crisis_contract_affix_des_52123162",
    {
      [1] = {
        [1] = 30
      },
      [2] = {
        affixType = 7,
        monsterID = 521200812,
        sourceSkillID = 200134201,
        targetSkillID = 52123162
      }
    }
  },
  [52123163] = {
    52123163,
    21316,
    1,
    "str_n20_crisis_contract_affix_des_52123163",
    {
      [1] = {
        [1] = 30
      },
      [2] = {
        affixType = 7,
        monsterID = 521200912,
        sourceSkillID = 200134301,
        targetSkillID = 52123163
      }
    }
  },
  [52123171] = {
    52123171,
    21317,
    1,
    "str_n20_crisis_contract_affix_des_52123171",
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 26,
        monsterID = 521200712,
        buffList = {5212317}
      }
    }
  },
  [52123172] = {
    52123172,
    21317,
    1,
    "str_n20_crisis_contract_affix_des_52123172",
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 26,
        monsterID = 521200812,
        buffList = {5212317}
      }
    }
  },
  [52123173] = {
    52123173,
    21317,
    1,
    "str_n20_crisis_contract_affix_des_52123173",
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 26,
        monsterID = 521200912,
        buffList = {5212317}
      }
    }
  },
  [52123181] = {
    52123181,
    21318,
    1,
    "str_n20_crisis_contract_affix_des_52123181",
    {
      [1] = {},
      [2] = {
        affixType = 7,
        monsterID = 521200712,
        sourceSkillID = 200134101,
        targetSkillID = 52123181
      },
      [3] = {
        affixType = 7,
        monsterID = 521200712,
        sourceSkillID = 52123161,
        targetSkillID = 52123184
      },
      [4] = {
        affixType = 7,
        monsterID = 521200712,
        sourceSkillID = 200134101,
        targetSkillID = 52123181
      },
      [5] = {
        affixType = 7,
        monsterID = 521200712,
        sourceSkillID = 52123161,
        targetSkillID = 52123184
      },
      [6] = {
        affixType = 7,
        monsterID = 521200712,
        sourceSkillID = 200134101,
        targetSkillID = 52123181
      },
      [7] = {
        affixType = 7,
        monsterID = 521200712,
        sourceSkillID = 52123161,
        targetSkillID = 52123184
      },
      [8] = {
        affixType = 7,
        monsterID = 521200712,
        sourceSkillID = 200134101,
        targetSkillID = 52123181
      },
      [9] = {
        affixType = 7,
        monsterID = 521200712,
        sourceSkillID = 52123161,
        targetSkillID = 52123184
      }
    }
  },
  [52123182] = {
    52123182,
    21318,
    1,
    "str_n20_crisis_contract_affix_des_52123182",
    {
      [1] = {},
      [2] = {
        affixType = 7,
        monsterID = 521200812,
        sourceSkillID = 200134201,
        targetSkillID = 52123182
      },
      [3] = {
        affixType = 7,
        monsterID = 521200812,
        sourceSkillID = 52123162,
        targetSkillID = 52123185
      },
      [4] = {
        affixType = 7,
        monsterID = 521200812,
        sourceSkillID = 200134201,
        targetSkillID = 52123182
      },
      [5] = {
        affixType = 7,
        monsterID = 521200812,
        sourceSkillID = 52123162,
        targetSkillID = 52123185
      },
      [6] = {
        affixType = 7,
        monsterID = 521200812,
        sourceSkillID = 200134201,
        targetSkillID = 52123182
      },
      [7] = {
        affixType = 7,
        monsterID = 521200812,
        sourceSkillID = 52123162,
        targetSkillID = 52123185
      },
      [8] = {
        affixType = 7,
        monsterID = 521200812,
        sourceSkillID = 200134201,
        targetSkillID = 52123182
      },
      [9] = {
        affixType = 7,
        monsterID = 521200812,
        sourceSkillID = 52123162,
        targetSkillID = 52123185
      }
    }
  },
  [52123191] = {
    52123191,
    21319,
    1,
    "str_n20_crisis_contract_affix_des_52123191",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200711,
        eliteBuffList = {101501}
      }
    }
  },
  [52123192] = {
    52123192,
    21319,
    1,
    "str_n20_crisis_contract_affix_des_52123192",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200811,
        eliteBuffList = {101501}
      }
    }
  },
  [52123193] = {
    52123193,
    21319,
    1,
    "str_n20_crisis_contract_affix_des_52123193",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200911,
        eliteBuffList = {101501}
      }
    }
  },
  [52123201] = {
    52123201,
    21320,
    1,
    "str_n20_crisis_contract_affix_des_52123201",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200711,
        eliteBuffList = {101502}
      }
    }
  },
  [52123202] = {
    52123202,
    21320,
    1,
    "str_n20_crisis_contract_affix_des_52123202",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200811,
        eliteBuffList = {101502}
      }
    }
  },
  [52123203] = {
    52123203,
    21320,
    1,
    "str_n20_crisis_contract_affix_des_52123203",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200911,
        eliteBuffList = {101502}
      }
    }
  },
  [52123211] = {
    52123211,
    21321,
    1,
    "str_n20_crisis_contract_affix_des_52123211",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200711,
        eliteBuffList = {101503}
      }
    }
  },
  [52123212] = {
    52123212,
    21321,
    1,
    "str_n20_crisis_contract_affix_des_52123212",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200811,
        eliteBuffList = {101503}
      }
    }
  },
  [52123213] = {
    52123213,
    21321,
    1,
    "str_n20_crisis_contract_affix_des_52123213",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200911,
        eliteBuffList = {101503}
      }
    }
  },
  [52123223] = {
    52123223,
    21322,
    1,
    "str_n20_crisis_contract_affix_des_52123223",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200911,
        eliteBuffList = {101601}
      }
    }
  },
  [52123233] = {
    52123233,
    21323,
    1,
    "str_n20_crisis_contract_affix_des_52123233",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200911,
        eliteBuffList = {101602}
      }
    }
  },
  [52123243] = {
    52123243,
    21324,
    1,
    "str_n20_crisis_contract_affix_des_52123243",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200911,
        eliteBuffList = {101603}
      }
    }
  },
  [52123253] = {
    52123253,
    21325,
    1,
    "str_n20_crisis_contract_affix_des_52123253",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200911,
        eliteBuffList = {1012}
      }
    }
  },
  [52124011] = {
    52124011,
    21401,
    1,
    "str_n20_crisis_contract_affix_des_52124011",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 2001505,
        buffList = {52120103}
      }
    }
  },
  [52124021] = {
    52124021,
    21402,
    1,
    "str_n20_crisis_contract_affix_des_52124021",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201011,
        buffList = {52120111}
      }
    }
  },
  [52124031] = {
    52124031,
    21403,
    1,
    "str_n20_crisis_contract_affix_des_52124031",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201011,
        buffList = {521201031}
      }
    }
  },
  [52124032] = {
    52124032,
    21403,
    1,
    "str_n20_crisis_contract_affix_des_52124032",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201111,
        buffList = {521201031}
      }
    }
  },
  [52124041] = {
    52124041,
    21404,
    1,
    "str_n20_crisis_contract_affix_des_52124041",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201011,
        buffList = {521201032}
      }
    }
  },
  [52124042] = {
    52124042,
    21404,
    1,
    "str_n20_crisis_contract_affix_des_52124042",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201111,
        buffList = {521201032}
      }
    }
  },
  [52124051] = {
    52124051,
    21405,
    1,
    "str_n20_crisis_contract_affix_des_52124051",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201011,
        buffList = {521201033}
      }
    }
  },
  [52124052] = {
    52124052,
    21405,
    1,
    "str_n20_crisis_contract_affix_des_52124052",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201111,
        buffList = {521201033}
      }
    }
  },
  [52124053] = {
    52124053,
    21405,
    1,
    "str_n20_crisis_contract_affix_des_52124053",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201211,
        buffList = {521201033}
      }
    }
  },
  [52124061] = {
    52124061,
    21406,
    1,
    "str_n20_crisis_contract_affix_des_52124061",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201011,
        buffList = {521201041}
      }
    }
  },
  [52124062] = {
    52124062,
    21406,
    1,
    "str_n20_crisis_contract_affix_des_52124062",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201111,
        buffList = {521201041}
      }
    }
  },
  [52124063] = {
    52124063,
    21406,
    1,
    "str_n20_crisis_contract_affix_des_52124063",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201211,
        buffList = {521201041}
      }
    }
  },
  [52124071] = {
    52124071,
    21407,
    1,
    "str_n20_crisis_contract_affix_des_52124071",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201011,
        buffList = {521201042}
      }
    }
  },
  [52124072] = {
    52124072,
    21407,
    1,
    "str_n20_crisis_contract_affix_des_52124072",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201111,
        buffList = {521201042}
      }
    }
  },
  [52124073] = {
    52124073,
    21407,
    1,
    "str_n20_crisis_contract_affix_des_52124073",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201211,
        buffList = {521201042}
      }
    }
  },
  [52124081] = {
    52124081,
    21408,
    1,
    "str_n20_crisis_contract_affix_des_52124081",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201011,
        buffList = {521201043}
      }
    }
  },
  [52124082] = {
    52124082,
    21408,
    1,
    "str_n20_crisis_contract_affix_des_52124082",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201111,
        buffList = {521201043}
      }
    }
  },
  [52124083] = {
    52124083,
    21408,
    1,
    "str_n20_crisis_contract_affix_des_52124083",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201211,
        buffList = {521201043}
      }
    }
  },
  [52124091] = {
    52124091,
    21409,
    1,
    "str_n20_crisis_contract_affix_des_52124091",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201011,
        buffList = {52120113}
      }
    }
  },
  [52124092] = {
    52124092,
    21409,
    1,
    "str_n20_crisis_contract_affix_des_52124092",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201111,
        buffList = {52120113}
      }
    }
  },
  [52124093] = {
    52124093,
    21409,
    1,
    "str_n20_crisis_contract_affix_des_52124093",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201211,
        buffList = {52120113}
      }
    }
  },
  [52124101] = {
    52124101,
    21410,
    1,
    "str_n20_crisis_contract_affix_des_52124101",
    {
      [1] = {},
      [2] = {
        affixType = 7,
        monsterID = 521201211,
        sourceSkillID = 290210111,
        targetSkillID = 290210121
      }
    }
  },
  [52124111] = {
    52124111,
    21411,
    1,
    common[96],
    common[144]
  },
  [52124112] = {
    52124112,
    21411,
    1,
    common[96],
    common[144]
  },
  [52124113] = {
    52124113,
    21411,
    1,
    common[96],
    common[144]
  },
  [52124121] = {
    52124121,
    21412,
    1,
    common[97],
    common[145]
  },
  [52124122] = {
    52124122,
    21412,
    1,
    common[97],
    common[145]
  },
  [52124123] = {
    52124123,
    21412,
    1,
    common[97],
    common[145]
  },
  [52124131] = {
    52124131,
    21413,
    1,
    "str_n20_crisis_contract_affix_des_52124131",
    {
      [1] = {},
      [2] = {
        affixType = 24,
        monsterID = 521201011,
        buffList = {52120109}
      }
    }
  },
  [52124132] = {
    52124132,
    21413,
    1,
    "str_n20_crisis_contract_affix_des_52124132",
    {
      [1] = {},
      [2] = {
        affixType = 24,
        monsterID = 521201111,
        buffList = {52120109}
      }
    }
  },
  [52124133] = {
    52124133,
    21413,
    1,
    "str_n20_crisis_contract_affix_des_52124133",
    {
      [1] = {},
      [2] = {
        affixType = 24,
        monsterID = 521201211,
        buffList = {52120109}
      }
    }
  },
  [52124141] = {
    52124141,
    21414,
    1,
    common[98],
    common[146]
  },
  [52124142] = {
    52124142,
    21414,
    1,
    common[98],
    common[146]
  },
  [52124151] = {
    52124151,
    21415,
    1,
    "str_n20_crisis_contract_affix_des_52124151",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201011,
        buffList = {52120107}
      }
    }
  },
  [52124152] = {
    52124152,
    21415,
    1,
    "str_n20_crisis_contract_affix_des_52124152",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201111,
        buffList = {52120107}
      }
    }
  },
  [52124153] = {
    52124153,
    21415,
    1,
    "str_n20_crisis_contract_affix_des_52124153",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201211,
        buffList = {52120107}
      }
    }
  },
  [52124161] = {
    52124161,
    21416,
    1,
    common[99],
    common[147]
  },
  [52124162] = {
    52124162,
    21416,
    1,
    common[99],
    common[147]
  },
  [52124171] = {
    52124171,
    21417,
    1,
    common[100],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201011,
        eliteBuffList = {103701}
      }
    }
  },
  [52124172] = {
    52124172,
    21417,
    1,
    common[100],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201111,
        eliteBuffList = {103701}
      }
    }
  },
  [52124173] = {
    52124173,
    21417,
    1,
    common[100],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201211,
        eliteBuffList = {103701}
      }
    }
  },
  [52124181] = {
    52124181,
    21418,
    1,
    common[101],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201011,
        eliteBuffList = {103702}
      }
    }
  },
  [52124182] = {
    52124182,
    21418,
    1,
    common[101],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201111,
        eliteBuffList = {103702}
      }
    }
  },
  [52124183] = {
    52124183,
    21418,
    1,
    common[101],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201211,
        eliteBuffList = {103702}
      }
    }
  },
  [52124191] = {
    52124191,
    21419,
    1,
    common[102],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201011,
        eliteBuffList = {103703}
      }
    }
  },
  [52124192] = {
    52124192,
    21419,
    1,
    common[102],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201111,
        eliteBuffList = {103703}
      }
    }
  },
  [52124193] = {
    52124193,
    21419,
    1,
    common[102],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201211,
        eliteBuffList = {103703}
      }
    }
  },
  [52124201] = {
    52124201,
    21420,
    1,
    common[103],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201011,
        eliteBuffList = {104702}
      }
    }
  },
  [52124202] = {
    52124202,
    21420,
    1,
    common[103],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201111,
        eliteBuffList = {104702}
      }
    }
  },
  [52124203] = {
    52124203,
    21420,
    1,
    common[103],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201211,
        eliteBuffList = {104702}
      }
    }
  },
  [52124211] = {
    52124211,
    21421,
    1,
    common[104],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201011,
        eliteBuffList = {104703}
      }
    }
  },
  [52124212] = {
    52124212,
    21421,
    1,
    common[104],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201111,
        eliteBuffList = {104703}
      }
    }
  },
  [52124213] = {
    52124213,
    21421,
    1,
    common[104],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201211,
        eliteBuffList = {104703}
      }
    }
  },
  [52124221] = {
    52124221,
    21422,
    1,
    common[105],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201011,
        eliteBuffList = {104704}
      }
    }
  },
  [52124222] = {
    52124222,
    21422,
    1,
    common[105],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201111,
        eliteBuffList = {104704}
      }
    }
  },
  [52124223] = {
    52124223,
    21422,
    1,
    common[105],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201211,
        eliteBuffList = {104704}
      }
    }
  },
  [52124231] = {
    52124231,
    21423,
    1,
    common[106],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201011,
        eliteBuffList = {104501}
      }
    }
  },
  [52124232] = {
    52124232,
    21423,
    1,
    common[106],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201111,
        eliteBuffList = {104501}
      }
    }
  },
  [52124233] = {
    52124233,
    21423,
    1,
    common[106],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201211,
        eliteBuffList = {104501}
      }
    }
  },
  [52124241] = {
    52124241,
    21424,
    1,
    common[107],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201011,
        eliteBuffList = {104502}
      }
    }
  },
  [52124242] = {
    52124242,
    21424,
    1,
    common[107],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201111,
        eliteBuffList = {104502}
      }
    }
  },
  [52124243] = {
    52124243,
    21424,
    1,
    common[107],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201211,
        eliteBuffList = {104502}
      }
    }
  },
  [52124251] = {
    52124251,
    21425,
    1,
    common[108],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201011,
        eliteBuffList = {104503}
      }
    }
  },
  [52124252] = {
    52124252,
    21425,
    1,
    common[108],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201111,
        eliteBuffList = {104503}
      }
    }
  },
  [52124253] = {
    52124253,
    21425,
    1,
    common[108],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201211,
        eliteBuffList = {104503}
      }
    }
  },
  [52121011] = {
    52121011,
    21101,
    1,
    "str_n20_crisis_contract_affix_des_52121011",
    {
      [1] = {},
      [2] = {
        affixType = 14,
        waveNum = 1,
        sourceID = 2800608,
        targetID = 2800610
      }
    }
  },
  [52121021] = {
    52121021,
    21102,
    1,
    "str_n20_crisis_contract_affix_des_52121021",
    {
      [1] = {},
      [2] = {
        affixType = 7,
        monsterID = 521200111,
        sourceSkillID = 29203121,
        targetSkillID = 29203122
      }
    }
  },
  [52121031] = {
    52121031,
    21103,
    1,
    common[109],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200111,
        buffList = {5212103}
      }
    }
  },
  [52121032] = {
    52121032,
    21103,
    1,
    common[109],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200211,
        buffList = {5212103}
      }
    }
  },
  [52121041] = {
    52121041,
    21104,
    1,
    common[110],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200111,
        buffList = {5212104}
      }
    }
  },
  [52121042] = {
    52121042,
    21104,
    1,
    common[110],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200211,
        buffList = {5212104}
      }
    }
  },
  [52121051] = {
    52121051,
    21105,
    1,
    common[111],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200111,
        buffList = {5212105}
      }
    }
  },
  [52121052] = {
    52121052,
    21105,
    1,
    common[111],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200211,
        buffList = {5212105}
      }
    }
  },
  [52121062] = {
    52121062,
    21106,
    1,
    common[112],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200211,
        buffList = {5212106}
      }
    }
  },
  [52121063] = {
    52121063,
    21106,
    1,
    common[112],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200311,
        buffList = {5212106}
      }
    }
  },
  [52121072] = {
    52121072,
    21107,
    1,
    common[113],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200211,
        buffList = {5212107}
      }
    }
  },
  [52121073] = {
    52121073,
    21107,
    1,
    common[113],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200311,
        buffList = {5212107}
      }
    }
  },
  [52121082] = {
    52121082,
    21108,
    1,
    common[114],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200211,
        buffList = {5212108}
      }
    }
  },
  [52121083] = {
    52121083,
    21108,
    1,
    common[114],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200311,
        buffList = {5212108}
      }
    }
  },
  [52121091] = {
    52121091,
    21109,
    1,
    common[115],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200111,
        buffList = {5212109}
      }
    }
  },
  [52121092] = {
    52121092,
    21109,
    1,
    common[115],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200211,
        buffList = {5212109}
      }
    }
  },
  [52121093] = {
    52121093,
    21109,
    1,
    common[115],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200311,
        buffList = {5212109}
      }
    }
  },
  [52121101] = {
    52121101,
    21110,
    1,
    common[116],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200111,
        buffList = {5212110}
      }
    }
  },
  [52121102] = {
    52121102,
    21110,
    1,
    common[116],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200211,
        buffList = {5212110}
      }
    }
  },
  [52121103] = {
    52121103,
    21110,
    1,
    common[116],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200311,
        buffList = {5212110}
      }
    }
  },
  [52121111] = {
    52121111,
    21111,
    1,
    common[117],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200111,
        buffList = {5212111}
      }
    }
  },
  [52121112] = {
    52121112,
    21111,
    1,
    common[117],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200211,
        buffList = {5212111}
      }
    }
  },
  [52121113] = {
    52121113,
    21111,
    1,
    common[117],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200311,
        buffList = {5212111}
      }
    }
  },
  [52121121] = {
    52121121,
    21112,
    1,
    common[118],
    {
      [1] = {},
      [2] = {
        affixType = 28,
        trapID = 2800608,
        Active = {
          282060103,
          282060105,
          282060110
        }
      },
      [3] = {
        affixType = 28,
        trapID = 2800610,
        Active = {
          282060103,
          282060105,
          282060110
        }
      }
    }
  },
  [52121122] = {
    52121122,
    21112,
    1,
    common[118],
    common[148]
  },
  [52121123] = {
    52121123,
    21112,
    1,
    common[118],
    common[148]
  },
  [52121132] = {
    52121132,
    21113,
    1,
    common[119],
    common[149]
  },
  [52121133] = {
    52121133,
    21113,
    1,
    common[119],
    common[149]
  },
  [52121143] = {
    52121143,
    21114,
    1,
    "str_n20_crisis_contract_affix_des_52121141",
    {
      [1] = {},
      [2] = {
        affixType = 7,
        monsterID = 521200311,
        sourceSkillID = 29203121,
        targetSkillID = 29203123
      }
    }
  },
  [52121151] = {
    52121151,
    21115,
    1,
    common[120],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200111,
        buffList = {5212115}
      }
    }
  },
  [52121152] = {
    52121152,
    21115,
    1,
    common[120],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200211,
        buffList = {5212115}
      }
    }
  },
  [52121153] = {
    52121153,
    21115,
    1,
    common[120],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200311,
        buffList = {5212115}
      }
    }
  },
  [52121161] = {
    52121161,
    21116,
    1,
    common[121],
    {
      [1] = {},
      [2] = {
        affixType = 16,
        waveNum = 1,
        id = 521200116,
        pos = {5, 8}
      }
    }
  },
  [52121162] = {
    52121162,
    21116,
    1,
    common[121],
    {
      [1] = {},
      [2] = {
        affixType = 16,
        waveNum = 1,
        id = 521200216,
        pos = {5, 8}
      }
    }
  },
  [52121171] = {
    52121171,
    21117,
    1,
    common[122],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200114,
        eliteBuffList = {1005}
      }
    }
  },
  [52121172] = {
    52121172,
    21117,
    1,
    common[122],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200214,
        eliteBuffList = {1005}
      }
    }
  },
  [52121173] = {
    52121173,
    21117,
    1,
    common[122],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200314,
        eliteBuffList = {1005}
      }
    }
  },
  [52121181] = {
    52121181,
    21118,
    1,
    common[123],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200112,
        buffList = {5212117, 52121171}
      },
      [3] = {
        affixType = 26,
        monsterID = 521200113,
        buffList = {5212117, 52121171}
      }
    }
  },
  [52121182] = {
    52121182,
    21118,
    1,
    common[123],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200212,
        buffList = {5212117, 52121171}
      },
      [3] = {
        affixType = 26,
        monsterID = 521200213,
        buffList = {5212117, 52121171}
      }
    }
  },
  [52121183] = {
    52121183,
    21118,
    1,
    common[123],
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521200312,
        buffList = {5212117, 52121171}
      },
      [3] = {
        affixType = 26,
        monsterID = 521200313,
        buffList = {5212117, 52121171}
      }
    }
  },
  [52121191] = {
    52121191,
    21119,
    1,
    common[124],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200115,
        eliteBuffList = {100101}
      }
    }
  },
  [52121192] = {
    52121192,
    21119,
    1,
    common[124],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200215,
        eliteBuffList = {100101}
      }
    }
  },
  [52121193] = {
    52121193,
    21119,
    1,
    common[124],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200315,
        eliteBuffList = {100101}
      }
    }
  },
  [52121201] = {
    52121201,
    21120,
    1,
    common[125],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200111,
        eliteBuffList = {104501}
      }
    }
  },
  [52121202] = {
    52121202,
    21120,
    1,
    common[125],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200211,
        eliteBuffList = {104501}
      }
    }
  },
  [52121203] = {
    52121203,
    21120,
    1,
    common[125],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200311,
        eliteBuffList = {104501}
      }
    }
  },
  [52121211] = {
    52121211,
    21121,
    1,
    common[126],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200111,
        eliteBuffList = {104502}
      }
    }
  },
  [52121212] = {
    52121212,
    21121,
    1,
    common[126],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200211,
        eliteBuffList = {104502}
      }
    }
  },
  [52121213] = {
    52121213,
    21121,
    1,
    common[126],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200311,
        eliteBuffList = {104502}
      }
    }
  },
  [52121221] = {
    52121221,
    21122,
    1,
    common[127],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200111,
        eliteBuffList = {104503}
      }
    }
  },
  [52121222] = {
    52121222,
    21122,
    1,
    common[127],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200211,
        eliteBuffList = {104503}
      }
    }
  },
  [52121223] = {
    52121223,
    21122,
    1,
    common[127],
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200311,
        eliteBuffList = {104503}
      }
    }
  },
  [52121233] = {
    52121233,
    21123,
    1,
    "str_n20_crisis_contract_affix_des_52121231",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200311,
        eliteBuffList = {104301}
      }
    }
  },
  [52121243] = {
    52121243,
    21124,
    1,
    "str_n20_crisis_contract_affix_des_52121241",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200311,
        eliteBuffList = {104302}
      }
    }
  },
  [52121253] = {
    52121253,
    21125,
    1,
    "str_n20_crisis_contract_affix_des_52121251",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521200311,
        eliteBuffList = {104303}
      }
    }
  },
  [52125011] = {
    52125011,
    21501,
    1,
    "str_n20_crisis_contract_affix_des_52125011",
    {
      [1] = {},
      [2] = {
        affixType = 24,
        monsterID = 521201313,
        buffList = {5212501}
      }
    }
  },
  [52125021] = {
    52125021,
    21502,
    1,
    "str_n20_crisis_contract_affix_des_52125021",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201311,
        buffList = {5212502, 5212503}
      }
    }
  },
  [52125031] = {
    52125031,
    21503,
    1,
    "str_n20_crisis_contract_affix_des_52125031",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201311,
        buffList = {5212505}
      }
    }
  },
  [52125032] = {
    52125032,
    21503,
    1,
    "str_n20_crisis_contract_affix_des_52125032",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201411,
        buffList = {5212505}
      }
    }
  },
  [52125041] = {
    52125041,
    21504,
    1,
    "str_n20_crisis_contract_affix_des_52125041",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201311,
        buffList = {5212506}
      }
    }
  },
  [52125042] = {
    52125042,
    21504,
    1,
    "str_n20_crisis_contract_affix_des_52125042",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201411,
        buffList = {5212506}
      }
    }
  },
  [52125051] = {
    52125051,
    21505,
    1,
    "str_n20_crisis_contract_affix_des_52125051",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201311,
        buffList = {5212507}
      }
    }
  },
  [52125052] = {
    52125052,
    21505,
    1,
    "str_n20_crisis_contract_affix_des_52125052",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201411,
        buffList = {5212507}
      }
    }
  },
  [52125053] = {
    52125053,
    21505,
    1,
    "str_n20_crisis_contract_affix_des_52125053",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201511,
        buffList = {5212507}
      }
    }
  },
  [52125061] = {
    52125061,
    21506,
    1,
    "str_n20_crisis_contract_affix_des_52125061",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201313,
        buffList = {5212508}
      }
    }
  },
  [52125062] = {
    52125062,
    21506,
    1,
    "str_n20_crisis_contract_affix_des_52125062",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201413,
        buffList = {5212508}
      }
    }
  },
  [52125063] = {
    52125063,
    21506,
    1,
    "str_n20_crisis_contract_affix_des_52125063",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201513,
        buffList = {5212508}
      }
    }
  },
  [52125072] = {
    52125072,
    21507,
    1,
    "str_n20_crisis_contract_affix_des_52125072",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201411,
        buffList = {5212509}
      }
    }
  },
  [52125073] = {
    52125073,
    21507,
    1,
    "str_n20_crisis_contract_affix_des_52125073",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201511,
        buffList = {5212509}
      }
    }
  },
  [52125082] = {
    52125082,
    21508,
    1,
    "str_n20_crisis_contract_affix_des_52125082",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201411,
        buffList = {5212510}
      }
    }
  },
  [52125083] = {
    52125083,
    21508,
    1,
    "str_n20_crisis_contract_affix_des_52125083",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201511,
        buffList = {5212510}
      }
    }
  },
  [52125092] = {
    52125092,
    21509,
    1,
    "str_n20_crisis_contract_affix_des_52125092",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201411,
        buffList = {5212511}
      }
    }
  },
  [52125093] = {
    52125093,
    21509,
    1,
    "str_n20_crisis_contract_affix_des_52125093",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201511,
        buffList = {5212511}
      }
    }
  },
  [52125101] = {
    52125101,
    21510,
    1,
    "str_n20_crisis_contract_affix_des_52125101",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201313,
        buffList = {5212512}
      }
    }
  },
  [52125102] = {
    52125102,
    21510,
    1,
    "str_n20_crisis_contract_affix_des_52125102",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201413,
        buffList = {5212512}
      }
    }
  },
  [52125103] = {
    52125103,
    21510,
    1,
    "str_n20_crisis_contract_affix_des_52125103",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201513,
        buffList = {5212512}
      }
    }
  },
  [52125111] = {
    52125111,
    21511,
    1,
    "str_n20_crisis_contract_affix_des_52125111",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201312,
        buffList = {5212514}
      }
    }
  },
  [52125112] = {
    52125112,
    21511,
    1,
    "str_n20_crisis_contract_affix_des_52125112",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201412,
        buffList = {5212514}
      }
    }
  },
  [52125113] = {
    52125113,
    21511,
    1,
    "str_n20_crisis_contract_affix_des_52125113",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201512,
        buffList = {5212514}
      }
    }
  },
  [52125121] = {
    52125121,
    21512,
    1,
    "str_n20_crisis_contract_affix_des_52125121",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201312,
        buffList = {5212513}
      }
    }
  },
  [52125122] = {
    52125122,
    21512,
    1,
    "str_n20_crisis_contract_affix_des_52125122",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201412,
        buffList = {5212513}
      }
    }
  },
  [52125123] = {
    52125123,
    21512,
    1,
    "str_n20_crisis_contract_affix_des_52125123",
    {
      [1] = {},
      [2] = {
        affixType = 26,
        monsterID = 521201512,
        buffList = {5212513}
      }
    }
  },
  [52125133] = {
    52125133,
    21513,
    1,
    "str_n20_crisis_contract_affix_des_52125133",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201512,
        eliteBuffList = {1028}
      }
    }
  },
  [52125142] = {
    52125142,
    21514,
    1,
    "str_n20_crisis_contract_affix_des_52125142",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201411,
        eliteBuffList = {1012}
      }
    }
  },
  [52125143] = {
    52125143,
    21514,
    1,
    "str_n20_crisis_contract_affix_des_52125143",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201511,
        eliteBuffList = {1012}
      }
    }
  },
  [52125151] = {
    52125151,
    21515,
    1,
    "str_n20_crisis_contract_affix_des_52125151",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201312,
        eliteBuffList = {103003}
      }
    }
  },
  [52125152] = {
    52125152,
    21515,
    1,
    "str_n20_crisis_contract_affix_des_52125152",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201412,
        eliteBuffList = {103003}
      }
    }
  },
  [52125153] = {
    52125153,
    21515,
    1,
    "str_n20_crisis_contract_affix_des_52125153",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201512,
        eliteBuffList = {103003}
      }
    }
  },
  [52125161] = {
    52125161,
    21516,
    1,
    "str_n20_crisis_contract_affix_des_52125161",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201312,
        eliteBuffList = {103004}
      }
    }
  },
  [52125162] = {
    52125162,
    21516,
    1,
    "str_n20_crisis_contract_affix_des_52125162",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201412,
        eliteBuffList = {103004}
      }
    }
  },
  [52125163] = {
    52125163,
    21516,
    1,
    "str_n20_crisis_contract_affix_des_52125163",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201512,
        eliteBuffList = {103004}
      }
    }
  },
  [52125171] = {
    52125171,
    21517,
    1,
    "str_n20_crisis_contract_affix_des_52125171",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201312,
        eliteBuffList = {103005}
      }
    }
  },
  [52125172] = {
    52125172,
    21517,
    1,
    "str_n20_crisis_contract_affix_des_52125172",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201412,
        eliteBuffList = {103005}
      }
    }
  },
  [52125173] = {
    52125173,
    21517,
    1,
    "str_n20_crisis_contract_affix_des_52125173",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201512,
        eliteBuffList = {103005}
      }
    }
  },
  [52125181] = {
    52125181,
    21518,
    1,
    "str_n20_crisis_contract_affix_des_52125181",
    {
      [1] = {},
      [2] = {
        affixType = 7,
        monsterID = 521201311,
        sourceSkillID = 29030011,
        targetSkillID = 290300111
      }
    }
  },
  [52125182] = {
    52125182,
    21518,
    1,
    "str_n20_crisis_contract_affix_des_52125182",
    {
      [1] = {},
      [2] = {
        affixType = 7,
        monsterID = 521201411,
        sourceSkillID = 29030011,
        targetSkillID = 290300111
      }
    }
  },
  [52125183] = {
    52125183,
    21518,
    1,
    "str_n20_crisis_contract_affix_des_52125183",
    {
      [1] = {},
      [2] = {
        affixType = 7,
        monsterID = 521201511,
        sourceSkillID = 29030011,
        targetSkillID = 290300111
      }
    }
  },
  [52125191] = {
    52125191,
    21519,
    1,
    "str_n20_crisis_contract_affix_des_52125191",
    {
      [1] = {},
      [2] = {
        affixType = 7,
        monsterID = 521201311,
        sourceSkillID = 29030011,
        targetSkillID = 290300112
      }
    }
  },
  [52125192] = {
    52125192,
    21519,
    1,
    "str_n20_crisis_contract_affix_des_52125192",
    {
      [1] = {},
      [2] = {
        affixType = 7,
        monsterID = 521201411,
        sourceSkillID = 29030011,
        targetSkillID = 290300112
      }
    }
  },
  [52125193] = {
    52125193,
    21519,
    1,
    "str_n20_crisis_contract_affix_des_52125193",
    {
      [1] = {},
      [2] = {
        affixType = 7,
        monsterID = 521201511,
        sourceSkillID = 29030011,
        targetSkillID = 290300112
      }
    }
  },
  [52125201] = {
    52125201,
    21520,
    1,
    "str_n20_crisis_contract_affix_des_52125201",
    {
      [1] = {},
      [2] = {
        affixType = 7,
        monsterID = 521201311,
        sourceSkillID = 29030011,
        targetSkillID = 290300113
      }
    }
  },
  [52125202] = {
    52125202,
    21520,
    1,
    "str_n20_crisis_contract_affix_des_52125202",
    {
      [1] = {},
      [2] = {
        affixType = 7,
        monsterID = 521201411,
        sourceSkillID = 29030011,
        targetSkillID = 290300113
      }
    }
  },
  [52125203] = {
    52125203,
    21520,
    1,
    "str_n20_crisis_contract_affix_des_52125203",
    {
      [1] = {},
      [2] = {
        affixType = 7,
        monsterID = 521201511,
        sourceSkillID = 29030011,
        targetSkillID = 290300113
      }
    }
  },
  [52125211] = {
    52125211,
    21521,
    1,
    "str_n20_crisis_contract_affix_des_52125211",
    {
      [1] = {},
      [2] = {
        affixType = 16,
        waveNum = 1,
        id = 521201313,
        pos = {4, 6}
      }
    }
  },
  [52125212] = {
    52125212,
    21521,
    1,
    "str_n20_crisis_contract_affix_des_52125212",
    common[150]
  },
  [52125213] = {
    52125213,
    21521,
    1,
    "str_n20_crisis_contract_affix_des_52125213",
    common[150]
  },
  [52125223] = {
    52125223,
    21522,
    1,
    "str_n20_crisis_contract_affix_des_52125223",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201511,
        eliteBuffList = {106301}
      }
    }
  },
  [52125233] = {
    52125233,
    21523,
    1,
    "str_n20_crisis_contract_affix_des_52125233",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201511,
        eliteBuffList = {106302}
      }
    }
  },
  [52125243] = {
    52125243,
    21524,
    1,
    "str_n20_crisis_contract_affix_des_52125243",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201511,
        eliteBuffList = {106303}
      }
    }
  },
  [52125251] = {
    52125251,
    21525,
    1,
    "str_n20_crisis_contract_affix_des_52125251",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201311,
        eliteBuffList = {1005}
      }
    }
  },
  [52125252] = {
    52125252,
    21525,
    1,
    "str_n20_crisis_contract_affix_des_52125252",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201411,
        eliteBuffList = {1005}
      }
    }
  },
  [52125253] = {
    52125253,
    21525,
    1,
    "str_n20_crisis_contract_affix_des_52125253",
    {
      [1] = {},
      [2] = {
        affixType = 27,
        monsterID = 521201511,
        eliteBuffList = {1005}
      }
    }
  },
  [1004031] = {
    1004031,
    1004031,
    1,
    common[2],
    common[151]
  },
  [1004032] = {
    1004032,
    1004032,
    1,
    common[2],
    common[151]
  },
  [1004033] = {
    1004033,
    1004033,
    1,
    common[2],
    common[152]
  },
  [88840197] = {
    88840197,
    88840197,
    1,
    common[2],
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 7,
        monsterID = 111408211,
        sourceSkillID = 290340101,
        targetSkillID = 290340202
      }
    }
  },
  [1004034] = {
    1004034,
    1004034,
    1,
    common[2],
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 1,
        type = 1,
        percent = 0.4
      }
    }
  },
  [2905201] = {
    2905201,
    2905201,
    1,
    common[2],
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 32,
        refreshType = 3,
        gapTrapID = 2905201
      }
    }
  },
  [4005001] = {
    4005001,
    4005001,
    1,
    common[2],
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 7,
        monsterID = 45001106,
        sourceSkillID = 501015,
        targetSkillID = 5010152
      }
    }
  },
  [4006001] = {
    4006001,
    4006001,
    1,
    common[2],
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 7,
        monsterID = 46001107,
        sourceSkillID = 501015,
        targetSkillID = 5010152
      }
    }
  },
  [4007001] = {
    4007001,
    4007001,
    1,
    common[2],
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 7,
        monsterID = 47001104,
        sourceSkillID = 501015,
        targetSkillID = 5010152
      }
    }
  },
  [4008001] = {
    4008001,
    4008001,
    1,
    common[2],
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 7,
        monsterID = 48001104,
        sourceSkillID = 501015,
        targetSkillID = 5010152
      }
    }
  },
  [4005003] = {
    4005003,
    4005003,
    1,
    common[2],
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 7,
        monsterID = 45003101,
        sourceSkillID = 500178,
        targetSkillID = 888450031
      },
      [3] = {
        affixType = 7,
        monsterID = 45003204,
        sourceSkillID = 500178,
        targetSkillID = 888450031
      }
    }
  },
  [4006003] = {
    4006003,
    4005003,
    1,
    common[2],
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 7,
        monsterID = 46003101,
        sourceSkillID = 500178,
        targetSkillID = 888450031
      },
      [3] = {
        affixType = 7,
        monsterID = 46003204,
        sourceSkillID = 500178,
        targetSkillID = 888450031
      }
    }
  },
  [4007003] = {
    4007003,
    4005003,
    1,
    common[2],
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 7,
        monsterID = 47003101,
        sourceSkillID = 500178,
        targetSkillID = 888450031
      },
      [3] = {
        affixType = 7,
        monsterID = 47003203,
        sourceSkillID = 500178,
        targetSkillID = 888450031
      }
    }
  },
  [4008003] = {
    4008003,
    4005003,
    1,
    common[2],
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 7,
        monsterID = 48003101,
        sourceSkillID = 500178,
        targetSkillID = 888450031
      },
      [3] = {
        affixType = 7,
        monsterID = 48003203,
        sourceSkillID = 500178,
        targetSkillID = 888450031
      }
    }
  },
  [4005006] = {
    4005006,
    4005006,
    1,
    common[2],
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 7,
        monsterID = 45006101,
        sourceSkillID = 1000202,
        targetSkillID = 888450061
      },
      [3] = {
        affixType = 7,
        monsterID = 45006102,
        sourceSkillID = 1000202,
        targetSkillID = 888450061
      }
    }
  },
  [4006006] = {
    4006006,
    4006006,
    1,
    common[2],
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 7,
        monsterID = 46006101,
        sourceSkillID = 1000203,
        targetSkillID = 888460061
      },
      [3] = {
        affixType = 7,
        monsterID = 46006102,
        sourceSkillID = 1000203,
        targetSkillID = 888460061
      }
    }
  },
  [4007006] = {
    4007006,
    4007006,
    1,
    common[2],
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 7,
        monsterID = 47006101,
        sourceSkillID = 1000204,
        targetSkillID = 888470061
      },
      [3] = {
        affixType = 7,
        monsterID = 47006102,
        sourceSkillID = 1000204,
        targetSkillID = 888470061
      }
    }
  },
  [4008006] = {
    4008006,
    4008006,
    1,
    common[2],
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 7,
        monsterID = 48006101,
        sourceSkillID = 1000201,
        targetSkillID = 888480061
      },
      [3] = {
        affixType = 7,
        monsterID = 48006102,
        sourceSkillID = 1000201,
        targetSkillID = 888480061
      }
    }
  },
  [4005007] = {
    4005007,
    4005007,
    1,
    common[2],
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 7,
        monsterID = 45007102,
        sourceSkillID = 29036011,
        targetSkillID = 400500711
      },
      [3] = {
        affixType = 7,
        monsterID = 47007102,
        sourceSkillID = 29036011,
        targetSkillID = 400500711
      },
      [4] = {
        affixType = 7,
        monsterID = 45007102,
        sourceSkillID = 29036312,
        targetSkillID = 29036412
      },
      [5] = {
        affixType = 7,
        monsterID = 47007102,
        sourceSkillID = 29036312,
        targetSkillID = 29036412
      }
    }
  },
  [4005008] = {
    4005008,
    4005008,
    1,
    common[2],
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 7,
        monsterID = 45008101,
        sourceSkillID = 500228,
        targetSkillID = 888460081
      },
      [3] = {
        affixType = 7,
        monsterID = 45008104,
        sourceSkillID = 500228,
        targetSkillID = 888460081
      },
      [4] = {
        affixType = 7,
        monsterID = 45008204,
        sourceSkillID = 500228,
        targetSkillID = 888460081
      },
      [5] = {
        affixType = 7,
        monsterID = 45008206,
        sourceSkillID = 500228,
        targetSkillID = 888460081
      }
    }
  },
  [4006008] = {
    4006008,
    4006008,
    1,
    common[2],
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 7,
        monsterID = 46008101,
        sourceSkillID = 500230,
        targetSkillID = 888470081
      },
      [3] = {
        affixType = 7,
        monsterID = 46008104,
        sourceSkillID = 500230,
        targetSkillID = 888470081
      },
      [4] = {
        affixType = 7,
        monsterID = 46008204,
        sourceSkillID = 500230,
        targetSkillID = 888470081
      },
      [5] = {
        affixType = 7,
        monsterID = 46008206,
        sourceSkillID = 500230,
        targetSkillID = 888470081
      }
    }
  },
  [4007008] = {
    4007008,
    4007008,
    1,
    common[2],
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 7,
        monsterID = 47008101,
        sourceSkillID = 500232,
        targetSkillID = 888480081
      },
      [3] = {
        affixType = 7,
        monsterID = 47008103,
        sourceSkillID = 500232,
        targetSkillID = 888480081
      },
      [4] = {
        affixType = 7,
        monsterID = 47008203,
        sourceSkillID = 500232,
        targetSkillID = 888480081
      },
      [5] = {
        affixType = 7,
        monsterID = 47008205,
        sourceSkillID = 500232,
        targetSkillID = 888480081
      }
    }
  },
  [4008008] = {
    4008008,
    4008008,
    1,
    common[2],
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 7,
        monsterID = 48008101,
        sourceSkillID = 500201,
        targetSkillID = 888450081
      },
      [3] = {
        affixType = 7,
        monsterID = 48008103,
        sourceSkillID = 500201,
        targetSkillID = 888450081
      },
      [4] = {
        affixType = 7,
        monsterID = 48008203,
        sourceSkillID = 500201,
        targetSkillID = 888450081
      },
      [5] = {
        affixType = 7,
        monsterID = 48008205,
        sourceSkillID = 500201,
        targetSkillID = 888450081
      }
    }
  },
  [1004035] = {
    1004035,
    1004035,
    1,
    common[2],
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 1,
        type = 1,
        percent = 0.6
      }
    }
  },
  [5354002] = {
    5354002,
    5354002,
    1,
    common[2],
    common[132]
  },
  [5354001] = {
    5354001,
    5354001,
    1,
    common[2],
    common[152]
  },
  [541001] = {
    541001,
    541001,
    1,
    "str_crisis_contract_affix_des541001",
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 11,
        affixBuffIDList = {541001}
      }
    }
  },
  [541101] = {
    541101,
    541101,
    1,
    "str_crisis_contract_affix_des541101",
    {
      [1] = {},
      [2] = {
        affixType = 11,
        affixBuffIDList = {541101}
      }
    }
  },
  [541102] = {
    541102,
    541102,
    1,
    "str_crisis_contract_affix_des541102",
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 11,
        affixBuffIDList = {541102}
      }
    }
  },
  [541103] = {
    541103,
    541103,
    1,
    "str_crisis_contract_affix_des541103",
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 11,
        affixBuffIDList = {541103}
      }
    }
  },
  [541202] = {
    541202,
    541202,
    1,
    "str_crisis_contract_affix_des541202",
    {
      [1] = {},
      [2] = {
        affixType = 11,
        affixBuffIDList = {541202}
      }
    }
  },
  [541203] = {
    541203,
    541203,
    1,
    "str_crisis_contract_affix_des541203",
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 11,
        affixBuffIDList = {541203}
      }
    }
  },
  [541301] = {
    541301,
    541301,
    1,
    "str_crisis_contract_affix_des541301",
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 11,
        affixBuffIDList = {541301}
      }
    }
  },
  [541302] = {
    541302,
    541302,
    1,
    common[128],
    common[153]
  },
  [541303] = {
    541303,
    541303,
    1,
    "str_crisis_contract_affix_des541303",
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 11,
        affixBuffIDList = {541303}
      }
    }
  },
  [542001] = {
    542001,
    542001,
    1,
    "str_crisis_contract_affix_des542001",
    {
      [1] = {},
      [2] = {
        affixType = 11,
        affixBuffIDList = {542001}
      }
    }
  },
  [542101] = {
    542101,
    542101,
    1,
    "str_crisis_contract_affix_des542101",
    {
      [1] = {},
      [2] = {
        affixType = 11,
        affixBuffIDList = {542101}
      }
    }
  },
  [542102] = {
    542102,
    542102,
    1,
    "str_crisis_contract_affix_des542102",
    {
      [1] = {},
      [2] = {
        affixType = 11,
        affixBuffIDList = {542102}
      }
    }
  },
  [542202] = {
    542202,
    542202,
    1,
    "str_crisis_contract_affix_des542202",
    {
      [1] = {},
      [2] = {
        affixType = 11,
        affixBuffIDList = {542202}
      }
    }
  },
  [542203] = {
    542203,
    542203,
    1,
    "str_crisis_contract_affix_des542203",
    {
      [1] = {},
      [2] = {
        affixType = 11,
        affixBuffIDList = {542203}
      }
    }
  },
  [542301] = {
    542301,
    542301,
    1,
    "str_crisis_contract_affix_des542301",
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 11,
        affixBuffIDList = {542301}
      }
    }
  },
  [543001] = {
    543001,
    543001,
    1,
    "str_crisis_contract_affix_des543001",
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 35,
        GeneratePieceWeight = {
          10,
          10,
          10,
          0,
          0
        },
        SupplyPieceWeight = {
          10,
          10,
          10,
          0,
          0
        },
        GeneratePieceAmount = {
          5,
          5,
          5,
          0
        }
      }
    }
  },
  [543101] = {
    543101,
    543101,
    1,
    "str_crisis_contract_affix_des543101",
    {
      [1] = {},
      [2] = {
        affixType = 11,
        affixBuffIDList = {543101}
      }
    }
  },
  [543201] = {
    543201,
    543201,
    1,
    "str_crisis_contract_affix_des543201",
    {
      [1] = {},
      [2] = {
        affixType = 11,
        affixBuffIDList = {543201}
      }
    }
  },
  [543202] = {
    543202,
    543202,
    1,
    "str_crisis_contract_affix_des543202",
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 11,
        affixBuffIDList = {543202}
      }
    }
  },
  [543203] = {
    543203,
    543203,
    1,
    "str_crisis_contract_affix_des543203",
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 11,
        affixBuffIDList = {543203}
      }
    }
  },
  [543301] = {
    543301,
    543301,
    1,
    "str_crisis_contract_affix_des543301",
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 11,
        affixBuffIDList = {543301}
      }
    }
  },
  [543302] = {
    543302,
    543302,
    1,
    common[128],
    common[153]
  },
  [543303] = {
    543303,
    543303,
    1,
    "str_crisis_contract_affix_des543303",
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 11,
        affixBuffIDList = {543303}
      }
    }
  },
  [544101] = {
    544101,
    544101,
    1,
    "str_crisis_contract_affix_des544101",
    {
      [1] = {},
      [2] = {
        affixType = 11,
        affixBuffIDList = {544101}
      }
    }
  },
  [544103] = {
    544103,
    544103,
    1,
    "str_crisis_contract_affix_des544103",
    {
      [1] = {},
      [2] = {
        affixType = 11,
        affixBuffIDList = {544103}
      }
    }
  },
  [544202] = {
    544202,
    544202,
    1,
    "str_crisis_contract_affix_des544202",
    {
      [1] = {},
      [2] = {
        affixType = 11,
        affixBuffIDList = {544202}
      }
    }
  },
  [544203] = {
    544203,
    544203,
    1,
    "str_crisis_contract_affix_des544203",
    {
      [1] = {},
      [2] = {
        affixType = 11,
        affixBuffIDList = {544203}
      }
    }
  },
  [544301] = {
    544301,
    544301,
    1,
    "str_crisis_contract_affix_des544301",
    {
      [1] = {
        [1] = 1
      },
      [2] = {
        affixType = 11,
        affixBuffIDList = {544301}
      }
    }
  },
  [544302] = {
    544302,
    544302,
    1,
    "str_crisis_contract_affix_des544302",
    {
      [1] = {},
      [2] = {
        affixType = 11,
        affixBuffIDList = {544302}
      }
    }
  },
  [544303] = {
    544303,
    544303,
    1,
    "str_crisis_contract_affix_des544303",
    {
      [1] = {},
      [2] = {
        affixType = 11,
        affixBuffIDList = {544303}
      }
    }
  },
  [542103] = {
    542103,
    542103,
    1,
    "str_crisis_contract_affix_des_542103",
    common[154]
  },
  [543102] = {
    543102,
    542103,
    1,
    "str_crisis_contract_affix_des_543102",
    common[154]
  },
  [542201] = {
    542201,
    542201,
    1,
    "str_crisis_contract_affix_des_542201",
    {
      [1] = {},
      [2] = {
        affixType = 35,
        GeneratePieceWeight = {
          5,
          12,
          12,
          12,
          0
        },
        SupplyPieceWeight = {
          5,
          12,
          12,
          12,
          0
        },
        GeneratePieceAmount = {
          0,
          0,
          0,
          0
        }
      }
    }
  },
  [544201] = {
    544201,
    544201,
    1,
    "str_crisis_contract_affix_des_544201",
    {
      [1] = {},
      [2] = {
        affixType = 35,
        GeneratePieceWeight = {
          12,
          12,
          5,
          12,
          0
        },
        SupplyPieceWeight = {
          12,
          12,
          5,
          12,
          0
        },
        GeneratePieceAmount = {
          0,
          0,
          0,
          0
        }
      }
    }
  },
  [541201] = {
    541201,
    541201,
    1,
    "str_crisis_contract_affix_des_541201",
    {
      [1] = {},
      [2] = {
        affixType = 35,
        GeneratePieceWeight = {
          12,
          12,
          12,
          5,
          0
        },
        SupplyPieceWeight = {
          12,
          12,
          12,
          5,
          0
        },
        GeneratePieceAmount = {
          0,
          0,
          0,
          0
        }
      }
    }
  },
  [542302] = {
    542302,
    542302,
    1,
    "str_crisis_contract_affix_des_542302",
    {
      [1] = {},
      [2] = {
        affixType = 11,
        affixBuffIDList = {542302}
      }
    }
  },
  [544102] = {
    544102,
    542302,
    1,
    "str_crisis_contract_affix_des_544102",
    {
      [1] = {},
      [2] = {
        affixType = 11,
        affixBuffIDList = {544102}
      }
    }
  },
  [543103] = {
    543103,
    543103,
    1,
    "str_crisis_contract_affix_des_543103",
    {
      [1] = {},
      [2] = {affixType = 38, AddChainPathNum = 2}
    }
  },
  [544001] = {
    544001,
    544001,
    1,
    "str_crisis_contract_affix_des_544001",
    {
      [1] = {},
      [2] = {
        affixType = 11,
        affixBuffIDList = {544001}
      },
      [3] = {
        affixType = 11,
        affixBuffIDList = {5440011}
      }
    }
  },
  [542303] = {
    542303,
    542303,
    1,
    "str_crisis_contract_affix_des_542303",
    {
      [1] = {},
      [2] = {
        affixType = 11,
        affixBuffIDList = {5423031}
      },
      [3] = {
        affixType = 11,
        affixBuffIDList = {5423032}
      }
    }
  },
  [7001143] = {
    7001143,
    7001143,
    1,
    "str_crisis_contract_affix_des_7001143",
    common[154]
  }
}
return config, "ID", key
