AutoTest_220125_161143 = {
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
          id = 20007033,
          name = "e1",
          pos = 505
        }
      },
      [5] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 104.0,
            [2] = 202.0,
            [3] = 203.0,
            [4] = 203.0,
            [5] = 204.0,
            [6] = 205.0,
            [7] = 205.0,
            [8] = 301.0,
            [9] = 302.0,
            [10] = 302.0,
            [11] = 304.0,
            [12] = 304.0,
            [13] = 305.0,
            [14] = 306.0,
            [15] = 401.0,
            [16] = 401.0,
            [17] = 405.0,
            [18] = 405.0,
            [19] = 501.0,
            [20] = 502.0,
            [21] = 502.0,
            [22] = 504.0,
            [23] = 504.0,
            [24] = 505.0,
            [25] = 506.0,
            [26] = 601.0,
            [27] = 601.0,
            [28] = 602.0,
            [29] = 603.0,
            [30] = 603.0,
            [31] = 604.0,
            [32] = 605.0,
            [33] = 605.0,
            [34] = 702.0,
            [35] = 704.0
          },
          skillid = 1004001,
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
      name = "新测试用例"
    }
  },
  name = "象棋 马",
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
