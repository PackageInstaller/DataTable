AutoTest_211214_225627 = {
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
        action = "CheckTrapExist",
        args = {
          exist = true,
          trapIds = {
            [1] = 14.0
          },
          trigger = 88
        },
        exist = true
      },
      [4] = {
        action = "CheckEntityPos",
        args = {
          name = "p1",
          pos = 505,
          trigger = 88
        }
      },
      [5] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 505.0
          }
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "1，突2：先制攻击 2，突5：主动技强化：提高强化格子的出率"
    }
  },
  name = "纳努赛尔突2突5",
  petList = {
    [1] = {
      awakening = 5,
      equiplv = 1,
      grade = 3,
      id = 1601151,
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
