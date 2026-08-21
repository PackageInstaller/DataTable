AutoTest_220125_113748 = {
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
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 5,
          disableai = false,
          id = 2100911,
          name = "e1",
          pos = 506
        }
      },
      [6] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 304.0,
            [2] = 404.0,
            [3] = 502.0,
            [4] = 503.0,
            [5] = 505.0,
            [6] = 506.0,
            [7] = 604.0,
            [8] = 704.0
          },
          skillid = 1001401,
          trigger = 102
        }
      },
      [7] = {
        action = "CheckBuffLogic",
        args = {
          exist = true,
          logic = "ATBuffSealed",
          logic_select_index = 15,
          name = "p2",
          trigger = 88
        }
      },
      [8] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Ready",
          attr_select_index = 11,
          expect = 0.0,
          name = "p2",
          trigger = 88
        }
      },
      [9] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新测试用例"
    }
  },
  name = "诅咒怪诅魍",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1400541,
      level = 1,
      name = "p2"
    },
    [2] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600061,
      level = 1,
      name = "p2"
    },
    [3] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600021,
      level = 1,
      name = "p3"
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
