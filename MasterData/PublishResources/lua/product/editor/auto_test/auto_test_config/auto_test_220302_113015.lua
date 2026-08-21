AutoTest_220302_113015 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [3] = {
        action = "FakeClickAutoFight",
        args = {}
      },
      [4] = {
        action = "WaitGameFsm",
        args = {id = 6}
      },
      [5] = {
        action = "FakeClickAutoFight",
        args = {}
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "纯色棋盘的自动战斗计算性能"
    }
  },
  name = "自动战斗性能测试",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1400411,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600061,
      level = 1,
      name = "p1"
    },
    [3] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1300651,
      level = 1,
      name = "p1"
    },
    [4] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1400911,
      level = 1,
      name = "p1"
    },
    [5] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1400851,
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
