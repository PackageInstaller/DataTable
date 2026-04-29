AutoTest_240416_175442 = {
  cases = {
    [1] = {
      [1] = {
        action = "AddMonster",
        args = {
          dir = 5,
          disableai = false,
          id = 543510101,
          name = "e1",
          pos = 505
        }
      },
      [2] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "team"}
      },
      [3] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 304.0,
            [2] = 404.0,
            [3] = 502.0,
            [4] = 503.0,
            [5] = 505.0,
            [6] = 506.0,
            [7] = 604.0,
            [8] = 704.0
          },
          skillid = 290910112,
          trigger = 102
        }
      },
      [4] = {
        action = "CheckFormulaAttr",
        args = {
          attr = "damagePercent",
          defname = "team",
          expect = 1.5,
          key = "CalcDamage_2",
          skillid = 290910112,
          trigger = 102
        }
      },
      [5] = {
        action = "CheckTrapCount",
        args = {
          expect = 8,
          trapIDs = {
            [1] = 2803501.0
          },
          trigger = 88
        }
      },
      [6] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 403,
          trapIds = {
            [1] = 7.0011141E7
          },
          trigger = 88
        }
      },
      [7] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 503,
          trapIds = {
            [1] = 7.0011141E7
          },
          trigger = 88
        }
      },
      [8] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 290910101,
          exist = true,
          name = "team",
          trigger = 88
        }
      },
      [9] = {
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 504,
          trigger = 88
        }
      },
      [10] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "￭ 走1打2，对目标造成伤害并附加2层融体buff"
    },
    [2] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 290910101,
          exist = true,
          name = "team",
          trigger = 102
        }
      },
      [3] = {
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 505,
          trigger = 88
        }
      },
      [4] = {
        action = "CheckTrapCount",
        args = {
          expect = 10,
          trapIDs = {
            [1] = 2803501.0
          },
          trigger = 88
        }
      },
      [5] = {
        action = "CheckFormulaAttr",
        args = {
          attr = "damagePercent",
          defname = "team",
          expect = 1.2000000476837,
          key = "CalcDamage_2",
          skillid = 290910113,
          trigger = 102
        }
      },
      [6] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "￭ 远离玩家后，对玩家造成必中伤害，0.35倍率+7%玩家最大生命，1层融体"
    },
    [3] = {
      [1] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 506.0
          },
          skillIndex = 1
        }
      },
      [2] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [3] = {
        action = "CheckTrapCount",
        args = {
          expect = 7,
          trapIDs = {
            [1] = 7.0011141E7
          },
          trigger = 88
        }
      },
      [4] = {
        action = "CheckTrapCount",
        args = {
          expect = 2,
          trapIDs = {
            [1] = 2803501.0
          },
          trigger = 88
        }
      },
      [5] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 104.0,
            [2] = 105.0,
            [3] = 106.0,
            [4] = 204.0,
            [5] = 205.0,
            [6] = 206.0,
            [7] = 304.0,
            [8] = 305.0,
            [9] = 306.0,
            [10] = 401.0,
            [11] = 402.0,
            [12] = 403.0,
            [13] = 404.0,
            [14] = 404.0,
            [15] = 405.0,
            [16] = 406.0,
            [17] = 406.0,
            [18] = 407.0,
            [19] = 408.0,
            [20] = 409.0,
            [21] = 501.0,
            [22] = 502.0,
            [23] = 503.0,
            [24] = 504.0,
            [25] = 506.0,
            [26] = 507.0,
            [27] = 508.0,
            [28] = 509.0,
            [29] = 601.0,
            [30] = 602.0,
            [31] = 603.0,
            [32] = 604.0,
            [33] = 604.0,
            [34] = 605.0,
            [35] = 606.0,
            [36] = 606.0,
            [37] = 607.0,
            [38] = 608.0,
            [39] = 609.0,
            [40] = 704.0,
            [41] = 705.0,
            [42] = 706.0,
            [43] = 804.0,
            [44] = 805.0,
            [45] = 806.0,
            [46] = 904.0,
            [47] = 905.0,
            [48] = 906.0
          },
          skillid = 290910124,
          trigger = 102
        }
      },
      [6] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "￭ 走1打3列范围，将目标附加融体。召唤毒痕"
    },
    [4] = {
      [1] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 404,
          trapIds = {
            [1] = 7.0011141E7
          },
          trigger = 88
        }
      },
      [2] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 405,
          trapIds = {
            [1] = 7.0011141E7
          },
          trigger = 88
        }
      },
      [3] = {
        action = "CheckTrapCount",
        args = {
          expect = 7,
          trapIDs = {
            [1] = 2803501.0
          },
          trigger = 88
        }
      },
      [4] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 290910101,
          exist = true,
          name = "team",
          trigger = 88
        }
      },
      [5] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 305.0,
            [2] = 405.0,
            [3] = 503.0,
            [4] = 504.0,
            [5] = 506.0,
            [6] = 507.0,
            [7] = 605.0,
            [8] = 705.0
          },
          skillid = 290910112,
          trigger = 102
        }
      },
      [6] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "技能循环，释放主动技能1"
    }
  },
  name = "异化丽贝卡",
  petList = {
    [1] = {
      awakening = 6,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 3,
      id = 1600061,
      level = 80,
      name = "p1"
    }
  },
  remotePet = {},
  setup = {
    [1] = {
      args = {levelID = 1, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
