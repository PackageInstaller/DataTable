AutoTest_220106_140641 = {
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
        action = "AddTrap",
        args = {
          dir = 3,
          disableai = true,
          id = 3400,
          name = "j1",
          pos = 5
        }
      },
      [5] = {
        action = "AddTrap",
        args = {
          dir = 5,
          disableai = true,
          id = 3401,
          name = "j2",
          pos = 905
        }
      },
      [6] = {
        action = "AddTrap",
        args = {
          dir = 5,
          disableai = true,
          id = 3408,
          name = "j3",
          pos = 309
        }
      },
      [7] = {
        action = "AddTrap",
        args = {
          dir = 5,
          disableai = true,
          id = 3409,
          name = "j4",
          pos = 302
        }
      },
      [8] = {
        action = "AddTrap",
        args = {
          dir = 5,
          disableai = true,
          id = 3408,
          name = "j5",
          pos = 709
        }
      },
      [9] = {
        action = "AddTrap",
        args = {
          dir = 5,
          disableai = true,
          id = 3409,
          name = "j6",
          pos = 702
        }
      },
      [10] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 4010611,
          name = "e1",
          pos = 506
        }
      },
      [11] = {
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 504,
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
            [1] = 502.0,
            [2] = 501.0,
            [3] = 601.0,
            [4] = 602.0,
            [5] = 603.0,
            [6] = 503.0,
            [7] = 504.0,
            [8] = 404.0,
            [9] = 304.0,
            [10] = 204.0,
            [11] = 104.0,
            [12] = 105.0,
            [13] = 205.0,
            [14] = 305.0,
            [15] = 405.0,
            [16] = 505.0,
            [17] = 605.0,
            [18] = 604.0,
            [19] = 704.0,
            [20] = 804.0,
            [21] = 904.0,
            [22] = 905.0,
            [23] = 805.0,
            [24] = 705.0,
            [25] = 606.0,
            [26] = 607.0,
            [27] = 608.0,
            [28] = 609.0,
            [29] = 509.0,
            [30] = 508.0,
            [31] = 507.0,
            [32] = 506.0
          },
          skillid = 500172,
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
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 105.0,
            [2] = 106.0,
            [3] = 205.0,
            [4] = 206.0
          },
          skillid = 500194,
          trigger = 102
        }
      },
      [18] = {
        action = "CheckMonsterCount",
        args = {
          count = 1,
          monsterid = 4010613,
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
          skillid = 500170,
          trigger = 102
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
  name = "番外1-6幽灵",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
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
