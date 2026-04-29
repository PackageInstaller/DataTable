AutoTest_210914_110150 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 904}
      },
      [3] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "team"}
      },
      [4] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 61,
          name = "j1",
          pos = 905
        }
      },
      [5] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 61,
          name = "j2",
          pos = 906
        }
      },
      [6] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 61,
          name = "j3",
          pos = 907
        }
      },
      [7] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 9000351,
          name = "e1",
          pos = 903
        }
      },
      [8] = {
        action = "CheckEntityPos",
        args = {
          name = "p1",
          pos = 907,
          trigger = 88
        }
      },
      [9] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新测试用例"
    }
  },
  name = "27711-击退小怪锁格子转色",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600191,
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
