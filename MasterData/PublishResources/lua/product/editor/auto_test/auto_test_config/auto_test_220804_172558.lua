AutoTest_220804_172558 = {
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
        action = "CheckEntityAttribute",
        args = {
          attr = "DefenceConstantFix",
          expect = 73.800003051758,
          name = "p1",
          trigger = 88
        }
      },
      [6] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "ModifySanValue",
        args = {modifyValue = -90}
      },
      [9] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "DefenceConstantFix",
          expect = 738.0,
          name = "p1",
          trigger = 88
        }
      },
      [10] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "被动强化：san值越低，回复量越高，最大翻倍"
    }
  },
  name = "梅觉醒3",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
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
