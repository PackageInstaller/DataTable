AutoTest_220215_110025 = {
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
          pos = 305
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
            [2] = 503.0,
            [3] = 403.0,
            [4] = 303.0,
            [5] = 203.0,
            [6] = 204.0,
            [7] = 304.0,
            [8] = 404.0,
            [9] = 504.0,
            [10] = 604.0,
            [11] = 704.0,
            [12] = 804.0,
            [13] = 805.0,
            [14] = 806.0,
            [15] = 807.0,
            [16] = 706.0,
            [17] = 707.0,
            [18] = 606.0,
            [19] = 607.0,
            [20] = 507.0,
            [21] = 406.0,
            [22] = 407.0,
            [23] = 307.0,
            [24] = 206.0,
            [25] = 207.0,
            [26] = 107.0
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
  name = "下落格子测试2",
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
