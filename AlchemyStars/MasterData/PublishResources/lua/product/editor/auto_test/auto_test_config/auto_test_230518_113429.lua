AutoTest_230518_113429 = {
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
          pos = 105
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 508
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 808
        }
      },
      [6] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 200181,
          trigger = 102,
          varname = "v1"
        }
      },
      [7] = {
        action = "CheckLocalValue",
        args = {
          target = 1.1499999761581,
          trigger = 88,
          varname = "v1"
        }
      },
      [8] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 402.0,
            [3] = 302.0,
            [4] = 202.0,
            [5] = 203.0,
            [6] = 103.0
          },
          pieceType = 1
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e2",
          key = "CalcDamage_4",
          skillid = 200182,
          trigger = 102,
          varname = "v2"
        }
      },
      [11] = {
        action = "CheckLocalValue",
        args = {
          target = 1.25,
          trigger = 88,
          varname = "v2"
        }
      },
      [12] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 103.0,
            [2] = 203.0,
            [3] = 303.0,
            [4] = 403.0,
            [5] = 304.0,
            [6] = 404.0,
            [7] = 503.0,
            [8] = 504.0,
            [9] = 505.0
          },
          pieceType = 1
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [14] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [15] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e3",
          key = "CalcDamage_4",
          skillid = 200183,
          trigger = 102,
          varname = "v3"
        }
      },
      [16] = {
        action = "CheckLocalValue",
        args = {
          target = 1.2999999523163,
          trigger = 88,
          varname = "v3"
        }
      },
      [17] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 505.0,
            [2] = 605.0,
            [3] = 604.0,
            [4] = 603.0,
            [5] = 602.0,
            [6] = 601.0,
            [7] = 701.0,
            [8] = 702.0,
            [9] = 802.0,
            [10] = 703.0,
            [11] = 803.0,
            [12] = 903.0,
            [13] = 904.0,
            [14] = 804.0,
            [15] = 805.0,
            [16] = 705.0,
            [17] = 806.0
          },
          pieceType = 1
        }
      },
      [18] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "连锁技系数提高10%/15%/20%"
    }
  },
  name = "雷吉纳精炼Ⅱ",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 2,
      equiplv = 10,
      grade = 3,
      id = 1500181,
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
