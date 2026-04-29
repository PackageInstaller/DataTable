AutoTest_240326_182503 = {
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
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 506
        }
      },
      [6] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 402.0,
            [3] = 302.0,
            [4] = 403.0,
            [5] = 303.0,
            [6] = 203.0,
            [7] = 103.0,
            [8] = 202.0,
            [9] = 301.0,
            [10] = 401.0,
            [11] = 501.0,
            [12] = 601.0,
            [13] = 701.0,
            [14] = 802.0,
            [15] = 903.0,
            [16] = 904.0
          },
          pieceType = 1
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 904.0,
            [2] = 804.0,
            [3] = 704.0,
            [4] = 604.0,
            [5] = 503.0,
            [6] = 504.0
          },
          pieceType = 1
        }
      },
      [9] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e3",
          key = "CalcDamage_149",
          skillid = 2302251,
          trigger = 102,
          varname = "v1"
        }
      },
      [10] = {
        action = "CheckLocalValue",
        args = {
          target = 2.2999999523163,
          trigger = 102,
          varname = "v1"
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "进极光时刻时,对最近单位挂一条边"
    }
  },
  name = "缇亚拉精炼3",
  petList = {
    [1] = {
      awakening = 3,
      equipRefineLv = 3,
      equiplv = 1,
      grade = 3,
      id = 1602251,
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
