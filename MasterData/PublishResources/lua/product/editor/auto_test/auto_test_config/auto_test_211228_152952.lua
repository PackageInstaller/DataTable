AutoTest_211228_152952 = {
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
          id = 2040611,
          name = "e1",
          pos = 207
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 5,
          disableai = false,
          id = 2040621,
          name = "e2",
          pos = 702
        }
      },
      [6] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 202.0,
            [2] = 302.0,
            [3] = 402.0,
            [4] = 502.0,
            [5] = 602.0,
            [6] = 701.0,
            [7] = 703.0,
            [8] = 704.0,
            [9] = 705.0,
            [10] = 706.0,
            [11] = 707.0,
            [12] = 708.0,
            [13] = 709.0,
            [14] = 802.0
          },
          skillid = 500040,
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
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 202.0,
            [2] = 302.0,
            [3] = 402.0,
            [4] = 502.0,
            [5] = 602.0,
            [6] = 702.0
          },
          skillid = 500042,
          trigger = 102
        }
      },
      [10] = {
        action = "CheckEntityPos",
        args = {
          name = "p1",
          pos = 202,
          trigger = 88
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
      [13] = {
        action = "CheckTrapExist",
        args = {
          exist = true,
          trapIds = {
            [1] = 10.0
          },
          trigger = 88
        },
        exist = true
      },
      [14] = {
        action = "CheckTrapExist",
        args = {
          exist = true,
          trapIds = {
            [1] = 11.0
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
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 103.0,
            [2] = 202.0,
            [3] = 204.0,
            [4] = 303.0
          },
          skillid = 500030,
          trigger = 102
        }
      },
      [18] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [19] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [20] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 103.0,
            [2] = 104.0,
            [3] = 202.0,
            [4] = 203.0,
            [5] = 204.0,
            [6] = 302.0,
            [7] = 303.0,
            [8] = 304.0
          },
          skillid = 500032,
          trigger = 102
        }
      },
      [21] = {
        action = "CheckBuffLogic",
        args = {
          exist = true,
          logic = "ATBuffStun",
          logic_select_index = 10,
          name = "team",
          trigger = 88
        }
      },
      [22] = {
        action = "CheckMonsterCount",
        args = {
          count = 1,
          monsterid = 2000171,
          trigger = 88
        }
      },
      [23] = {
        action = "CheckMonsterCount",
        args = {
          count = 1,
          monsterid = 2000181,
          trigger = 88
        }
      },
      [24] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [25] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [26] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [27] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [28] = {
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
          skillid = 1003101,
          trigger = 102
        }
      },
      [29] = {
        action = "SetAllMonstersHPPercent",
        args = {percent = 0.5}
      },
      [30] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "<",
          name = "e1",
          trigger = 88
        }
      },
      [31] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "<",
          name = "e2",
          trigger = 88
        }
      },
      [32] = {
        action = "CheckBuffLogic",
        args = {
          exist = true,
          logic = "ATBuffBurn",
          logic_select_index = 9,
          name = "team",
          trigger = 88
        }
      },
      [33] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [34] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新测试用例"
    }
  },
  name = "4-7 斯叶特/夏尔",
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
      args = {levelID = 1, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
