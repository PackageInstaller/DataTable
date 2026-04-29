AutoTest_211217_154849 = {
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
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 17,
          name = "j1",
          pos = 505
        }
      },
      [6] = {
        action = "FakeCastSkill",
        args = {
          name = "p4",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "FakeCastSkill",
        args = {
          name = "p2",
          pickUpPos = {
            [1] = 404.0
          }
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [12] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 2030313,
          name = "e1",
          pos = 407
        }
      },
      [13] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 5100111,
          name = "e2",
          pos = 307
        }
      },
      [14] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 405,
          trapIds = {
            [1] = 17.0
          },
          trigger = 88
        }
      },
      [15] = {
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 405,
          trigger = 88
        }
      },
      [16] = {
        action = "CheckEntityPos",
        args = {
          name = "e2",
          pos = 206,
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
      name = "深渊格子（洗版，精华，牵引）不影响深渊格子，飞行怪可在深渊格子，普通不可"
    }
  },
  name = "深渊机关",
  petList = {
    [1] = {
      awakening = 1,
      equiplv = 1,
      grade = 1,
      id = 1600251,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 1,
      equiplv = 1,
      grade = 1,
      id = 1601151,
      level = 1,
      name = "p2"
    },
    [3] = {
      awakening = 1,
      equiplv = 1,
      grade = 1,
      id = 1600261,
      level = 1,
      name = "p4"
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
