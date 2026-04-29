AutoTest_50 = {
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
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 504
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 607
        }
      },
      [6] = {
        action = "SetEntityHP",
        args = {hp = 3000, name = "e1"}
      },
      [7] = {
        action = "CheckEntityHP",
        args = {
          compare = "==",
          hp = 0,
          name = "e1",
          trigger = 30
        }
      },
      [8] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "主动技斩杀低于10%生命值的非boss怪"
    }
  },
  name = "索尔拉德主动技强化：斩杀",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 2,
      equiplv = 1,
      grade = 1,
      id = 1600141,
      level = 10,
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
