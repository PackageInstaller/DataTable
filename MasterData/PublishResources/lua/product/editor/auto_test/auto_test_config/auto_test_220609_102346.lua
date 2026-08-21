AutoTest_220609_102346 = {
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
          attr = "LegendPower",
          expect = 1.0,
          name = "p1",
          trigger = 0
        }
      },
      [4] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [5] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Ready",
          expect = 1.0,
          name = "p1",
          trigger = 88
        }
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
        action = "CheckEntityAttribute",
        args = {
          attr = "LegendPower",
          expect = 5.0,
          name = "p1",
          trigger = 88
        }
      },
      [13] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [15] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "LegendPower",
          expect = 5.0,
          name = "p1",
          trigger = 88
        }
      },
      [16] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [17] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [18] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 505,
          trapIds = {
            [1] = 1.6014511E7
          },
          trigger = 88
        }
      },
      [19] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "LegendPower",
          expect = 3.0,
          name = "p1",
          trigger = 88
        }
      },
      [20] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 505.0
          }
        }
      },
      [21] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [22] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "LegendPower",
          expect = 2.0,
          name = "p1",
          trigger = 88
        }
      },
      [23] = {
        action = "CheckEntityPos",
        args = {
          name = "p1",
          pos = 505,
          trigger = 88
        }
      },
      [24] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 505.0
          }
        }
      },
      [25] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "施放消耗2点能量，每回合开始获得1，最大5；在任意空格子插一把刀，或是点选一把刀然后位移到该格子上，立即获得1点能量"
    }
  },
  name = "雨森主动技",
  petList = {
    [1] = {
      affinity = 0,
      awakening = 0,
      equiplv = 0,
      grade = 0,
      id = 1601451,
      level = 1,
      name = "p1"
    }
  },
  setup = {
    [1] = {
      args = {levelID = 1, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
