AutoTest_211230_114701 = {
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
          id = 2060611,
          name = "e1",
          pos = 506
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
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 504,
          trigger = 88
        }
      },
      [8] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 404.0,
            [2] = 503.0,
            [3] = 505.0,
            [4] = 604.0
          },
          skillid = 501083,
          trigger = 102
        }
      },
      [9] = {
        action = "CheckMonsterCount",
        args = {
          count = 2,
          monsterid = 2000451,
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
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 302.0,
            [2] = 303.0,
            [3] = 304.0,
            [4] = 305.0,
            [5] = 306.0,
            [6] = 402.0,
            [7] = 403.0,
            [8] = 404.0,
            [9] = 405.0,
            [10] = 406.0,
            [11] = 502.0,
            [12] = 503.0,
            [13] = 505.0,
            [14] = 506.0,
            [15] = 602.0,
            [16] = 603.0,
            [17] = 604.0,
            [18] = 605.0,
            [19] = 606.0,
            [20] = 702.0,
            [21] = 703.0,
            [22] = 704.0,
            [23] = 705.0,
            [24] = 706.0
          },
          skillid = 501084,
          trigger = 102
        }
      },
      [13] = {
        action = "CheckUIBuffIcon",
        args = {
          buffID = 50002,
          expect = 2,
          name = "team",
          trigger = 88
        }
      },
      [14] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [16] = {
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
          skillid = 501085,
          trigger = 102
        }
      },
      [17] = {
        action = "CheckUIBuffIcon",
        args = {
          buffID = 50002,
          expect = 0,
          name = "team",
          trigger = 88
        }
      },
      [18] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "team",
          trigger = 88
        }
      },
      [19] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [20] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [21] = {
        action = "SetEntityHPPercent",
        args = {name = "e1", percent = 0.30000001192093}
      },
      [22] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0
          },
          pieceType = 1
        }
      },
      [23] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e1",
          trigger = 88
        }
      },
      [24] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [25] = {
        action = "CheckMonsterCount",
        args = {
          count = 5,
          monsterid = 2000451,
          trigger = 88
        }
      },
      [26] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [27] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新测试用例"
    }
  },
  name = "6-7 格茨德",
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
