AutoTest_220104_135634 = {
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
          id = 2071214,
          name = "e4",
          pos = 307
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 5,
          disableai = false,
          id = 2071211,
          name = "e1",
          pos = 303
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 5,
          disableai = false,
          id = 2071212,
          name = "e2",
          pos = 703
        }
      },
      [7] = {
        action = "AddMonster",
        args = {
          dir = 5,
          disableai = false,
          id = 2071213,
          name = "e3",
          pos = 707
        }
      },
      [8] = {
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
          skillid = 501068,
          trigger = 102
        }
      },
      [9] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 203.0,
            [2] = 204.0,
            [3] = 205.0,
            [4] = 206.0,
            [5] = 207.0,
            [6] = 208.0,
            [7] = 302.0,
            [8] = 402.0,
            [9] = 502.0,
            [10] = 602.0,
            [11] = 702.0,
            [12] = 802.0
          },
          skillid = 501067,
          trigger = 102
        }
      },
      [10] = {
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
          skillid = 501069,
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
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 307.0,
            [2] = 406.0,
            [3] = 407.0,
            [4] = 408.0,
            [5] = 505.0,
            [6] = 506.0,
            [7] = 507.0,
            [8] = 508.0,
            [9] = 509.0,
            [10] = 606.0,
            [11] = 607.0,
            [12] = 608.0,
            [13] = 707.0
          },
          skillid = 501072,
          trigger = 102
        }
      },
      [14] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 206.0,
            [2] = 305.0,
            [3] = 306.0,
            [4] = 307.0,
            [5] = 404.0,
            [6] = 405.0,
            [7] = 406.0,
            [8] = 407.0,
            [9] = 408.0,
            [10] = 505.0,
            [11] = 506.0,
            [12] = 507.0,
            [13] = 606.0
          },
          skillid = 501062,
          trigger = 102
        }
      },
      [15] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 103.0,
            [2] = 202.0,
            [3] = 203.0,
            [4] = 204.0,
            [5] = 301.0,
            [6] = 302.0,
            [7] = 303.0,
            [8] = 402.0
          },
          skillid = 501070,
          trigger = 102
        }
      },
      [16] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 502.0,
            [2] = 601.0,
            [3] = 602.0,
            [4] = 603.0,
            [5] = 701.0,
            [6] = 702.0,
            [7] = 703.0,
            [8] = 704.0,
            [9] = 802.0,
            [10] = 803.0
          },
          skillid = 501071,
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
        action = "SetAllMonstersHPPercent",
        args = {percent = 0.5}
      },
      [20] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "<",
          name = "e1",
          trigger = 88
        }
      },
      [21] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "<",
          name = "e2",
          trigger = 88
        }
      },
      [22] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "<",
          name = "e3",
          trigger = 88
        }
      },
      [23] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [24] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新测试用例"
    }
  },
  name = "7-14 舒摩尔",
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
