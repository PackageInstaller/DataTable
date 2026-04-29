AutoTest_210914_105713 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPosition",
        args = {pos = 404}
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 50111011,
          name = "e2",
          pos = 405
        }
      },
      [4] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 2015,
          name = "e1",
          pos = 703
        }
      },
      [5] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 603.0
          }
        }
      },
      [6] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "team",
          trigger = 88
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "吉纳维芙觉醒1后击碎石头不会回血 "
    }
  },
  name = "26675-吉纳维芙觉1回血",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 1,
      id = 1501141,
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
