AutoTest_220114_121211 = {
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
          id = 4020611,
          name = "e1",
          pos = 508
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
            [2] = 105.0,
            [3] = 204.0,
            [4] = 205.0,
            [5] = 302.0,
            [6] = 303.0,
            [7] = 306.0,
            [8] = 307.0,
            [9] = 402.0,
            [10] = 403.0,
            [11] = 406.0,
            [12] = 407.0,
            [13] = 601.0,
            [14] = 602.0,
            [15] = 701.0,
            [16] = 702.0,
            [17] = 706.0,
            [18] = 707.0,
            [19] = 803.0,
            [20] = 804.0,
            [21] = 806.0,
            [22] = 807.0,
            [23] = 903.0,
            [24] = 904.0
          },
          skillid = 500217,
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
            [33] = 503.0,
            [34] = 504.0,
            [35] = 505.0,
            [36] = 506.0,
            [37] = 507.0,
            [38] = 508.0,
            [39] = 509.0,
            [40] = 601.0,
            [41] = 602.0,
            [42] = 603.0,
            [43] = 604.0,
            [44] = 605.0,
            [45] = 606.0,
            [46] = 607.0,
            [47] = 608.0,
            [48] = 609.0,
            [49] = 701.0,
            [50] = 702.0,
            [51] = 703.0,
            [52] = 704.0,
            [53] = 705.0,
            [54] = 706.0,
            [55] = 707.0,
            [56] = 708.0,
            [57] = 709.0,
            [58] = 802.0,
            [59] = 803.0,
            [60] = 804.0,
            [61] = 805.0,
            [62] = 806.0,
            [63] = 807.0,
            [64] = 808.0,
            [65] = 903.0,
            [66] = 904.0,
            [67] = 905.0,
            [68] = 906.0,
            [69] = 907.0
          },
          skillid = 500218,
          trigger = 102
        }
      },
      [11] = {
        action = "CheckEntityPos",
        args = {
          name = "p1",
          pos = 501,
          trigger = 88
        }
      },
      [12] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [14] = {
        action = "CheckTrapExist",
        args = {
          exist = true,
          trapIds = {
            [1] = 119.0
          },
          trigger = 88
        },
        exist = true
      },
      [15] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [16] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [17] = {
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [18] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e1",
          trigger = 88
        }
      },
      [19] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 501.0
          }
        }
      },
      [20] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [21] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [22] = {
        action = "FakeCastSkill",
        args = {
          name = "p2",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [23] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新测试用例"
    }
  },
  name = "番外2-6 鲍林格580",
  petList = {
    [1] = {
      awakening = 6,
      equiplv = 1,
      grade = 3,
      id = 1600231,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600061,
      level = 1,
      name = "p2"
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
