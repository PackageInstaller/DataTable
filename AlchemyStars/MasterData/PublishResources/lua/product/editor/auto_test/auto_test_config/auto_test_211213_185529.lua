AutoTest_211213_185529 = {
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
        args = {name = "team", name_select_index = 0}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 303
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 803
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 707
        }
      },
      [7] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 2050824,
          name = "e4",
          pos = 306
        }
      },
      [8] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [9] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e2",
          trigger = 88
        }
      },
      [10] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e3",
          trigger = 88
        }
      },
      [11] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e4",
          trigger = 88
        }
      },
      [12] = {
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 304,
          trigger = 88
        }
      },
      [13] = {
        action = "CheckEntityPos",
        args = {
          name = "e2",
          pos = 804,
          trigger = 88
        }
      },
      [14] = {
        action = "CheckEntityPos",
        args = {
          name = "e3",
          pos = 708,
          trigger = 88
        }
      },
      [15] = {
        action = "CheckEntityPos",
        args = {
          name = "e4",
          pos = 306,
          trigger = 88
        }
      },
      [16] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 503.0
          }
        }
      },
      [17] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "波娜瑟主动技"
    }
  },
  name = "波娜瑟主动技",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1501131,
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
