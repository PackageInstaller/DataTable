AutoTest_220104_110617 = {
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
          id = 2070611,
          name = "e1",
          pos = 408
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 5,
          disableai = true,
          id = 2070612,
          name = "e2",
          pos = 703
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 5,
          disableai = true,
          id = 2070613,
          name = "e3",
          pos = 707
        }
      },
      [7] = {
        action = "AddMonster",
        args = {
          dir = 5,
          disableai = true,
          id = 2070614,
          name = "e4",
          pos = 505
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
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 104,
          trigger = 88
        }
      },
      [11] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 303.0,
            [2] = 304.0,
            [3] = 305.0,
            [4] = 306.0,
            [5] = 403.0,
            [6] = 404.0,
            [7] = 405.0,
            [8] = 406.0,
            [9] = 503.0,
            [10] = 504.0,
            [11] = 505.0,
            [12] = 506.0,
            [13] = 603.0,
            [14] = 604.0,
            [15] = 605.0,
            [16] = 606.0,
            [17] = 703.0,
            [18] = 704.0,
            [19] = 705.0,
            [20] = 706.0,
            [21] = 803.0,
            [22] = 804.0,
            [23] = 805.0,
            [24] = 806.0,
            [25] = 903.0,
            [26] = 904.0,
            [27] = 905.0,
            [28] = 906.0
          },
          skillid = 590043303,
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
        args = {name = "e2", percent = 0.40000000596046}
      },
      [15] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e2",
          trigger = 88
        }
      },
      [16] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 702.0
          },
          pieceType = 1
        }
      },
      [17] = {
        action = "WaitGameFsm",
        args = {id = 5}
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
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "team",
          trigger = 88
        }
      },
      [21] = {
        action = "CheckMonsterCount",
        args = {
          count = 3,
          monsterid = 2000433,
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
      name = "爆炸不了"
    }
  },
  name = "7-7 玛拉索尔",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 0,
      grade = 0,
      id = 1600961,
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
