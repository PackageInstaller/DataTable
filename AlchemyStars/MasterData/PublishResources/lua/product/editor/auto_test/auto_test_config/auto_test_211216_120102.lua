AutoTest_211216_120102 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 502}
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 2071413,
          name = "e1",
          pos = 508
        }
      },
      [4] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [5] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 400116,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [6] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "baseDamage",
          attr_select_index = 8,
          damageIndex = 1,
          defname = "e1",
          key = "BaseDamage",
          key_select_index = 8,
          skillid = 303116,
          trigger = 102,
          varname = "v1"
        }
      },
      [7] = {
        action = "CheckLocalValue",
        args = {
          target = 1296.0,
          trigger = 88,
          varname = "v1"
        }
      },
      [8] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 508.0
          },
          skillIndex = 1
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "baseDamage",
          attr_select_index = 8,
          damageIndex = 1,
          defname = "e4",
          key = "BaseDamage",
          key_select_index = 28,
          skillid = 2061161,
          trigger = 102,
          varname = "v2"
        }
      },
      [11] = {
        action = "CheckLocalValue",
        args = {
          target = 1761.0,
          trigger = 88,
          varname = "v2"
        }
      },
      [12] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 505.0,
            [5] = 506.0
          },
          pieceType = 1
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [14] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 501
        }
      },
      [15] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [16] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 400116,
          exist = true,
          name = "e2",
          trigger = 88
        }
      },
      [17] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 501.0
          },
          skillIndex = 1
        }
      },
      [18] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [19] = {
        action = "CheckPetActiveSkillCanCast",
        args = {
          expect = true,
          name = "p1",
          skillID = 303116,
          trigger = 88
        }
      },
      [20] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 506.0,
            [2] = 406.0,
            [3] = 405.0,
            [4] = 404.0,
            [5] = 403.0
          },
          pieceType = 1
        }
      },
      [21] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [22] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 701
        }
      },
      [23] = {
        action = "SetEntityHP",
        args = {hp = 9999999, name = "e3"}
      },
      [24] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [25] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 400116,
          exist = true,
          name = "e3",
          trigger = 88
        }
      },
      [26] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 701.0
          },
          skillIndex = 1
        }
      },
      [27] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [28] = {
        action = "CheckPetActiveSkillCanCast",
        args = {
          expect = true,
          name = "p1",
          skillID = 303116,
          trigger = 88
        }
      },
      [29] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 403.0,
            [2] = 402.0,
            [3] = 302.0,
            [4] = 303.0,
            [5] = 304.0,
            [6] = 305.0,
            [7] = 306.0,
            [8] = 307.0,
            [9] = 407.0,
            [10] = 507.0,
            [11] = 607.0,
            [12] = 707.0,
            [13] = 706.0,
            [14] = 705.0,
            [15] = 704.0,
            [16] = 703.0
          },
          pieceType = 1
        }
      },
      [30] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [31] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [32] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "突破3：觉2强化：觉2效果提升至无视全部防御力  突破六：击杀标记目标或进入极光 时刻刷新主动技cd"
    }
  },
  name = "费劳尔突3突6",
  petList = {
    [1] = {
      awakening = 6,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 2,
      id = 1601161,
      level = 1,
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
