AutoTest_220124_114207 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "AddMonster",
        args = {
          dir = 5,
          disableai = false,
          id = 9999082,
          name = "e1",
          pos = 505
        }
      },
      [3] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "team"}
      },
      [4] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "p1"}
      },
      [5] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [9] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 501.0,
            [2] = 402.0
          },
          pieceType = 2
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "秘境无聊技能扣血2次"
    }
  },
  name = "秘境无聊技能扣血2次",
  petList = {
    [1] = {
      awakening = 2,
      equiplv = 1,
      grade = 2,
      id = 1400071,
      level = 1,
      name = "p1"
    }
  },
  remotePet = {},
  setup = {
    [1] = {
      args = {levelID = 1, matchType = 6},
      setup = "LevelBasic"
    }
  }
}
