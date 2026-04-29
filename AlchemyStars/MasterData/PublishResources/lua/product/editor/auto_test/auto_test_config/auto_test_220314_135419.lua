AutoTest_220314_135419 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 403}
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 5,
          disableai = false,
          id = 512202111,
          name = "e1",
          pos = 307
        }
      },
      [4] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "team"}
      },
      [5] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 503,
          trapIds = {
            [1] = 2810521.0
          },
          trigger = 88
        }
      },
      [6] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 605,
          trapIds = {
            [1] = 2810521.0
          },
          trigger = 88
        }
      },
      [7] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "p1",
          trigger = 88
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
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 103.0,
            [2] = 104.0,
            [3] = 105.0,
            [4] = 106.0,
            [5] = 107.0,
            [6] = 203.0,
            [7] = 204.0,
            [8] = 205.0,
            [9] = 206.0,
            [10] = 207.0,
            [11] = 303.0,
            [12] = 304.0,
            [13] = 306.0,
            [14] = 307.0,
            [15] = 403.0,
            [16] = 404.0,
            [17] = 405.0,
            [18] = 406.0,
            [19] = 407.0,
            [20] = 503.0,
            [21] = 504.0,
            [22] = 505.0,
            [23] = 506.0,
            [24] = 507.0
          },
          skillid = 290180101,
          trigger = 102
        }
      },
      [11] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "team",
          trigger = 4
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
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 306,
          trapIds = {
            [1] = 2810521.0
          },
          trigger = 88
        }
      },
      [15] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 707,
          trapIds = {
            [1] = 2810521.0
          },
          trigger = 88
        }
      },
      [16] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 103.0,
            [2] = 104.0,
            [3] = 105.0,
            [4] = 106.0,
            [5] = 107.0,
            [6] = 203.0,
            [7] = 204.0,
            [8] = 206.0,
            [9] = 207.0,
            [10] = 303.0,
            [11] = 304.0,
            [12] = 305.0,
            [13] = 306.0,
            [14] = 307.0,
            [15] = 403.0,
            [16] = 404.0,
            [17] = 405.0,
            [18] = 406.0,
            [19] = 407.0
          },
          skillid = 290180301,
          trigger = 102
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
      name = "橙"
    }
  },
  name = "橙",
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
