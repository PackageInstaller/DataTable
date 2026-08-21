AutoTest_220114_164714 = {
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
        action = "CheckGridTrap",
        args = {
          exist = false,
          pos = 401,
          trapIds = {
            [1] = 3200.0
          },
          trigger = 88
        }
      },
      [4] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [6] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 401,
          trapIds = {
            [1] = 3200.0
          },
          trigger = 88
        }
      },
      [7] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 501,
          trapIds = {
            [1] = 3200.0
          },
          trigger = 88
        }
      },
      [8] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 601,
          trapIds = {
            [1] = 3200.0
          },
          trigger = 88
        }
      },
      [9] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 106,
          trapIds = {
            [1] = 3202.0
          },
          trigger = 88
        }
      },
      [10] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 104,
          trapIds = {
            [1] = 3202.0
          },
          trigger = 88
        }
      },
      [11] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 105,
          trapIds = {
            [1] = 3202.0
          },
          trigger = 88
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
      name = "第二波机关出现"
    }
  },
  name = "35040-s2-5 关卡布局",
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
      args = {levelID = 1000214, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
