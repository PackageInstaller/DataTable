AutoTest_220114_134757 = {
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
          id = 4030611,
          name = "e1",
          pos = 505
        }
      },
      [5] = {
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
          skillid = 590044203,
          trigger = 102
        }
      },
      [6] = {
        action = "CheckTrapExist",
        args = {
          exist = true,
          trapIds = {
            [1] = 2222.0
          },
          trigger = 88
        },
        exist = true
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
        action = "CheckTrapExist",
        args = {
          exist = true,
          trapIds = {
            [1] = 2232.0
          },
          trigger = 88
        },
        exist = true
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
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
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 501.0,
            [2] = 502.0,
            [3] = 601.0,
            [4] = 602.0
          },
          skillid = 590044205,
          trigger = 102
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
          skillid = 590044206,
          trigger = 102
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
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [20] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 401.0
          }
        }
      },
      [21] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 404,
          trapIds = {
            [1] = 2232.0
          },
          trigger = 88
        }
      },
      [22] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [23] = {
        action = "FakeCastSkill",
        args = {
          name = "p2",
          pickUpPos = {
            [1] = 402.0
          }
        }
      },
      [24] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 404,
          trapIds = {
            [1] = 2232.0
          },
          trigger = 88
        }
      },
      [25] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [26] = {
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [27] = {
        action = "CheckGridTrap",
        args = {
          exist = false,
          pos = 505,
          trapIds = {
            [1] = 2232.0
          },
          trigger = 88
        }
      },
      [28] = {
        action = "FakeCastSkill",
        args = {
          name = "p2",
          pickUpPos = {
            [1] = 402.0
          }
        }
      },
      [29] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新测试用例"
    }
  },
  name = "番外3-6 黑蹄pro",
  petList = {
    [1] = {
      awakening = 6,
      equiplv = 1,
      grade = 3,
      id = 1600061,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 6,
      equiplv = 1,
      grade = 3,
      id = 1600251,
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
