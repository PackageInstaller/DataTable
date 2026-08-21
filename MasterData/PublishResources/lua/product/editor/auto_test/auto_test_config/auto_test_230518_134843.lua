AutoTest_230518_134843 = {
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
          id = 5100111,
          name = "e1",
          pos = 505
        }
      },
      [4] = {
        action = "SetOnePieceType",
        args = {pieceType = 3, pos = 505}
      },
      [5] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [6] = {
        action = "SetOnePieceType",
        args = {pieceType = 4, pos = 505}
      },
      [7] = {
        action = "SetOnePieceType",
        args = {pieceType = 4, pos = 504}
      },
      [8] = {
        action = "SetOnePieceType",
        args = {pieceType = 4, pos = 503}
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [12] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "skillIncreaseParam",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_1",
          skillid = 100048,
          trigger = 102,
          varname = "v1"
        }
      },
      [13] = {
        action = "CheckLocalValue",
        args = {
          target = 1.1100000143051,
          trigger = 88,
          varname = "v1"
        }
      },
      [14] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "skillIncreaseParam",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_1",
          skillid = 100017,
          trigger = 102,
          varname = "v2"
        }
      },
      [15] = {
        action = "CheckLocalValue",
        args = {
          target = 1.0549999475479,
          trigger = 88,
          varname = "v2"
        }
      },
      [16] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0
          },
          pieceType = 4
        }
      },
      [17] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "被动强化：每有1个雷格子提升1%"
    }
  },
  name = "烈雀精炼Ⅰ",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 1,
      equiplv = 10,
      grade = 3,
      id = 1400481,
      level = 80,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 1,
      id = 1400171,
      level = 11,
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
