AutoTest_240326_170715 = {
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
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 306
        }
      },
      [5] = {
        action = "SetAllMonstersHP",
        args = {value = 999999}
      },
      [6] = {
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
      [7] = {
        action = "CheckLocalValue",
        args = {
          target = 1.2000000476837,
          trigger = 88,
          varname = "v1"
        }
      },
      [8] = {
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
      [9] = {
        action = "CheckLocalValue",
        args = {
          target = 1.2000000476837,
          trigger = 88,
          varname = "v2"
        }
      },
      [10] = {
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
      [11] = {
        action = "CheckLocalValue",
        args = {
          target = 1.2000000476837,
          trigger = 88,
          varname = "v3"
        }
      },
      [12] = {
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
      [13] = {
        action = "CheckLocalValue",
        args = {
          target = 1.2000000476837,
          trigger = 88,
          varname = "v4"
        }
      },
      [14] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "critParam",
          damageIndex = 1,
          defname = "e2",
          key = "CalcDamage_1",
          skillid = 110188,
          trigger = 102,
          varname = "v5"
        }
      },
      [15] = {
        action = "CheckLocalValue",
        args = {
          target = 1.0,
          trigger = 88,
          varname = "v5"
        }
      },
      [16] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "critParam",
          damageIndex = 1,
          defname = "e2",
          key = "CalcDamage_1",
          skillid = 110188,
          trigger = 102,
          varname = "v6"
        }
      },
      [17] = {
        action = "CheckLocalValue",
        args = {
          target = 1.0,
          trigger = 88,
          varname = "v6"
        }
      },
      [18] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "critParam",
          damageIndex = 1,
          defname = "e2",
          key = "CalcDamage_1",
          skillid = 110188,
          trigger = 102,
          varname = "v7"
        }
      },
      [19] = {
        action = "CheckLocalValue",
        args = {
          target = 1.0,
          trigger = 88,
          varname = "v7"
        }
      },
      [20] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "critParam",
          damageIndex = 1,
          defname = "e2",
          key = "CalcDamage_1",
          skillid = 110188,
          trigger = 102,
          varname = "v8"
        }
      },
      [21] = {
        action = "CheckLocalValue",
        args = {
          target = 1.0,
          trigger = 88,
          varname = "v8"
        }
      },
      [22] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 604.0,
            [4] = 505.0,
            [5] = 404.0,
            [6] = 305.0,
            [7] = 206.0,
            [8] = 307.0,
            [9] = 406.0
          },
          pieceType = 1
        }
      },
      [23] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "每回合开始，在周围挂上八卦阵，本回合对该方向格子的首次普攻暴击，造成X倍伤害"
    }
  },
  name = "丹棠觉1",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 1,
      id = 1601881,
      level = 40,
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
