AutoTest_221102_141231 = {
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
          pos = 305
        }
      },
      [4] = {
        action = "AddBuffToEntity",
        args = {buffID = 100001, name = "e1"}
      },
      [5] = {
        action = "AddBuffToEntity",
        args = {buffID = 100601, name = "e1"}
      },
      [6] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Ready",
          expect = 1.0,
          name = "p1",
          trigger = 0
        }
      },
      [7] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Ready",
          expect = 1.0,
          name = "p2",
          trigger = 0
        }
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
        action = "CheckEntityBuff",
        args = {
          buffId = 100001,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [11] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 100601,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [12] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Power",
          expect = 1.0,
          name = "p1",
          trigger = 0
        }
      },
      [13] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Power",
          expect = 1.0,
          name = "p2",
          trigger = 0
        }
      },
      [14] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "清醒状态下，增加随机光灵的主动技冷却时间2回合，重复2次"
    }
  },
  name = "1006 技能迟滞 2个光灵",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1300591,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1300531,
      level = 1,
      name = "p2"
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
