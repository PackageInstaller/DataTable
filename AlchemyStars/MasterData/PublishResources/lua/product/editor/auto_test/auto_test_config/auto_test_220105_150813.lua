AutoTest_220105_150813 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetEveryPieceType",
        args = {
          pieceTypeArray = "0,0,1,1,4,4,4,0,0|0,2,2,1,4,3,4,4,0|1,2,1,3,4,3,2,4,4|1,2,4,4,4,1,1,2,4|1,0,4,4,4,4,4,4,4|1,4,4,4,4,1,1,2,4|1,1,1,3,4,3,2,4,4|0,1,1,1,4,3,4,4,0|0,0,1,1,4,4,4,0,0"
        }
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 408
        }
      },
      [4] = {
        action = "SetAllMonstersHP",
        args = {value = 999999}
      },
      [5] = {
        action = "FakeClickAutoFight",
        args = {}
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 7}
      },
      [7] = {
        action = "FakeClickAutoFight",
        args = {}
      },
      name = "测试指定棋盘颜色怪物位置，自动战斗连线结果"
    }
  },
  name = "划线布局-雷队",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600891,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1500121,
      level = 1,
      name = "p2"
    },
    [3] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600381,
      level = 1,
      name = "p3"
    },
    [4] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1401011,
      level = 1,
      name = "p4"
    },
    [5] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1401021,
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
