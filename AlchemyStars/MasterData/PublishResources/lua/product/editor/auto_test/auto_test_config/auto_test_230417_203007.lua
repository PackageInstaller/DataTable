AutoTest_230417_203007 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "team"}
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 2905101,
          name = "e1",
          pos = 305
        }
      },
      [4] = {
        action = "CheckTrapExist",
        args = {
          exist = true,
          trapIds = {
            [1] = 2905111.0
          },
          trigger = 88
        },
        exist = true
      },
      [5] = {
        action = "CheckEntityBodyAreaCount",
        args = {
          expect = 1,
          name = "e1",
          trigger = 88
        }
      },
      [6] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 503,
          trapIds = {
            [1] = 2905111.0
          },
          trigger = 88
        }
      },
      [7] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 603,
          trapIds = {
            [1] = 2905111.0
          },
          trigger = 88
        }
      },
      [8] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 703,
          trapIds = {
            [1] = 2905112.0
          },
          trigger = 88
        }
      },
      [9] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 404,
          trapIds = {
            [1] = 2905112.0
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
        action = "FakeInputDoubleClick",
        args = {}
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [14] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [16] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [17] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新测试用例"
    }
  },
  name = "15-9钻探者",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
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
