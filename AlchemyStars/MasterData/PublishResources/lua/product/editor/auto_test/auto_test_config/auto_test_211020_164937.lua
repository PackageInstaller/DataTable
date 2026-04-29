AutoTest_211020_164937 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 5100111,
          name = "e1",
          pos = 503
        }
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 5100111,
          name = "e2",
          pos = 505
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 5100111,
          name = "e3",
          pos = 506
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 5100111,
          name = "e4",
          pos = 509
        }
      },
      [6] = {
        action = "SetTeamPowerFull",
        args = {}
      },
      [7] = {
        action = "FakeClickAutoFight",
        args = {}
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 14}
      },
      [9] = {
        action = "FakeClickAutoFight",
        args = {}
      },
      [10] = {
        action = "CheckDump",
        args = {trigger = 88}
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新测试用例"
    }
  },
  name = "普律玛自动战斗点选",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1601211,
      level = 1,
      name = "p1"
    }
  },
  setup = {
    [1] = {
      args = {levelID = 1, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
