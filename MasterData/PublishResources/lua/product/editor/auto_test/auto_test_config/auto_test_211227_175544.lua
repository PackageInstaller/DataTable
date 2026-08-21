AutoTest_211227_175544 = {
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
        action = "AddMonster",
        args = {
          dir = 5,
          disableai = false,
          id = 2011211,
          name = "e1",
          pos = 508
        }
      },
      [4] = {
        action = "CheckEntityPos",
        args = {
          name = "p1",
          pos = 501,
          trigger = 88
        }
      },
      [5] = {
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
          skillid = 500631,
          trigger = 102
        }
      },
      [6] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 501.0,
            [2] = 402.0
          },
          pieceType = 1
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "CheckEntityPos",
        args = {
          name = "p1",
          pos = 802,
          trigger = 88
        }
      },
      [11] = {
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 205,
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
        action = "FakeInputDoubleClick",
        args = {}
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "出场击退+技能1+落雷钻地（范围查不到）"
    }
  },
  name = "1-16麦格芬",
  petList = {
    [1] = {
      awakening = 6,
      equiplv = 1,
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
