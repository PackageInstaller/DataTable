AutoTest_211228_143352 = {
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
          id = 2030611,
          name = "e1",
          pos = 507
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 5,
          disableai = false,
          id = 2030612,
          name = "e2",
          pos = 408
        }
      },
      [6] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 105.0,
            [2] = 205.0,
            [3] = 305.0,
            [4] = 405.0,
            [5] = 501.0,
            [6] = 502.0,
            [7] = 503.0,
            [8] = 504.0,
            [9] = 506.0,
            [10] = 507.0,
            [11] = 508.0,
            [12] = 509.0,
            [13] = 605.0,
            [14] = 705.0,
            [15] = 805.0,
            [16] = 905.0
          },
          skillid = 500222,
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
        action = "SetEntityHPPercent",
        args = {name = "e1", percent = 0.80000001192093}
      },
      [12] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "<",
          name = "e1",
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
      [15] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 105.0,
            [2] = 106.0,
            [3] = 205.0,
            [4] = 206.0,
            [5] = 303.0,
            [6] = 304.0,
            [7] = 307.0,
            [8] = 308.0,
            [9] = 403.0,
            [10] = 404.0,
            [11] = 407.0,
            [12] = 408.0,
            [13] = 505.0,
            [14] = 506.0,
            [15] = 605.0,
            [16] = 606.0
          },
          skillid = 500220,
          trigger = 102
        }
      },
      [16] = {
        action = "CheckEntityPos",
        args = {
          name = "p1",
          pos = 402,
          trigger = 88
        }
      },
      [17] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 403.0
          },
          pieceType = 1
        }
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
          logic = "ATBuffStun",
          logic_select_index = 10,
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
  name = "3-7范尼/菲莱克斯",
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
