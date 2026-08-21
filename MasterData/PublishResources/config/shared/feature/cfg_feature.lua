local key = {
  ID = 1,
  FeatureType = 2,
  LayoutOrder = 3,
  Icon = 4,
  Desc = 5,
  EffectParam = 6
}
local common = {"eff7.png", "str_des5"}
local config = {
  {
    1,
    2,
    1,
    "eff3.png",
    "str_des1",
    {
      EnterSanValue = 100,
      MaxSanValue = 100,
      RoundDelValue = 0,
      SanSysCfgId = 1
    }
  },
  {
    2,
    1,
    2,
    "eff4.png",
    "str_des2",
    {
      EnterState = 1,
      DayRound = 2,
      NightRound = 3
    }
  },
  {
    3,
    3,
    4,
    "eff5.png",
    "str_des3",
    {SkillID = 4001580}
  },
  {
    4,
    4,
    3,
    "eff6.png",
    "str_des4",
    {
      SkillDic = {
        [1] = 3001670,
        [2] = 3001671,
        [3] = 3001672,
        [4] = 3001673,
        [5] = 30016740,
        [6] = 30016750,
        [7] = 30016760,
        [8] = 30016770,
        [9] = 30016780,
        [10] = 30016790
      },
      CardMax = 99,
      InitCardNum = 0
    }
  },
  {
    5,
    5,
    5,
    common[1],
    common[2],
    {SkillID = 5220011}
  },
  {
    6,
    6,
    6,
    common[1],
    common[2],
    {
      SummonTrapSkillID = 30017511,
      ForceMovementSkillID = 30017512,
      SummonScanTrapSkillID = 30017513,
      EmptySkillID = 30017510,
      DiedTrapIncluded = 1
    }
  },
  {
    7,
    7,
    7,
    common[1],
    common[2],
    {SkillID = 5220012}
  },
  {
    8,
    8,
    8,
    common[1],
    common[2],
    {SkillID = 5220013}
  },
  {
    9,
    9,
    9,
    common[1],
    common[2],
    {
      TargetTrapIDList = {15014911, 15014912},
      MaxCount = 9,
      Icon = "thread_junei_kuang15",
      TitleStr = "str_item_3000011"
    }
  },
  {
    10,
    10,
    10,
    common[1],
    common[2],
    {SkillID = 52200111}
  },
  {
    11,
    11,
    11,
    common[1],
    common[2],
    {SkillID = 280240101}
  },
  {
    12,
    10001,
    12,
    common[1],
    common[2],
    {
      SkillID = 5054101,
      MaxPower = 3,
      ImageNormalFront = "thread_junei_bing2",
      ImageWarningFront = "thread_junei_bing1",
      ImageWarningBg = "thread_junei_bing4"
    }
  },
  {
    13,
    10002,
    13,
    common[1],
    common[2],
    {
      SkillID = 5054201,
      MaxPower = 3,
      ImageNormalFront = "thread_junei_huo2",
      ImageWarningFront = "thread_junei_huo1",
      ImageWarningBg = "thread_junei_huo4"
    }
  },
  {
    14,
    10003,
    14,
    common[1],
    common[2],
    {
      SkillID = 5054301,
      MaxPower = 3,
      ImageNormalFront = "thread_junei_sen2",
      ImageWarningFront = "thread_junei_sen1",
      ImageWarningBg = "thread_junei_sen4"
    }
  },
  {
    15,
    10004,
    15,
    common[1],
    common[2],
    {
      SkillID = 5054401,
      MaxPower = 3,
      ImageNormalFront = "thread_junei_lei2",
      ImageWarningFront = "thread_junei_lei1",
      ImageWarningBg = "thread_junei_lei4"
    }
  },
  {
    16,
    10005,
    16,
    common[1],
    common[2],
    {
      SkillID = 5054001,
      MaxPower = 2,
      ImageNormalFront = "thread_junei_kuang31",
      ImageWarningFront = "thread_junei_kuang33",
      ImageWarningBg = "thread_junei_lei4"
    }
  },
  {
    17,
    10006,
    17,
    common[1],
    common[2],
    {
      SkillID = 5054501,
      MaxPower = 3,
      ImageNormalFront = "thread_junei_kuang02",
      ImageWarningFront = "thread_junei_kuang05",
      ImageWarningBg = "thread_junei_lei4"
    }
  },
  {
    18,
    10007,
    18,
    common[1],
    common[2],
    {
      SkillID = 5054601,
      MaxPower = 2,
      ImageNormalFront = "thread_junei_reset2",
      ImageWarningFront = "thread_junei_reset1",
      ImageWarningBg = "thread_junei_lei4"
    }
  },
  {
    19,
    10008,
    19,
    common[1],
    common[2],
    {
      SkillID = 5054701,
      MaxPower = 3,
      ImageNormalFront = "thread_junei_clear2",
      ImageWarningFront = "thread_junei_clear1",
      ImageWarningBg = "thread_junei_lei4"
    }
  },
  {
    20,
    12,
    20,
    nil,
    nil,
    {
      SkillID = 350218,
      EnterCoinCount = 0,
      GroupDataList = {
        [1] = {
          [1] = {CellID = 1, NeedEquipLevel = 0},
          [2] = {CellID = 2, NeedEquipLevel = 3}
        },
        [2] = {
          [1] = {CellID = 3, NeedEquipLevel = 0},
          [2] = {CellID = 4, NeedEquipLevel = 6}
        },
        [3] = {
          [1] = {CellID = 5, NeedEquipLevel = 0},
          [2] = {CellID = 6, NeedEquipLevel = 10}
        }
      },
      UnlockParam1 = {
        2,
        5,
        8
      }
    }
  },
  {
    21,
    14,
    21,
    nil,
    nil,
    {
      BanNormalSkillID = 28029032,
      BanChainSkillID = 28029022,
      BanActiveSkillID = 28029021,
      SkillCD = 1
    }
  },
  {
    22,
    20001,
    22,
    common[1],
    common[2],
    {
      SkillID = 802401,
      ImageNormalFront = "thread_junei_s4tree01_s",
      ImageWarningFront = "thread_junei_s4tree01",
      ImageNormalBg = "thread_junei_s4di02",
      ImageWarningBg = "thread_junei_s4di01",
      HideUIIcon = 1
    }
  },
  {
    23,
    20002,
    23,
    common[1],
    common[2],
    {
      SkillID = 802402,
      ImageNormalFront = "thread_junei_s4tree02_s",
      ImageWarningFront = "thread_junei_s4tree02",
      ImageNormalBg = "thread_junei_s4di02",
      ImageWarningBg = "thread_junei_s4di01",
      HideUIIcon = 1
    }
  },
  {
    24,
    20003,
    24,
    common[1],
    common[2],
    {
      SkillID = 802402,
      ImageNormalFront = "thread_junei_s4tree03_s",
      ImageWarningFront = "thread_junei_s4tree03",
      ImageNormalBg = "thread_junei_s4di02",
      ImageWarningBg = "thread_junei_s4di01",
      HideUIIcon = 1
    }
  },
  {
    25,
    20004,
    25,
    common[1],
    common[2],
    {
      SkillID = 802404,
      ImageNormalFront = "thread_junei_s4tree04_s",
      ImageWarningFront = "thread_junei_s4tree04",
      ImageNormalBg = "thread_junei_s4di02",
      ImageWarningBg = "thread_junei_s4di01",
      HideUIIcon = 1
    }
  },
  {
    26,
    20005,
    26,
    common[1],
    common[2],
    {
      SkillID = 802405,
      ImageNormalFront = "thread_junei_s4tree05_s",
      ImageWarningFront = "thread_junei_s4tree05",
      ImageNormalBg = "thread_junei_s4di02",
      ImageWarningBg = "thread_junei_s4di01",
      HideUIIcon = 1
    }
  },
  {
    27,
    13,
    20,
    nil,
    nil,
    {
      InitStepPoint = 10,
      MaxStepPoint = 30,
      RecoverStepPoint = 5
    }
  },
  {
    28,
    10009,
    27,
    common[1],
    common[2],
    {
      SkillID = 5060801,
      MaxPower = 1,
      ImageNormalFront = "thread_junei_pobizhe02",
      ImageWarningFront = "thread_junei_pobizhe",
      ImageWarningBg = "thread_junei_lei4"
    }
  },
  {
    29,
    10010,
    28,
    common[1],
    common[2],
    {
      SkillID = 5066101,
      MaxPower = 2,
      ImageNormalFront = "thread_junei_wanse02",
      ImageWarningFront = "thread_junei_wanse",
      ImageWarningBg = "thread_junei_lei4",
      FirstUseInitPower = 2
    }
  },
  {
    30,
    10001,
    29,
    common[1],
    common[2],
    {
      SkillID = 5064701,
      MaxPower = 3,
      ImageNormalFront = "thread_junei_bing2",
      ImageWarningFront = "thread_junei_bing1",
      ImageWarningBg = "thread_junei_bing4"
    }
  },
  {
    31,
    10002,
    30,
    common[1],
    common[2],
    {
      SkillID = 5064702,
      MaxPower = 3,
      ImageNormalFront = "thread_junei_huo2",
      ImageWarningFront = "thread_junei_huo1",
      ImageWarningBg = "thread_junei_huo4"
    }
  },
  {
    32,
    10003,
    31,
    common[1],
    common[2],
    {
      SkillID = 5064703,
      MaxPower = 3,
      ImageNormalFront = "thread_junei_sen2",
      ImageWarningFront = "thread_junei_sen1",
      ImageWarningBg = "thread_junei_sen4"
    }
  },
  {
    33,
    10004,
    32,
    common[1],
    common[2],
    {
      SkillID = 5064704,
      MaxPower = 3,
      ImageNormalFront = "thread_junei_lei2",
      ImageWarningFront = "thread_junei_lei1",
      ImageWarningBg = "thread_junei_lei4"
    }
  },
  [40] = {
    40,
    15,
    40,
    common[1],
    common[2],
    {
      EnterValue = 0,
      MinValue = 0,
      MaxValue = 100,
      RelicIDList = {
        9011048,
        9011049,
        9011050,
        9011051,
        9011052,
        9011053
      },
      RelicDescList = {
        "str_season_maze_relic_9011048_desc",
        "str_season_maze_relic_9011049_desc",
        "str_season_maze_relic_9011050_desc",
        "str_season_maze_relic_9011051_desc",
        "str_season_maze_relic_9011052_desc",
        "str_season_maze_relic_9011053_desc"
      }
    }
  },
  [41] = {
    41,
    16,
    41,
    common[1],
    common[2]
  },
  [42] = {
    42,
    18,
    43,
    common[1],
    common[2],
    {
      reRollEnable = true,
      powerEnable = true,
      defaultCostPower = 5,
      clickCostPower = 5,
      lockEnable = true,
      mainColorEnable = true,
      defaultTetris = 1,
      tetrisIconList = {
        "n46_blj_di01",
        "n46_blj_di02",
        "n46_blj_di03",
        "n46_blj_di04",
        "n46_blj_di05",
        "n46_blj_di06",
        "n46_blj_di07"
      },
      tetrisSmallIconList = {
        "n46_blj_di10",
        "n46_blj_di11",
        "n46_blj_di12",
        "n46_blj_di13",
        "n46_blj_di14",
        "n46_blj_di15",
        "n46_blj_di16"
      }
    }
  },
  [43] = {
    43,
    17,
    33,
    common[1],
    common[2],
    {
      [1] = {
        Level = 1,
        AP = 10,
        Desc = "str_battle_n49_tlv_5",
        BuffList = {
          {
            BuffID = 40002231,
            BuffTargetType = 27,
            BuffTargetParam = {1602331, 1}
          },
          {
            BuffID = 40002231,
            BuffTargetType = 27,
            BuffTargetParam = {1602341, 1}
          },
          {
            BuffID = 40002231,
            BuffTargetType = 27,
            BuffTargetParam = {1502351, 1}
          }
        }
      },
      [2] = {
        Level = 2,
        AP = 40,
        Desc = "str_battle_n49_tlv_8",
        BuffList = {
          {BuffID = 40002232, BuffTargetType = 9}
        }
      },
      [3] = {
        Level = 3,
        AP = 70,
        Desc = "str_battle_n49_tlv_11",
        BuffList = {
          {
            BuffID = 400022331,
            BuffTargetType = 27,
            BuffTargetParam = {1602331, 1}
          },
          {
            BuffID = 400022332,
            BuffTargetType = 27,
            BuffTargetParam = {1602341, 1}
          },
          {
            BuffID = 400022333,
            BuffTargetType = 27,
            BuffTargetParam = {1502351, 1}
          }
        }
      },
      [4] = {
        Level = 4,
        AP = 100,
        Desc = "str_battle_n49_tlv_14",
        BuffList = {
          {
            BuffID = 40002234,
            BuffTargetType = 27,
            BuffTargetParam = {1602331, 1}
          },
          {
            BuffID = 40002234,
            BuffTargetType = 27,
            BuffTargetParam = {1602341, 1}
          },
          {
            BuffID = 40002234,
            BuffTargetType = 27,
            BuffTargetParam = {1502351, 1}
          }
        }
      },
      [5] = {
        Level = 5,
        AP = 130,
        Desc = "str_battle_n49_tlv_17",
        BuffList = {
          {BuffID = 40002235, BuffTargetType = 9}
        }
      },
      [6] = {
        Level = 6,
        AP = 160,
        Desc = "str_battle_n49_tlv_20",
        BuffList = {
          {
            BuffID = 40002236,
            BuffTargetType = 27,
            BuffTargetParam = {1602331, 1}
          },
          {
            BuffID = 40002236,
            BuffTargetType = 27,
            BuffTargetParam = {1602341, 1}
          },
          {
            BuffID = 40002236,
            BuffTargetType = 27,
            BuffTargetParam = {1502351, 1}
          }
        }
      },
      [7] = {
        Level = 7,
        AP = 200,
        Desc = "str_battle_n49_tlv_23",
        BuffList = {
          {BuffID = 40002237, BuffTargetType = 9}
        }
      }
    }
  }
}
return config, "ID", key
