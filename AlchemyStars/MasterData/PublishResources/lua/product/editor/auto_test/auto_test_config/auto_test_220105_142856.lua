AutoTest_220105_142856 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetEveryPieceType",
        args = {
          pieceTypeArray = "0,0,1,1,1,1,2,0,0|0,2,2,1,1,2,2,2,0|1,2,2,1,2,2,1,1,2|2,2,2,2,1,1,1,2,2|1,0,1,2,2,2,2,1,1|2,2,2,2,1,1,1,2,2|1,2,2,1,2,2,1,1,2|0,2,2,1,1,2,2,2,0|0,0,1,1,1,1,2,0,0"
        }
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 405
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 605
        }
      },
      [5] = {
        action = "SetAllMonstersHP",
        args = {value = 999999}
      },
      [6] = {
        action = "FakeClickAutoFight",
        args = {}
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 8}
      },
      [8] = {
        action = "FakeClickAutoFight",
        args = {}
      },
      name = "测试指定棋盘颜色怪物位置，自动战斗连线结果"
    }
  },
  name = "划线布局-火队",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600261,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1500841,
      level = 1,
      name = "p2"
    },
    [3] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600251,
      level = 1,
      name = "p3"
    },
    [4] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1601171,
      level = 1,
      name = "p4"
    },
    [5] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1400401,
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
