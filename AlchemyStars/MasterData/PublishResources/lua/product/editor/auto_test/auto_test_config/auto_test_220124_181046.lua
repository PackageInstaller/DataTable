AutoTest_220124_181046 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "AddTrap",
        args = {
          dir = 5,
          disableai = true,
          id = 508201101,
          name = "e1",
          pos = 305
        }
      },
      [3] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 508201102,
          name = "e2",
          pos = 301
        }
      },
      [4] = {
        action = "CheckEntityPos",
        args = {
          name = "p1",
          pos = 301,
          trigger = 88
        }
      },
      [5] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 402.0,
            [3] = 301.0,
            [4] = 202.0
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
  name = "划线被麻痹位置错误",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1400071,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1300471,
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
