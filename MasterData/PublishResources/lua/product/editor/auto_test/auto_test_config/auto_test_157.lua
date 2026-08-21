AutoTest_157 = {
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
          pos = 404
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 504
        }
      },
      [6] = {
        action = "SetEntityHPPercent",
        args = {name = "e1", percent = 0.25}
      },
      [7] = {
        action = "SetEntityHPPercent",
        args = {name = "e2", percent = 0.25}
      },
      [8] = {
        action = "CheckEntityBuffValue",
        args = {
          key = "SoulCount",
          name = "p1",
          trigger = 88,
          value = 2
        }
      },
      [9] = {
        action = "FakeCastSkill",
        args = {
          name = "p2",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "获得灵魂的条件调整为任意光灵的主动技造成击杀"
    }
  },
  name = "米娅觉3被动技强化",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1600051,
      level = 10,
      name = "p1"
    },
    [2] = {
      affinity = 0,
      awakening = 0,
      equiplv = 0,
      grade = 3,
      id = 1400441,
      level = 10,
      name = "p2"
    }
  },
  setup = {
    [1] = {
      args = {levelID = 1, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
