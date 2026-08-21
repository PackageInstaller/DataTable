AutoTest_210922_153831 = {
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
          disableai = true,
          id = 50313015,
          name = "e1",
          pos = 505
        }
      },
      [3] = {
        action = "SetTeamPowerFull",
        args = {}
      },
      [4] = {
        action = "FakeClickAutoFight",
        args = {}
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 14}
      },
      [6] = {
        action = "FakeClickAutoFight",
        args = {}
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "SetTeamPowerFull",
        args = {}
      },
      [9] = {
        action = "FakeClickAutoFight",
        args = {}
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 14}
      },
      [11] = {
        action = "FakeClickAutoFight",
        args = {}
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "自动战斗点选同一方向"
    }
  },
  name = "卡夫卡自动战斗点选",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1400161,
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
