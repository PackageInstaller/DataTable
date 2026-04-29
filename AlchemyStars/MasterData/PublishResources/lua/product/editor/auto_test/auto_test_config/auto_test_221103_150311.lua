AutoTest_221103_150311 = {
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
          id = 5107011,
          name = "e1",
          pos = 503
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
        action = "CheckEntityAttribute",
        args = {
          attr = "AttackPercentage",
          expect = -0.20000000298023,
          name = "p1",
          trigger = 102
        }
      },
      [7] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [9] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "AttackPercentage",
          expect = -0.5,
          name = "p1",
          trigger = 102
        }
      },
      [10] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "格茨德开局进入狂暴状态；攻击玩家会额外降低玩家攻击力。"
    }
  },
  name = "40017背叛束缚",
  petList = {
    [1] = {
      awakening = 6,
      equiplv = 10,
      grade = 3,
      id = 1600061,
      level = 80,
      name = "p1"
    },
    [2] = {
      awakening = 6,
      equiplv = 10,
      grade = 3,
      id = 1600251,
      level = 80,
      name = "p1"
    },
    [3] = {
      awakening = 6,
      equiplv = 10,
      grade = 3,
      id = 1600961,
      level = 80,
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
