AutoTest_220127_105100 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 701}
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 702
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 601
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 602
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 802
        }
      },
      [7] = {
        action = "CheckDump",
        args = {trigger = 88}
      },
      [8] = {
        action = "FakeClickAutoFight",
        args = {}
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 15}
      },
      [10] = {
        action = "FakeClickAutoFight",
        args = {}
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "逃离出口关被怪围困自动战斗报错"
    }
  },
  name = "逃离出口被围困",
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
      args = {levelID = 108, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
