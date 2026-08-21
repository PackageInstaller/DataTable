AutoTest_211227_180946 = {
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
        action = "AddMonster",
        args = {
          dir = 5,
          disableai = false,
          id = 2020611,
          name = "e1",
          pos = 505
        }
      },
      [4] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "team",
          trigger = 88
        }
      },
      [5] = {
        action = "CheckEntityPos",
        args = {
          name = "p1",
          pos = 501,
          trigger = 88
        }
      },
      [6] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 403.0,
            [2] = 404.0,
            [3] = 502.0,
            [4] = 503.0,
            [5] = 504.0,
            [6] = 505.0,
            [7] = 602.0,
            [8] = 603.0,
            [9] = 604.0,
            [10] = 605.0,
            [11] = 703.0,
            [12] = 704.0
          },
          skillid = 592101,
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
        action = "CheckTrapExist",
        args = {
          exist = true,
          trapIds = {
            [1] = 2016.0
          },
          trigger = 88
        },
        exist = true
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
            [1] = 501.0,
            [2] = 502.0,
            [3] = 601.0,
            [4] = 602.0
          },
          skillid = 500145,
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
      [15] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 103.0,
            [2] = 104.0,
            [3] = 105.0,
            [4] = 106.0,
            [5] = 107.0,
            [6] = 202.0,
            [7] = 203.0,
            [8] = 204.0,
            [9] = 205.0,
            [10] = 206.0,
            [11] = 207.0,
            [12] = 208.0,
            [13] = 301.0,
            [14] = 302.0,
            [15] = 303.0,
            [16] = 304.0,
            [17] = 305.0,
            [18] = 306.0,
            [19] = 307.0,
            [20] = 308.0,
            [21] = 309.0,
            [22] = 401.0,
            [23] = 402.0,
            [24] = 403.0,
            [25] = 404.0,
            [26] = 405.0,
            [27] = 406.0,
            [28] = 407.0,
            [29] = 408.0,
            [30] = 409.0,
            [31] = 501.0,
            [32] = 502.0,
            [33] = 505.0,
            [34] = 506.0,
            [35] = 507.0,
            [36] = 508.0,
            [37] = 509.0,
            [38] = 601.0,
            [39] = 602.0,
            [40] = 605.0,
            [41] = 606.0,
            [42] = 607.0,
            [43] = 608.0,
            [44] = 609.0,
            [45] = 701.0,
            [46] = 702.0,
            [47] = 703.0,
            [48] = 704.0,
            [49] = 705.0,
            [50] = 706.0,
            [51] = 707.0,
            [52] = 708.0,
            [53] = 709.0,
            [54] = 802.0,
            [55] = 803.0,
            [56] = 804.0,
            [57] = 805.0,
            [58] = 806.0,
            [59] = 807.0,
            [60] = 808.0,
            [61] = 903.0,
            [62] = 904.0,
            [63] = 905.0,
            [64] = 906.0,
            [65] = 907.0
          },
          skillid = 500146,
          trigger = 102
        }
      },
      [16] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "team",
          trigger = 88
        }
      },
      [17] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [18] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "技能1（范围查不到）"
    }
  },
  name = "2-8黑蹄",
  petList = {
    [1] = {
      awakening = 6,
      equiplv = 1,
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
