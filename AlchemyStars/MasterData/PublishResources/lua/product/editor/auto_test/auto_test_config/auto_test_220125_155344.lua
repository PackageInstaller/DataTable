AutoTest_220125_155344 = {
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
          id = 20007022,
          name = "e1",
          pos = 505
        }
      },
      [5] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 104.0,
            [2] = 105.0,
            [3] = 106.0,
            [4] = 204.0,
            [5] = 205.0,
            [6] = 206.0,
            [7] = 304.0,
            [8] = 305.0,
            [9] = 306.0,
            [10] = 401.0,
            [11] = 402.0,
            [12] = 403.0,
            [13] = 404.0,
            [14] = 405.0,
            [15] = 406.0,
            [16] = 407.0,
            [17] = 408.0,
            [18] = 409.0,
            [19] = 501.0,
            [20] = 502.0,
            [21] = 503.0,
            [22] = 504.0,
            [23] = 505.0,
            [24] = 506.0,
            [25] = 507.0,
            [26] = 508.0,
            [27] = 509.0,
            [28] = 601.0,
            [29] = 602.0,
            [30] = 603.0,
            [31] = 604.0,
            [32] = 605.0,
            [33] = 606.0,
            [34] = 607.0,
            [35] = 608.0,
            [36] = 609.0,
            [37] = 704.0,
            [38] = 705.0,
            [39] = 706.0,
            [40] = 804.0,
            [41] = 805.0,
            [42] = 806.0,
            [43] = 904.0,
            [44] = 905.0,
            [45] = 906.0
          },
          skillid = 1003901,
          trigger = 102
        }
      },
      [6] = {
        action = "CheckEntityPos",
        args = {
          name = "p1",
          pos = 501,
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
      name = "新测试用例"
    }
  },
  name = "象棋 车",
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
