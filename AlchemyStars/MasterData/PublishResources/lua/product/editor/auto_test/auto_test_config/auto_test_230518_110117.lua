AutoTest_230518_110117 = {
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
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 507
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
        action = "FakeInputDoubleClick",
        args = {}
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
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
        action = "FakeCastSkill",
        args = {
          name = "p2",
          pickUpPos = {
            [1] = 504.0
          },
          skillIndex = 0
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [12] = {
        action = "FakeCastSkill",
        args = {
          name = "p3",
          pickUpPos = {
            [1] = 305.0
          },
          skillIndex = 1
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [14] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [15] = {
        action = "FakeCastFeatureScanTrap",
        args = {chooseIndex = 2}
      },
      [16] = {
        action = "WaitTime",
        args = {timeMs = 5000}
      },
      [17] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 501.0
          },
          skillIndex = 1
        }
      },
      [18] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [19] = {
        action = "FakeCastFeatureScanTrap",
        args = {chooseIndex = 1}
      },
      [20] = {
        action = "WaitTime",
        args = {timeMs = 3000}
      },
      [21] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 205.0
          },
          skillIndex = 1
        }
      },
      [22] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [23] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 501,
          trapIds = {
            [1] = 2236.0
          },
          trigger = 0
        }
      },
      [24] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 205,
          trapIds = {
            [1] = 621.0
          },
          trigger = 0
        }
      },
      [25] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "获得新模块：可以复制部分雷属性光灵召唤的机关"
    }
  },
  name = "阿克西娅觉醒Ⅲ",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 3,
      id = 1601751,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 0,
      id = 1300581,
      level = 1,
      name = "p2"
    },
    [3] = {
      awakening = 6,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 0,
      id = 1601991,
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
