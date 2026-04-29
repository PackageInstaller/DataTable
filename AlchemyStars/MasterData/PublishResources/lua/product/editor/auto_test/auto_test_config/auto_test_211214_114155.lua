AutoTest_211214_114155 = {
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
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [4] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 503,
          trapIds = {
            [1] = 14.0
          },
          trigger = 88
        }
      },
      [5] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 503.0
          }
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "主动技强化：转为森强化格子"
    }
  },
  name = "帕索洛突破4",
  petList = {
    [1] = {
      awakening = 4,
      equiplv = 1,
      grade = 3,
      id = 1401271,
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
