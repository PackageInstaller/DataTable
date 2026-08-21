AutoTest_210918_143810 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPowerFull",
        args = {}
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 50313015,
          name = "e1",
          pos = 503
        }
      },
      [4] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [5] = {
        action = "FakeClickAutoFight",
        args = {}
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 14}
      },
      [7] = {
        action = "FakeClickAutoFight",
        args = {}
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [9] = {
        action = "SetTeamPowerFull",
        args = {}
      },
      [10] = {
        action = "FakeClickAutoFight",
        args = {}
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 14}
      },
      [12] = {
        action = "FakeClickAutoFight",
        args = {}
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "自动战斗点选方向内无怪物"
    }
  },
  name = "雷文顿自动战斗多格怪",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1601191,
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
