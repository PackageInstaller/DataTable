AutoTest_211228_162235 = {
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
          id = 2041211,
          name = "e1",
          pos = 505
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
          skillid = 500205,
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
            [1] = 221001.0
          },
          trigger = 88
        },
        exist = true
      },
      [10] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 502,
          trapIds = {
            [1] = 221001.0
          },
          trigger = 88
        }
      },
      [11] = {
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 505,
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
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 103.0,
            [2] = 104.0,
            [3] = 105.0,
            [4] = 202.0,
            [5] = 203.0,
            [6] = 204.0,
            [7] = 205.0,
            [8] = 302.0,
            [9] = 303.0,
            [10] = 304.0,
            [11] = 305.0,
            [12] = 401.0,
            [13] = 402.0,
            [14] = 403.0,
            [15] = 404.0,
            [16] = 405.0,
            [17] = 406.0,
            [18] = 407.0,
            [19] = 408.0,
            [20] = 409.0,
            [21] = 501.0,
            [22] = 502.0,
            [23] = 503.0,
            [24] = 504.0,
            [25] = 505.0,
            [26] = 506.0,
            [27] = 507.0,
            [28] = 508.0,
            [29] = 509.0,
            [30] = 601.0,
            [31] = 602.0,
            [32] = 603.0,
            [33] = 604.0,
            [34] = 605.0,
            [35] = 606.0,
            [36] = 607.0,
            [37] = 608.0,
            [38] = 609.0,
            [39] = 701.0,
            [40] = 702.0,
            [41] = 703.0,
            [42] = 704.0,
            [43] = 705.0,
            [44] = 706.0,
            [45] = 707.0,
            [46] = 708.0,
            [47] = 709.0,
            [48] = 802.0,
            [49] = 803.0,
            [50] = 804.0,
            [51] = 805.0,
            [52] = 903.0,
            [53] = 904.0,
            [54] = 905.0
          },
          skillid = 510208,
          trigger = 102
        }
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
        action = "FakeInputDoubleClick",
        args = {}
      },
      [18] = {
        action = "WaitGameFsm",
        args = {id = 5}
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
        action = "CheckBuffLogic",
        args = {
          exist = true,
          logic = "ATBuffBenumb",
          logic_select_index = 18,
          name = "team",
          trigger = 88
        }
      },
      [22] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [23] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新测试用例"
    }
  },
  name = "4-14 无聊",
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
