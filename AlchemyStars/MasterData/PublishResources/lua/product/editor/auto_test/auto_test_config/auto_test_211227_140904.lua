AutoTest_211227_140904 = {
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
          id = 2010611,
          name = "e1",
          pos = 408
        }
      },
      [4] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 301.0,
            [2] = 302.0,
            [3] = 303.0,
            [4] = 304.0,
            [5] = 305.0,
            [6] = 306.0,
            [7] = 307.0,
            [8] = 401.0,
            [9] = 402.0,
            [10] = 403.0,
            [11] = 404.0,
            [12] = 405.0,
            [13] = 406.0,
            [14] = 407.0,
            [15] = 501.0,
            [16] = 502.0,
            [17] = 503.0,
            [18] = 504.0,
            [19] = 505.0,
            [20] = 506.0,
            [21] = 507.0,
            [22] = 601.0,
            [23] = 602.0,
            [24] = 603.0,
            [25] = 604.0,
            [26] = 605.0,
            [27] = 606.0,
            [28] = 607.0
          },
          skillid = 500079,
          trigger = 102
        }
      },
      [5] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "team",
          trigger = 88
        }
      },
      [8] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 402.0,
            [3] = 302.0
          },
          pieceType = 1
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "卡拉肯boss 技能1+技能2（检验不了伤害范围）"
    }
  },
  name = "1-9卡拉肯",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600061,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1401021,
      level = 1,
      name = "p2"
    },
    [3] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1400451,
      level = 1,
      name = "p3"
    },
    [4] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1500901,
      level = 1,
      name = "p4"
    },
    [5] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1601231,
      level = 1,
      name = "p5"
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
