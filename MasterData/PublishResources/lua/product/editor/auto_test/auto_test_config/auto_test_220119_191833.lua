AutoTest_220119_191833 = {
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
        action = "CheckEntityAttribute",
        args = {
          attr = "Power",
          attr_select_index = 12,
          expect = 5.0,
          name = "p1",
          trigger = 0
        }
      },
      [5] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Power",
          attr_select_index = 12,
          expect = 4.0,
          name = "p2",
          trigger = 0
        }
      },
      [6] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Power",
          attr_select_index = 12,
          expect = 3.0,
          name = "p3",
          trigger = 0
        }
      },
      [7] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Ready",
          attr_select_index = 11,
          expect = 1.0,
          name = "p4",
          trigger = 0
        }
      },
      [8] = {
        action = "AddMonster",
        args = {
          dir = 5,
          disableai = false,
          id = 2080713,
          name = "e1",
          pos = 507
        }
      },
      [9] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0
          },
          pieceType = 1
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [11] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Power",
          attr_select_index = 12,
          expect = 3.0,
          name = "p1",
          trigger = 88
        }
      },
      [12] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Power",
          attr_select_index = 12,
          expect = 2.0,
          name = "p2",
          trigger = 88
        }
      },
      [13] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Power",
          attr_select_index = 12,
          expect = 1.0,
          name = "p3",
          trigger = 88
        }
      },
      [14] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Power",
          attr_select_index = 12,
          expect = 4.0,
          name = "p4",
          trigger = 88
        }
      },
      [15] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [16] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新测试用例"
    }
  },
  name = "能量夺取消悸",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1500901,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600061,
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
      id = 1501321,
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
