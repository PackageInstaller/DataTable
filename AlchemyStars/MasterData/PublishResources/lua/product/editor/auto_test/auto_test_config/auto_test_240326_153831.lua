AutoTest_240326_153831 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetEntityPosition",
        args = {name = "p1", pos = 502}
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 505
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 506
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 405
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e4",
          pos = 605
        }
      },
      [7] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e5",
          pos = 507
        }
      },
      [8] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 2001873,
          trigger = 102,
          varname = "v1"
        }
      },
      [9] = {
        action = "CheckLocalValue",
        args = {
          target = 1.5,
          trigger = 88,
          varname = "v1"
        }
      },
      [10] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e2",
          key = "CalcDamage_4",
          skillid = 2001873,
          trigger = 102,
          varname = "v2"
        }
      },
      [11] = {
        action = "CheckLocalValue",
        args = {
          target = 1.5,
          trigger = 88,
          varname = "v2"
        }
      },
      [12] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e3",
          key = "CalcDamage_4",
          skillid = 2001873,
          trigger = 102,
          varname = "v3"
        }
      },
      [13] = {
        action = "CheckLocalValue",
        args = {
          target = 1.5,
          trigger = 88,
          varname = "v3"
        }
      },
      [14] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 2001873,
          trigger = 102,
          varname = "v4"
        }
      },
      [15] = {
        action = "CheckLocalValue",
        args = {
          target = 1.5,
          trigger = 88,
          varname = "v4"
        }
      },
      [16] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e5",
          trigger = 88
        }
      },
      [17] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 702.0,
            [4] = 701.0,
            [5] = 601.0,
            [6] = 501.0,
            [7] = 401.0,
            [8] = 301.0,
            [9] = 202.0,
            [10] = 203.0,
            [11] = 302.0,
            [12] = 402.0,
            [13] = 503.0
          },
          pieceType = 1
        }
      },
      [18] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "对最近的4个敌人造成150%攻击力的伤害。"
    }
  },
  name = "李天闲连锁技3",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 0,
      id = 1501871,
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
