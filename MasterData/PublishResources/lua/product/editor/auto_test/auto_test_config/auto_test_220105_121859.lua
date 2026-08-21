AutoTest_220105_121859 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [3] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [4] = {
        action = "FakeCastSkill",
        args = {
          name = "p4",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [6] = {
        action = "SetEveryPieceType",
        args = {
          pieceTypeArray = "0,0,4,4,4,4,4,0,0|0,2,2,1,1,3,4,2,0|4,2,1,3,1,3,2,2,4|4,2,1,3,1,1,1,2,4|4,0,1,1,1,1,1,1,4|4,2,1,3,1,1,1,2,4|4,2,1,3,1,3,2,2,4|0,2,4,1,1,3,4,2,0|0,0,4,4,4,4,4,0,0"
        }
      },
      [7] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 507
        }
      },
      [8] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "e1"}
      },
      [9] = {
        action = "FakeClickAutoFight",
        args = {}
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 8}
      },
      [11] = {
        action = "FakeClickAutoFight",
        args = {}
      },
      name = "测试指定棋盘颜色怪物位置，自动战斗连线结果"
    }
  },
  name = "划线布局-水队",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1500761,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600061,
      level = 1,
      name = "p2"
    },
    [3] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600111,
      level = 1,
      name = "p3"
    },
    [4] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600961,
      level = 1,
      name = "p4"
    },
    [5] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1500131,
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
