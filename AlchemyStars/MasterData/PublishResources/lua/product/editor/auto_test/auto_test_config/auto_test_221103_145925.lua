AutoTest_221103_145925 = {
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
          disableai = false,
          id = 5100111,
          name = "e1",
          pos = 503
        }
      },
      [4] = {
        action = "AddBuffToEntity",
        args = {buffID = 88841003, name = "e1"}
      },
      [5] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "AttackPercentage",
          expect = 0.050000000745058,
          name = "e1",
          trigger = 102
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
        action = "CheckEntityAttribute",
        args = {
          attr = "AttackPercentage",
          expect = 0.10000000149012,
          name = "e1",
          trigger = 0
        }
      },
      [11] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [13] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "AttackPercentage",
          expect = 0.15000000596046,
          name = "e1",
          trigger = 0
        }
      },
      name = "怪物每回合攻击力增加5%，可叠加。"
    }
  },
  name = "40003绝望尽头",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1500211,
      level = 1,
      name = "p2"
    },
    [2] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1601481,
      level = 80,
      name = "p1"
    }
  },
  remotePet = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1400071,
      level = 1,
      name = "r1"
    }
  },
  setup = {
    [1] = {
      args = {levelID = 1, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
