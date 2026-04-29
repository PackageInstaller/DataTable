AutoTest_220302_171745 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 505}
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 508
        }
      },
      [4] = {
        action = "SetEveryPieceType",
        args = {
          pieceTypeArray = "0,0,2,2,1,4,2,0,0|0,3,3,3,1,4,2,3,0|3,3,1,1,2,1,1,2,2|3,3,1,2,1,2,1,2,2|1,1,1,1,0,1,1,1,1|3,3,1,2,1,2,1,2,2|3,3,1,1,2,1,1,2,2|0,3,3,3,1,4,2,3,0|0,0,2,2,1,4,2,0,0"
        }
      },
      [5] = {
        action = "FakeClickAutoFight",
        args = {}
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 6}
      },
      [7] = {
        action = "FakeClickAutoFight",
        args = {}
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "测试颜色相对集中的格子卡顿"
    }
  },
  name = "自动战斗性能测试3",
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
