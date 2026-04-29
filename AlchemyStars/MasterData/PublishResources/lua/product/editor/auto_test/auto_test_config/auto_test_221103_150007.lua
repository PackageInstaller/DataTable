AutoTest_221103_150007 = {
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
          disableai = false,
          id = 5100111,
          name = "e1",
          pos = 504
        }
      },
      [4] = {
        action = "AddBuffToEntity",
        args = {buffID = 88841010, name = "e1"}
      },
      [5] = {
        action = "SetEntityHPPercent",
        args = {name = "e1", percent = 0.5}
      },
      [6] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "<",
          name = "e1",
          trigger = 88
        }
      },
      [7] = {
        action = "CheckEntityHP",
        args = {
          compare = "==",
          hp = 3283,
          name = "e1",
          trigger = 88
        }
      },
      [8] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "怪物获得50%的生命偷取。"
    }
  },
  name = "40010血肉饥渴",
  petList = {
    [1] = {
      awakening = 3,
      equiplv = 10,
      grade = 3,
      id = 1601481,
      level = 80,
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
