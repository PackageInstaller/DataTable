AutoTest_220808_180123 = {
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
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 101.0,
            [2] = 102.0,
            [3] = 103.0,
            [4] = 104.0,
            [5] = 105.0,
            [6] = 106.0,
            [7] = 107.0,
            [8] = 205.0,
            [9] = 206.0,
            [10] = 207.0,
            [11] = 301.0,
            [12] = 302.0,
            [13] = 303.0,
            [14] = 304.0,
            [15] = 305.0,
            [16] = 306.0,
            [17] = 307.0,
            [18] = 405.0,
            [19] = 406.0,
            [20] = 407.0,
            [21] = 501.0,
            [22] = 502.0,
            [23] = 503.0,
            [24] = 504.0,
            [25] = 505.0,
            [26] = 506.0,
            [27] = 507.0,
            [28] = 605.0,
            [29] = 606.0,
            [30] = 607.0,
            [31] = 701.0,
            [32] = 702.0,
            [33] = 703.0,
            [34] = 704.0,
            [35] = 705.0,
            [36] = 706.0,
            [37] = 707.0
          },
          skillid = 29030011,
          trigger = 102
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
      name = "魔方怪"
    }
  },
  name = "魔方怪",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600191,
      level = 1,
      name = "p1"
    }
  },
  remotePet = {},
  setup = {
    [1] = {
      args = {levelID = 5201012, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
