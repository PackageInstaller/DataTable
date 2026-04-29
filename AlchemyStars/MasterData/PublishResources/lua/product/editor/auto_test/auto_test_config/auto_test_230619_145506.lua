AutoTest_230619_145506 = {
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
          pos = 505
        }
      },
      [4] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 160202100,
          name = "e1",
          pos = 504
        }
      },
      [5] = {
        action = "CheckPetActiveSkillCanCast",
        args = {
          expect = true,
          name = "p1",
          skillID = 3362022,
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
      name = "主动2的cd-1"
    }
  },
  name = "sp城主突破6",
  petList = {
    [1] = {
      awakening = 6,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 3,
      id = 1602021,
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
