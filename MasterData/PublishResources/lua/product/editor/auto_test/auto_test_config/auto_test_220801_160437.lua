AutoTest_220801_160437 = {
  cases = {
    [1] = {
      [1] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 305
        }
      },
      [2] = {
        action = "SetTeamPosition",
        args = {pos = 505}
      },
      [3] = {
        action = "CheckTeamOrder",
        args = {
          index = 1,
          name = "p2",
          trigger = 88
        }
      },
      [4] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "ChangeTeamLeaderCount",
          expect = 3.0,
          name = "team",
          trigger = 88
        }
      },
      [5] = {
        action = "ChangeTeamLeader",
        args = {index = 2}
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "交换队长不消耗次数"
    }
  },
  name = "joker突破6",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1500331,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 6,
      equiplv = 10,
      grade = 2,
      id = 1601581,
      level = 2,
      name = "p2"
    }
  },
  remotePet = {},
  setup = {
    [1] = {
      args = {levelID = 4001070, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
