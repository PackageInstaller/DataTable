AutoTest_220117_141240 = {
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
          id = 3230501,
          name = "e1",
          pos = 408
        }
      },
      [5] = {
        action = "CheckMonsterCount",
        args = {
          count = 2,
          monsterid = 3230102,
          trigger = 88
        }
      },
      [6] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 208.0,
            [2] = 308.0,
            [3] = 408.0,
            [4] = 501.0,
            [5] = 502.0,
            [6] = 503.0,
            [7] = 504.0,
            [8] = 505.0,
            [9] = 506.0,
            [10] = 507.0,
            [11] = 509.0,
            [12] = 608.0,
            [13] = 708.0,
            [14] = 808.0
          },
          skillid = 590028303,
          trigger = 102
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
        action = "CheckMonsterCount",
        args = {
          count = 5,
          monsterid = 3230102,
          trigger = 88
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
      [12] = {
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 402,
          trigger = 88
        }
      },
      [13] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [15] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 103.0,
            [2] = 104.0,
            [3] = 105.0,
            [4] = 106.0,
            [5] = 202.0,
            [6] = 203.0,
            [7] = 204.0,
            [8] = 205.0,
            [9] = 206.0,
            [10] = 301.0,
            [11] = 302.0,
            [12] = 303.0,
            [13] = 304.0,
            [14] = 305.0,
            [15] = 306.0,
            [16] = 401.0,
            [17] = 403.0,
            [18] = 404.0,
            [19] = 405.0,
            [20] = 406.0,
            [21] = 501.0,
            [22] = 502.0,
            [23] = 503.0,
            [24] = 504.0,
            [25] = 505.0,
            [26] = 506.0,
            [27] = 601.0,
            [28] = 602.0,
            [29] = 603.0,
            [30] = 604.0,
            [31] = 605.0,
            [32] = 606.0,
            [33] = 701.0,
            [34] = 702.0,
            [35] = 703.0,
            [36] = 704.0,
            [37] = 705.0,
            [38] = 706.0,
            [39] = 802.0,
            [40] = 803.0,
            [41] = 804.0,
            [42] = 805.0,
            [43] = 806.0
          },
          skillid = 590028309,
          trigger = 102
        }
      },
      [16] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [17] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "经验本5"
    }
  },
  name = "经验本 森boss",
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
