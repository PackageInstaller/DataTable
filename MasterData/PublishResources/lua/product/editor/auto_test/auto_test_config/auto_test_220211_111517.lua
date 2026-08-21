AutoTest_220211_111517 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetEveryPieceType",
        args = {
          pieceTypeArray = "0,0,4,4,3,2,1,0,0|0,1,1,1,3,1,1,2,0|1,1,1,1,3,2,1,2,4|1,1,1,1,3,1,1,2,4|1,0,1,1,3,2,1,2,4|1,1,4,1,3,1,1,2,4|1,1,4,1,3,1,1,2,4|0,1,4,1,1,1,1,2,0|0,0,4,4,3,2,1,0,0"
        }
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
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 14,
          name = "e2",
          pos = 505
        }
      },
      [5] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0
          },
          pieceType = 1
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新测试用例"
    }
  },
  name = "下落格子测试1",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1400071,
      level = 1,
      name = "p1"
    }
  },
  remotePet = {},
  setup = {
    [1] = {
      args = {
        affixs = {
          [1] = 8.8888888E7
        },
        levelID = 1,
        matchType = 1
      },
      setup = "LevelBasic"
    }
  }
}
