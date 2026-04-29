AutoTest_220119_182901 = {
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
        action = "SetEntityHP",
        args = {hp = 999999, name = "team"}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 5,
          disableai = false,
          id = 2080113,
          name = "e1",
          pos = 507
        }
      },
      [5] = {
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 507,
          trigger = 88
        }
      },
      [6] = {
        action = "CheckEntityPos",
        args = {
          name = "team",
          pos = 506,
          trigger = 88
        }
      },
      [7] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 501.0,
            [2] = 502.0,
            [3] = 503.0,
            [4] = 504.0,
            [5] = 505.0,
            [6] = 506.0
          },
          skillid = 1000904,
          trigger = 102
        }
      },
      [8] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 406.0,
            [2] = 407.0,
            [3] = 408.0,
            [4] = 506.0,
            [5] = 508.0,
            [6] = 606.0,
            [7] = 607.0,
            [8] = 608.0
          },
          skillid = 1000914,
          trigger = 102
        }
      },
      [11] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新测试用例"
    }
  },
  name = "钩子怪镊元",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1400071,
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
