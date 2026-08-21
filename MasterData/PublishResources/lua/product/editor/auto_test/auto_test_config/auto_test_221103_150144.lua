AutoTest_221103_150144 = {
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
          pos = 305
        }
      },
      [4] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 702.0,
            [4] = 802.0,
            [5] = 803.0,
            [6] = 903.0,
            [7] = 904.0,
            [8] = 905.0,
            [9] = 906.0,
            [10] = 907.0,
            [11] = 808.0,
            [12] = 807.0,
            [13] = 806.0,
            [14] = 805.0,
            [15] = 804.0,
            [16] = 704.0,
            [17] = 703.0,
            [18] = 603.0,
            [19] = 503.0,
            [20] = 402.0,
            [21] = 401.0,
            [22] = 501.0,
            [23] = 601.0,
            [24] = 701.0
          },
          pieceType = 1
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "无法进入极光时刻"
    }
  },
  name = "40049极光消逝（需要添加检查项）",
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
          [1] = 100101.0
        },
        levelID = 1,
        matchType = 1,
        wordIds = {
          [1] = 40049.0
        }
      },
      setup = "LevelBasic"
    }
  }
}
