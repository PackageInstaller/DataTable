AutoTest_240326_173114 = {
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
          pos = 504
        }
      },
      [4] = {
        action = "SetAllMonstersHP",
        args = {value = 999999}
      },
      [5] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "critParam",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_1",
          skillid = 1101881,
          trigger = 102,
          varname = "v1"
        }
      },
      [6] = {
        action = "CheckLocalValue",
        args = {
          target = 1.2000000476837,
          trigger = 88,
          varname = "v1"
        }
      },
      [7] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "critParam",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_1",
          skillid = 1101881,
          trigger = 102,
          varname = "v2"
        }
      },
      [8] = {
        action = "CheckLocalValue",
        args = {
          target = 1.2000000476837,
          trigger = 88,
          varname = "v2"
        }
      },
      [9] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "critParam",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_1",
          skillid = 1101881,
          trigger = 102,
          varname = "v3"
        }
      },
      [10] = {
        action = "CheckLocalValue",
        args = {
          target = 1.2000000476837,
          trigger = 88,
          varname = "v3"
        }
      },
      [11] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "critParam",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_1",
          skillid = 1101881,
          trigger = 102,
          varname = "v4"
        }
      },
      [12] = {
        action = "CheckLocalValue",
        args = {
          target = 1.2000000476837,
          trigger = 88,
          varname = "v4"
        }
      },
      [13] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 604.0,
            [4] = 505.0,
            [5] = 404.0,
            [6] = 303.0,
            [7] = 203.0,
            [8] = 202.0,
            [9] = 302.0,
            [10] = 301.0,
            [11] = 401.0,
            [12] = 501.0,
            [13] = 601.0,
            [14] = 702.0,
            [15] = 803.0,
            [16] = 804.0
          },
          pieceType = 1
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [15] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 806
        }
      },
      [16] = {
        action = "SetAllMonstersHP",
        args = {value = 999999}
      },
      [17] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "critParam",
          damageIndex = 1,
          defname = "e2",
          key = "CalcDamage_1",
          skillid = 1101881,
          trigger = 102,
          varname = "v5"
        }
      },
      [18] = {
        action = "CheckLocalValue",
        args = {
          target = 1.2000000476837,
          trigger = 88,
          varname = "v5"
        }
      },
      [19] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "critParam",
          damageIndex = 1,
          defname = "e2",
          key = "CalcDamage_1",
          skillid = 1101881,
          trigger = 102,
          varname = "v6"
        }
      },
      [20] = {
        action = "CheckLocalValue",
        args = {
          target = 1.2000000476837,
          trigger = 88,
          varname = "v6"
        }
      },
      [21] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "critParam",
          damageIndex = 1,
          defname = "e2",
          key = "CalcDamage_1",
          skillid = 1101881,
          trigger = 102,
          varname = "v7"
        }
      },
      [22] = {
        action = "CheckLocalValue",
        args = {
          target = 1.2000000476837,
          trigger = 88,
          varname = "v7"
        }
      },
      [23] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "critParam",
          damageIndex = 1,
          defname = "e2",
          key = "CalcDamage_1",
          skillid = 1101881,
          trigger = 102,
          varname = "v8"
        }
      },
      [24] = {
        action = "CheckLocalValue",
        args = {
          target = 1.2000000476837,
          trigger = 88,
          varname = "v8"
        }
      },
      [25] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 804.0,
            [2] = 805.0,
            [3] = 706.0,
            [4] = 807.0,
            [5] = 906.0
          },
          pieceType = 1
        }
      },
      [26] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "每回合开始，在周围挂上八卦阵，本回合对该方向格子的首次普攻暴击，造成X倍伤害"
    }
  },
  name = "丹棠觉2",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 2,
      id = 1601881,
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
