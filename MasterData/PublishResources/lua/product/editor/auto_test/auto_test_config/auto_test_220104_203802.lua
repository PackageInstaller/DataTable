AutoTest_220104_203802 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetEveryPieceType",
        args = {
          pieceTypeArray = "0,0,2,2,2,2,2,0,0|0,2,2,2,2,2,2,2,0|2,2,4,1,4,1,4,2,2|4,1,4,1,4,1,4,1,2|4,0,3,3,3,3,4,1,2|4,1,3,1,3,3,3,4,2|2,1,4,3,3,1,3,3,2|0,2,3,3,3,1,3,2,0|0,0,2,2,2,2,2,0,0"
        }
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 404
        }
      },
      [4] = {
        action = "FakeClickAutoFight",
        args = {}
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 8}
      },
      [6] = {
        action = "FakeClickAutoFight",
        args = {}
      },
      name = "测试指定棋盘颜色怪物位置，自动战斗连线结果"
    }
  },
  name = "划线布局-四叶草",
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
