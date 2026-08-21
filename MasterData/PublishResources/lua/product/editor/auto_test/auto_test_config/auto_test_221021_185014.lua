AutoTest_221021_185014 = {
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
          pos = 503
        }
      },
      [4] = {
        action = "AddBuffToEntity",
        args = {buffID = 103201, name = "e1"}
      },
      [5] = {
        action = "AddBuffToEntity",
        args = {buffID = 10022, name = "e1"}
      },
      [6] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 103201,
          exist = true,
          name = "e1",
          trigger = 0
        }
      },
      [7] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 10022,
          exist = true,
          name = "e1",
          trigger = 0
        }
      },
      [8] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [9] = {
        action = "CheckEntityHP",
        args = {
          compare = "==",
          hp = 4687,
          name = "e1",
          trigger = 88
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新测试用例"
    }
  },
  name = "1032 胆怯不败",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600061,
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
