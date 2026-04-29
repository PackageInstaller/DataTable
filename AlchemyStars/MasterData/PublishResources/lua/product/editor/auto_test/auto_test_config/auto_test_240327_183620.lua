AutoTest_240327_183620 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetEntityPosition",
        args = {name = "p1", pos = 502}
      },
      [3] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 504,
          trapIds = {
            [1] = 2803501.0
          },
          trigger = 88
        }
      },
      [4] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 605,
          trapIds = {
            [1] = 2803501.0
          },
          trigger = 88
        }
      },
      [5] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 604,
          trapIds = {
            [1] = 2803501.0
          },
          trigger = 88
        }
      },
      [6] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 503,
          trapIds = {
            [1] = 2803501.0
          },
          trigger = 88
        }
      },
      [7] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 404,
          trapIds = {
            [1] = 2803501.0
          },
          trigger = 88
        }
      },
      [8] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 505,
          trapIds = {
            [1] = 2803501.0
          },
          trigger = 88
        }
      },
      [9] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          },
          skillIndex = 1
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "主动技强化：最近的5个水格子"
    }
  },
  name = "丽蓓卡突破6",
  petList = {
    [1] = {
      awakening = 6,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 0,
      id = 1602141,
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
