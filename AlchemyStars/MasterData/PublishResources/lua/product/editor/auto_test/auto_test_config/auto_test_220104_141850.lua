AutoTest_220104_141850 = {
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
        action = "SetEntityAttack",
        args = {attack = 999999, name = "p1"}
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 5,
          disableai = false,
          id = 2081211,
          name = "e1",
          pos = 404
        }
      },
      [6] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 202.0,
            [2] = 203.0,
            [3] = 204.0,
            [4] = 205.0,
            [5] = 206.0,
            [6] = 207.0,
            [7] = 208.0,
            [8] = 302.0,
            [9] = 303.0,
            [10] = 304.0,
            [11] = 305.0,
            [12] = 306.0,
            [13] = 307.0,
            [14] = 308.0,
            [15] = 402.0,
            [16] = 403.0,
            [17] = 407.0,
            [18] = 408.0,
            [19] = 502.0,
            [20] = 503.0,
            [21] = 507.0,
            [22] = 508.0,
            [23] = 602.0,
            [24] = 603.0,
            [25] = 607.0,
            [26] = 608.0,
            [27] = 702.0,
            [28] = 703.0,
            [29] = 704.0,
            [30] = 705.0,
            [31] = 706.0,
            [32] = 707.0,
            [33] = 708.0,
            [34] = 802.0,
            [35] = 803.0,
            [36] = 804.0,
            [37] = 805.0,
            [38] = 806.0,
            [39] = 807.0,
            [40] = 808.0
          },
          skillid = 1001711,
          trigger = 102
        }
      },
      [7] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Power",
          attr_select_index = 12,
          expect = 4.0,
          name = "p1",
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
        action = "CheckEntityAttribute",
        args = {
          attr = "Power",
          attr_select_index = 12,
          expect = 5.0,
          name = "p1",
          trigger = 88
        }
      },
      [11] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 104.0,
            [2] = 105.0,
            [3] = 106.0,
            [4] = 204.0,
            [5] = 205.0,
            [6] = 206.0,
            [7] = 304.0,
            [8] = 305.0,
            [9] = 306.0,
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
            [37] = 704.0,
            [38] = 705.0,
            [39] = 706.0,
            [40] = 804.0,
            [41] = 805.0,
            [42] = 806.0,
            [43] = 904.0,
            [44] = 905.0,
            [45] = 906.0
          },
          skillid = 1001721,
          trigger = 102
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
        action = "SetEntityHPPercent",
        args = {name = "e1", percent = 0.0099999997764826}
      },
      [15] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Power",
          attr_select_index = 12,
          expect = 4.0,
          name = "p1",
          trigger = 88
        }
      },
      [16] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0
          },
          pieceType = 1
        }
      },
      [17] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [18] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 106.0,
            [2] = 107.0,
            [3] = 206.0,
            [4] = 207.0,
            [5] = 306.0,
            [6] = 307.0,
            [7] = 401.0,
            [8] = 402.0,
            [9] = 403.0,
            [10] = 404.0,
            [11] = 405.0,
            [12] = 406.0,
            [13] = 407.0,
            [14] = 408.0,
            [15] = 409.0,
            [16] = 501.0,
            [17] = 502.0,
            [18] = 503.0,
            [19] = 504.0,
            [20] = 505.0,
            [21] = 506.0,
            [22] = 507.0,
            [23] = 508.0,
            [24] = 509.0,
            [25] = 606.0,
            [26] = 607.0,
            [27] = 706.0,
            [28] = 707.0,
            [29] = 806.0,
            [30] = 807.0,
            [31] = 906.0,
            [32] = 907.0
          },
          skillid = 1001751,
          trigger = 102
        }
      },
      [19] = {
        action = "CheckMonsterCount",
        args = {
          count = 2,
          monsterid = 2920621,
          trigger = 88
        }
      },
      [20] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [21] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [22] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 304.0,
            [2] = 305.0,
            [3] = 403.0,
            [4] = 404.0,
            [5] = 405.0,
            [6] = 406.0,
            [7] = 503.0,
            [8] = 504.0,
            [9] = 505.0,
            [10] = 506.0,
            [11] = 604.0,
            [12] = 605.0
          },
          skillid = 1001741,
          trigger = 102
        }
      },
      [23] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Power",
          attr_select_index = 12,
          expect = 4.0,
          name = "p1",
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
        action = "SetAllMonstersHPPercent",
        args = {percent = 0.0099999997764826}
      },
      [27] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 503.0,
            [2] = 403.0
          },
          pieceType = 1
        }
      },
      [28] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [29] = {
        action = "CheckMonsterCount",
        args = {
          count = 4,
          monsterid = 2920631,
          trigger = 88
        }
      },
      [30] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 106.0,
            [2] = 206.0,
            [3] = 306.0,
            [4] = 406.0,
            [5] = 501.0,
            [6] = 502.0,
            [7] = 503.0,
            [8] = 504.0,
            [9] = 505.0,
            [10] = 507.0,
            [11] = 508.0,
            [12] = 509.0,
            [13] = 606.0,
            [14] = 706.0,
            [15] = 806.0,
            [16] = 906.0
          },
          skillid = 1001781,
          trigger = 102
        }
      },
      [31] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [32] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "1"
    }
  },
  name = "8-14 不灭",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1400571,
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
