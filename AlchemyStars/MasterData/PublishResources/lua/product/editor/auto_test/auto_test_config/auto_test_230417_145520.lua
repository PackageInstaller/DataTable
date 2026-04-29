AutoTest_230417_145520 = {
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
          pos = 506
        }
      },
      [4] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0
          },
          pieceType = 1
        }
      },
      [5] = {
        action = "CheckFormulaAttr",
        args = {
          attr = "critParam",
          defname = "e1",
          expect = 1.2999999523163,
          key = "CalcDamage_4",
          skillid = 2201931,
          trigger = 102
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "连锁技对十字方向上的单位造成是伤害提高30%"
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
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 607
        }
      },
      [4] = {
        action = "CheckFormulaAttr",
        args = {
          attr = "critParam",
          defname = "e2",
          expect = 1.2999999523163,
          key = "CalcDamage_4",
          skillid = 2201932,
          trigger = 102
        }
      },
      [5] = {
        action = "CheckFormulaAttr",
        args = {
          attr = "critParam",
          defname = "e1",
          expect = 1.0,
          key = "CalcDamage_4",
          skillid = 2201932,
          trigger = 102
        }
      },
      [6] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 504.0,
            [2] = 404.0,
            [3] = 304.0,
            [4] = 204.0,
            [5] = 203.0,
            [6] = 303.0,
            [7] = 403.0,
            [8] = 503.0,
            [9] = 604.0,
            [10] = 605.0
          },
          pieceType = 1
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "连锁技对十字方向上的单位造成是伤害提高30%（二阶非十字范围内情况）"
    }
  },
  name = "克里斯汀觉醒2",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 2,
      id = 1501931,
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
