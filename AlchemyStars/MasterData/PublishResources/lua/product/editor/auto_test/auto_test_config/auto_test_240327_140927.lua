AutoTest_240327_140927 = {
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
          pos = 505
        }
      },
      [5] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 2002211,
          trigger = 102,
          varname = "v1"
        }
      },
      [6] = {
        action = "CheckLocalValue",
        args = {
          target = 1.5,
          trigger = 102,
          varname = "v1"
        }
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 501.0,
            [3] = 601.0,
            [4] = 602.0,
            [5] = 603.0
          },
          pieceType = 1
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "菱形12格150%"
    },
    [2] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [3] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 2002212,
          trigger = 102,
          varname = "v2"
        }
      },
      [4] = {
        action = "CheckLocalValue",
        args = {
          target = 1.5499999523163,
          trigger = 102,
          varname = "v2"
        }
      },
      [5] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 603.0,
            [2] = 703.0,
            [3] = 702.0,
            [4] = 701.0,
            [5] = 802.0,
            [6] = 903.0,
            [7] = 803.0,
            [8] = 904.0,
            [9] = 804.0,
            [10] = 704.0
          },
          pieceType = 1
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "米字16格155%"
    },
    [3] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [3] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e2",
          key = "CalcDamage_4",
          skillid = 2002213,
          trigger = 102,
          varname = "v3"
        }
      },
      [4] = {
        action = "CheckLocalValue",
        args = {
          target = 1.6499999761581,
          trigger = 102,
          varname = "v3"
        }
      },
      [5] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 704.0,
            [2] = 703.0,
            [3] = 702.0,
            [4] = 701.0,
            [5] = 601.0,
            [6] = 501.0,
            [7] = 401.0,
            [8] = 301.0,
            [9] = 302.0,
            [10] = 202.0,
            [11] = 203.0,
            [12] = 303.0,
            [13] = 403.0,
            [14] = 502.0
          },
          pieceType = 1
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "米字24格165%"
    }
  },
  name = "阿尔戈尔连锁技",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 0,
      grade = 0,
      id = 1602211,
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
