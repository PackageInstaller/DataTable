AutoTest_220217_114053 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 603}
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 608
        }
      },
      [4] = {
        action = "SetEveryPieceType",
        args = {
          pieceTypeArray = "0,0,1,1,1,1,1,0,0|0,1,1,1,1,1,1,1,0|1,1,1,1,1,1,1,1,1|1,4,2,1,1,1,1,1,1|1,2,2,2,2,1,1,1,1|1,4,0,2,1,1,1,1,1|1,2,2,2,2,2,1,2,1|0,2,2,1,4,2,2,1,0|0,0,1,4,2,4,4,0,0"
        }
      },
      [5] = {
        action = "FakeClickAutoFight",
        args = {}
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 28}
      },
      [7] = {
        action = "FakeClickAutoFight",
        args = {}
      },
      name = "期望连线进入极光时刻"
    }
  },
  name = "连线漏格子",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600261,
      level = 1,
      name = "p3"
    },
    [2] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1601121,
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
