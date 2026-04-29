AutoTest_210902_172447 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetPieceType",
        args = {pieceType = 3}
      },
      [3] = {
        action = "AddMonster",
        args = {
          ai = 20233,
          dir = 1,
          id = 2040611,
          name = "e1",
          pos = 507
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          ai = 20234,
          dir = 1,
          id = 2040621,
          name = "e2",
          pos = 705
        }
      },
      [5] = {
        action = "SetEntityHPPercent",
        args = {name = "e1", percent = 1.0}
      },
      [6] = {
        action = "SetEntityHPPercent",
        args = {name = "e2", percent = 1.0}
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0
          },
          pieceType = 3
        }
      },
      [9] = {
        action = "CheckDump",
        args = {trigger = 88}
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "携带觉醒后休拉德进入4-7，在恶鬼姐姐残血，在怪物攻击范围内。怪物反伤死，狂暴会卡死AI"
    }
  },
  name = "25883-休拉德反伤击杀4-7恶鬼姐姐,游戏卡死",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 5,
      equiplv = 1,
      grade = 3,
      id = 1500361,
      level = 10,
      name = "p1"
    }
  },
  setup = {
    [1] = {
      args = {levelID = 1, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
