AutoTest_220725_151904 = {
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
        action = "CheckEntityAttribute",
        args = {
          attr = "Ready",
          expect = 1.0,
          name = "p1",
          trigger = 88
        }
      },
      [4] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 405.0
          }
        }
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
        action = "CheckEntityAttribute",
        args = {
          attr = "Ready",
          expect = 1.0,
          name = "p1",
          trigger = 0
        }
      },
      [15] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [16] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "突3：先制攻击 突6：CD-1"
    }
  },
  name = "莱因哈特突3突6",
  petList = {
    [1] = {
      awakening = 6,
      equiplv = 1,
      grade = 3,
      id = 1601531,
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
