AutoTest_221103_150203 = {
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
        args = {buffID = 88840039, name = "e1"}
      },
      [5] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "AttackPercentage",
          expect = 0.10000000149012,
          name = "e1",
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
        action = "CheckEntityAttribute",
        args = {
          attr = "AttackPercentage",
          expect = 0.20000000298023,
          name = "e1",
          trigger = 88
        }
      },
      [9] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [11] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "AttackPercentage",
          expect = 0.30000001192093,
          name = "e1",
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
      name = "怪物每回合攻击力增加10%，可叠加。"
    }
  },
  name = "40039绝望末日",
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
      args = {levelID = 1, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
