AutoTest_220223_123552 = {
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
          id = 2100212,
          name = "e1",
          pos = 501
        }
      },
      [5] = {
        action = "FakeCastSkill",
        args = {
          name = "p2",
          pickUpPos = {
            [1] = 103.0
          }
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "FakeCastSkill",
        args = {
          name = "p3",
          pickUpPos = {
            [1] = 104.0
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
          name = "p1",
          pickUpPos = {
            [1] = 501.0
          }
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [12] = {
        action = "FakeCastSkill",
        args = {
          name = "p4",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [14] = {
        action = "FakeCastSkill",
        args = {
          name = "p5",
          pickUpPos = {
            [1] = 501.0
          }
        }
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [16] = {
        action = "CheckUIPetLayerCount",
        args = {
          expect = 2,
          name = "p1",
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
      name = "被动强化:充能保留一半层数(剩余层数向下取整)"
    }
  },
  name = "康纳觉醒3",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1601341,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1300461,
      level = 1,
      name = "p2"
    },
    [3] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1601331,
      level = 1,
      name = "p3"
    },
    [4] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1501361,
      level = 1,
      name = "p4"
    },
    [5] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1401371,
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
