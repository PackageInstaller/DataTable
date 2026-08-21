AutoTest_220120_072126 = {
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
          id = 2100211,
          name = "e1",
          pos = 506
        }
      },
      [5] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 403.0,
            [2] = 404.0,
            [3] = 405.0,
            [4] = 406.0,
            [5] = 503.0,
            [6] = 506.0,
            [7] = 603.0,
            [8] = 606.0,
            [9] = 703.0,
            [10] = 704.0,
            [11] = 705.0,
            [12] = 706.0
          },
          skillid = 1005521,
          trigger = 102
        }
      },
      [6] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 503,
          trapIds = {
            [1] = 60.0
          },
          trigger = 88
        }
      },
      [7] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 403,
          trapIds = {
            [1] = 60.0
          },
          trigger = 88
        }
      },
      [8] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 603,
          trapIds = {
            [1] = 60.0
          },
          trigger = 88
        }
      },
      [9] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 506,
          trapIds = {
            [1] = 60.0
          },
          trigger = 88
        }
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
          skillid = 1005501,
          trigger = 102
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
      name = "新测试用例"
    }
  },
  name = "碎格子跋骷",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1400071,
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
