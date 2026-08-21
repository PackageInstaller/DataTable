AutoTest_220125_151204 = {
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
          id = 2060111,
          name = "e1",
          pos = 505
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 5,
          disableai = false,
          id = 2060112,
          name = "e2",
          pos = 707
        }
      },
      [6] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 1,
          layerType = 50005,
          name = "e2",
          trigger = 88
        }
      },
      [7] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [9] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 105.0,
            [2] = 106.0,
            [3] = 205.0,
            [4] = 206.0,
            [5] = 305.0,
            [6] = 306.0,
            [7] = 405.0,
            [8] = 406.0,
            [9] = 501.0,
            [10] = 502.0,
            [11] = 503.0,
            [12] = 504.0,
            [13] = 505.0,
            [14] = 506.0,
            [15] = 507.0,
            [16] = 508.0,
            [17] = 509.0,
            [18] = 601.0,
            [19] = 602.0,
            [20] = 603.0,
            [21] = 604.0,
            [22] = 605.0,
            [23] = 606.0,
            [24] = 607.0,
            [25] = 608.0,
            [26] = 609.0,
            [27] = 705.0,
            [28] = 706.0,
            [29] = 805.0,
            [30] = 806.0,
            [31] = 905.0,
            [32] = 906.0
          },
          skillid = 501012,
          trigger = 102
        }
      },
      [10] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新测试用例"
    }
  },
  name = "影游者",
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
