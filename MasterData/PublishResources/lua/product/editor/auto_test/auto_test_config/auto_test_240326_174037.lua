AutoTest_240326_174037 = {
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
          skillid = 1201881,
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
          skillid = 1201881,
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
          skillid = 1201881,
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
          skillid = 1201881,
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
        action = "CaptureFormulaAttr",
        args = {
          attr = "critParam",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_1",
          skillid = 1201881,
          trigger = 102,
          varname = "v5"
        }
      },
      [14] = {
        action = "CheckLocalValue",
        args = {
          target = 1.2000000476837,
          trigger = 88,
          varname = "v5"
        }
      },
      [15] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "critParam",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_1",
          skillid = 1201881,
          trigger = 102,
          varname = "v6"
        }
      },
      [16] = {
        action = "CheckLocalValue",
        args = {
          target = 1.2000000476837,
          trigger = 88,
          varname = "v6"
        }
      },
      [17] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "critParam",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_1",
          skillid = 1201881,
          trigger = 102,
          varname = "v7"
        }
      },
      [18] = {
        action = "CheckLocalValue",
        args = {
          target = 1.2000000476837,
          trigger = 88,
          varname = "v7"
        }
      },
      [19] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "critParam",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_1",
          skillid = 1201881,
          trigger = 102,
          varname = "v8"
        }
      },
      [20] = {
        action = "CheckLocalValue",
        args = {
          target = 1.2000000476837,
          trigger = 88,
          varname = "v8"
        }
      },
      [21] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 603.0,
            [4] = 604.0,
            [5] = 605.0,
            [6] = 505.0,
            [7] = 405.0,
            [8] = 404.0,
            [9] = 403.0
          },
          pieceType = 1
        }
      },
      [22] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "被动强化：普攻8方向"
    }
  },
  name = "丹棠觉3",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 3,
      id = 1601881,
      level = 130,
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
