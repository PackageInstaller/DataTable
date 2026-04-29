AutoTest_220207_133024 = {
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
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 505.0,
            [2] = 509.0
          }
        }
      },
      [4] = {
        action = "CheckEntityPos",
        args = {
          name = "enemy",
          pos = 509,
          trigger = 88
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [6] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "SetTeamPowerFull",
        args = {name = "enemy", name_select_index = 1}
      },
      [9] = {
        action = "BlackFistCastSkill",
        args = {
          name = "r1",
          pickUpPos = {
            [1] = 502.0,
            [2] = 505.0
          }
        }
      },
      [10] = {
        action = "CheckEntityPos",
        args = {
          name = "team",
          pos = 505,
          trigger = 88
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "库斯库塔传送  脚下格子颜色"
    }
  },
  name = "黑拳赛-库斯库塔传送",
  petList = {
    [1] = {
      awakening = 5,
      equiplv = 0,
      grade = 0,
      id = 1500981,
      level = 1,
      name = "p1"
    }
  },
  remotePet = {
    [1] = {
      awakening = 5,
      equiplv = 0,
      grade = 0,
      id = 1500981,
      level = 1,
      name = "r1"
    }
  },
  setup = {
    [1] = {
      args = {levelID = 1, matchType = 12},
      setup = "LevelBasic"
    }
  }
}
