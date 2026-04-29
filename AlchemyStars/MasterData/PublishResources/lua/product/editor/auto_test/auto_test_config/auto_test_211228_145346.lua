AutoTest_211228_145346 = {
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
          id = 2031211,
          name = "e1",
          pos = 505
        }
      },
      [5] = {
        action = "AddTrap",
        args = {
          dir = 5,
          disableai = true,
          id = 3302,
          name = "j1",
          pos = 806
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
          skillid = 590242,
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
            [1] = 2.0
          },
          trigger = 88
        },
        exist = true
      },
      [10] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [12] = {
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 408,
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
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 403,
          trigger = 88
        }
      },
      [16] = {
        action = "CheckBuffLogic",
        args = {
          exist = true,
          logic = "ATBuffStun",
          logic_select_index = 10,
          name = "team",
          trigger = 88
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
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 401.0,
            [2] = 402.0,
            [3] = 501.0,
            [4] = 502.0
          },
          skillid = 590248,
          trigger = 102
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
      name = "新测试用例"
    }
  },
  name = "3-13塔巴德",
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
