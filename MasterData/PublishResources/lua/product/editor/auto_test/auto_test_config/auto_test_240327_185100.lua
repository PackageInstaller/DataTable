AutoTest_240327_185100 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 403
        }
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 305
        }
      },
      [4] = {
        action = "SetAllMonstersHP",
        args = {value = 99999}
      },
      [5] = {
        action = "SetEntityPosition",
        args = {name = "p1", pos = 502}
      },
      [6] = {
        action = "CheckUIPetLayerCount",
        args = {
          expect = 1,
          name = "p1",
          trigger = 102
        }
      },
      [7] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 505.0
          },
          skillIndex = 1
        }
      },
      [8] = {
        action = "CheckTrapExist",
        args = {
          exist = true,
          trapIds = {
            [1] = 1.6021612E7
          },
          trigger = 88
        },
        exist = true
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0
          },
          pieceType = 1
        }
      },
      [11] = {
        action = "CheckUIPetLayerCount",
        args = {
          expect = 3,
          name = "p1",
          trigger = 88
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [13] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 506.0
          },
          skillIndex = 1
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [15] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "skillIncreaseParam",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_1",
          skillid = 100216,
          trigger = 102,
          varname = "v1"
        }
      },
      [16] = {
        action = "CheckLocalValue",
        args = {
          target = 1.0,
          trigger = 102,
          varname = "v1"
        }
      },
      [17] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "skillIncreaseParam",
          damageIndex = 1,
          defname = "e2",
          key = "CalcDamage_1",
          skillid = 110216,
          trigger = 102,
          varname = "v2"
        }
      },
      [18] = {
        action = "CheckLocalValue",
        args = {
          target = 1.1499999761581,
          trigger = 102,
          varname = "v2"
        }
      },
      [19] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "skillIncreaseParam",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 2002161,
          trigger = 102,
          varname = "v3"
        }
      },
      [20] = {
        action = "CheckLocalValue",
        args = {
          target = 1.1499999761581,
          trigger = 102,
          varname = "v3"
        }
      },
      [21] = {
        action = "CheckUIPetLayerCount",
        args = {
          expect = 2,
          name = "p1",
          trigger = 88
        }
      },
      [22] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 503.0,
            [2] = 402.0,
            [3] = 302.0,
            [4] = 203.0,
            [5] = 304.0
          },
          pieceType = 1
        }
      },
      [23] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "回合结束在结界内，回复1点能量，场上每有1个结界，被动加成增加5%"
    }
  },
  name = "璇极突破6",
  petList = {
    [1] = {
      awakening = 6,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 1,
      id = 1602161,
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
