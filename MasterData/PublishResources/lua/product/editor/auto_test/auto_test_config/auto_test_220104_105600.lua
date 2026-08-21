AutoTest_220104_105600 = {
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
          id = 2061211,
          name = "e1",
          pos = 508
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
            [1] = 107.0,
            [2] = 206.0,
            [3] = 207.0,
            [4] = 305.0,
            [5] = 306.0,
            [6] = 307.0,
            [7] = 404.0,
            [8] = 405.0,
            [9] = 406.0,
            [10] = 407.0,
            [11] = 504.0,
            [12] = 505.0,
            [13] = 506.0,
            [14] = 507.0,
            [15] = 604.0,
            [16] = 605.0,
            [17] = 606.0,
            [18] = 607.0,
            [19] = 705.0,
            [20] = 706.0,
            [21] = 707.0,
            [22] = 806.0,
            [23] = 807.0,
            [24] = 907.0
          },
          skillid = 501092,
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
        action = "FakeInputDoubleClick",
        args = {}
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [11] = {
        action = "CheckEntityPos",
        args = {
          name = "p1",
          pos = 701,
          trigger = 88
        }
      },
      [12] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "team",
          trigger = 88
        }
      },
      [13] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 501.0,
            [2] = 601.0
          },
          pieceType = 1
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = " "
    }
  },
  name = "6-14麦格芬斯摩",
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
