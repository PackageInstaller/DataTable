AutoTest_139 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [3] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 502}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 107
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 407
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 708
        }
      },
      [7] = {
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 305,
          trigger = 88
        }
      },
      [8] = {
        action = "CheckEntityPos",
        args = {
          name = "e2",
          pos = 405,
          trigger = 88
        }
      },
      [9] = {
        action = "CheckEntityPos",
        args = {
          name = "e3",
          pos = 708,
          trigger = 88
        }
      },
      [10] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 404.0
          }
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "任选1个格子放置分身，牵引分身周围3圈内的敌人"
    }
  },
  name = "基汀主动技：牵引",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1300461,
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
