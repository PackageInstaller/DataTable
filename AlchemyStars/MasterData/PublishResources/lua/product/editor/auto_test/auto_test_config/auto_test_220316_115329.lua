AutoTest_220316_115329 = {
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
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [4] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "team"}
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 5,
          disableai = false,
          id = 512200111,
          name = "e1",
          pos = 508
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 5,
          disableai = false,
          id = 512200112,
          name = "e2",
          pos = 208
        }
      },
      [7] = {
        action = "AddMonster",
        args = {
          dir = 5,
          disableai = false,
          id = 512200113,
          name = "e3",
          pos = 708
        }
      },
      [8] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 11501,
          name = "j1",
          pos = 406
        }
      },
      [9] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 11902,
          name = "j2",
          pos = 406
        }
      },
      [10] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 11501,
          name = "j3",
          pos = 606
        }
      },
      [11] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 11902,
          name = "j4",
          pos = 606
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
            [1] = 501.0,
            [2] = 502.0,
            [3] = 601.0,
            [4] = 602.0,
            [5] = 701.0,
            [6] = 702.0
          },
          skillid = 50022401,
          trigger = 102
        }
      },
      [15] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 206.0,
            [2] = 207.0,
            [3] = 301.0,
            [4] = 302.0,
            [5] = 303.0,
            [6] = 304.0,
            [7] = 306.0,
            [8] = 307.0,
            [9] = 401.0,
            [10] = 402.0,
            [11] = 403.0,
            [12] = 404.0,
            [13] = 405.0,
            [14] = 406.0,
            [15] = 505.0,
            [16] = 506.0,
            [17] = 601.0,
            [18] = 602.0,
            [19] = 701.0,
            [20] = 702.0,
            [21] = 703.0,
            [22] = 704.0,
            [23] = 706.0,
            [24] = 707.0,
            [25] = 803.0,
            [26] = 804.0,
            [27] = 806.0,
            [28] = 807.0
          },
          skillid = 290039102,
          trigger = 102
        }
      },
      [16] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 503,
          trapIds = {
            [1] = 11901.0
          },
          trigger = 88
        }
      },
      [17] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e1",
          trigger = 88
        }
      },
      [18] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e2",
          trigger = 88
        }
      },
      [19] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e3",
          trigger = 88
        }
      },
      [20] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [21] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [22] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [23] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [24] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 403.0
          },
          skillid = 580143,
          trigger = 102
        }
      },
      [25] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 803.0,
            [2] = 804.0,
            [3] = 805.0,
            [4] = 903.0,
            [5] = 904.0,
            [6] = 905.0
          },
          skillid = 50022401,
          trigger = 102
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
      [28] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 204.0,
            [2] = 307.0,
            [3] = 403.0,
            [4] = 407.0,
            [5] = 803.0,
            [6] = 905.0
          },
          skillid = 290039101,
          trigger = 102
        }
      },
      [29] = {
        action = "CheckEntityPos",
        args = {
          name = "p1",
          pos = 501,
          trigger = 88
        }
      },
      [30] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [31] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新测试用例"
    }
  },
  name = "合约-鲍林格",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1500331,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
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
