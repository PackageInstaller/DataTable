AutoTest_220104_135703 = {
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
          id = 2080611,
          name = "e1",
          pos = 505
        }
      },
      [5] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 501.0,
            [2] = 502.0,
            [3] = 503.0,
            [4] = 504.0,
            [5] = 601.0,
            [6] = 602.0,
            [7] = 603.0,
            [8] = 604.0
          },
          skillid = 1001612,
          trigger = 102
        }
      },
      [6] = {
        action = "CheckEntityPos",
        args = {
          name = "p1",
          pos = 504,
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
            [1] = 404.0,
            [2] = 405.0,
            [3] = 406.0,
            [4] = 407.0,
            [5] = 504.0,
            [6] = 507.0,
            [7] = 604.0,
            [8] = 607.0,
            [9] = 704.0,
            [10] = 705.0,
            [11] = 706.0,
            [12] = 707.0
          },
          skillid = 1001622,
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
      [12] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 303.0,
            [2] = 304.0,
            [3] = 305.0,
            [4] = 306.0,
            [5] = 403.0,
            [6] = 404.0,
            [7] = 405.0,
            [8] = 406.0,
            [9] = 407.0,
            [10] = 408.0,
            [11] = 501.0,
            [12] = 502.0,
            [13] = 504.0,
            [14] = 505.0,
            [15] = 507.0,
            [16] = 508.0,
            [17] = 601.0,
            [18] = 602.0,
            [19] = 604.0,
            [20] = 605.0,
            [21] = 702.0,
            [22] = 703.0,
            [23] = 802.0,
            [24] = 803.0,
            [25] = 806.0,
            [26] = 807.0,
            [27] = 906.0,
            [28] = 907.0
          },
          skillid = 1001632,
          trigger = 102
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
      name = "转色验证不了"
    }
  },
  name = "8-7 落卞",
  petList = {
    [1] = {
      awakening = 6,
      equiplv = 10,
      grade = 3,
      id = 1600191,
      level = 80,
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
