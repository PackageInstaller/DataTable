AutoTest_220722_185706 = {
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
        action = "ModifySanValue",
        args = {modifyValue = -10}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 2012911,
          name = "e1",
          pos = 503
        }
      },
      [5] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "e1"}
      },
      [6] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "DefenceConstantFix",
          expect = 51.900001525879,
          name = "p1",
          trigger = 88
        }
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
        action = "ModifySanValue",
        args = {modifyValue = -90}
      },
      [10] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "DefenceConstantFix",
          expect = 519.0,
          name = "p1",
          trigger = 88
        }
      },
      [11] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "被动强化：san值越低，回复量越高，最大翻倍"
    }
  },
  name = "梅觉醒2",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 2,
      id = 1501521,
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
