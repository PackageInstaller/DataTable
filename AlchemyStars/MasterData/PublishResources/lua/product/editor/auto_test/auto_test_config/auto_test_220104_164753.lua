AutoTest_220104_164753 = {
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
          id = 2091411,
          name = "e1",
          pos = 408
        }
      },
      [5] = {
        action = "AddTrap",
        args = {
          dir = 5,
          disableai = true,
          id = 2800241,
          name = "j1",
          pos = 6010
        }
      },
      [6] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 301.0,
            [2] = 302.0,
            [3] = 303.0,
            [4] = 304.0,
            [5] = 305.0,
            [6] = 306.0,
            [7] = 307.0,
            [8] = 308.0,
            [9] = 309.0,
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
            [37] = 701.0,
            [38] = 702.0,
            [39] = 703.0,
            [40] = 704.0,
            [41] = 705.0,
            [42] = 706.0,
            [43] = 707.0,
            [44] = 708.0,
            [45] = 709.0
          },
          skillid = 29002421,
          trigger = 102
        }
      },
      [7] = {
        action = "CheckEntityPos",
        args = {
          name = "p1",
          pos = 501,
          trigger = 88
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
          skillid = 29002422,
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
      [13] = {
        action = "CheckMonsterCount",
        args = {
          count = 2,
          monsterid = 2000532,
          trigger = 88
        }
      },
      [14] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 309,
          trapIds = {
            [1] = 61.0
          },
          trigger = 88
        }
      },
      [15] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 307,
          trapIds = {
            [1] = 61.0
          },
          trigger = 88
        }
      },
      [16] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 507,
          trapIds = {
            [1] = 61.0
          },
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
      [19] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 107.0,
            [2] = 207.0,
            [3] = 307.0,
            [4] = 407.0,
            [5] = 501.0,
            [6] = 502.0,
            [7] = 503.0,
            [8] = 504.0,
            [9] = 505.0,
            [10] = 506.0,
            [11] = 508.0,
            [12] = 509.0,
            [13] = 607.0,
            [14] = 707.0,
            [15] = 807.0,
            [16] = 907.0
          },
          skillid = 1001201,
          trigger = 102
        }
      },
      [20] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "team",
          trigger = 88
        }
      },
      [21] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [22] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新测试用例"
    }
  },
  name = "9-14疯角 吞罗",
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
