AutoTest_220725_111613 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetEntityHPPercent",
        args = {name = "team", percent = 0.49000000953674}
      },
      [3] = {
        action = "CheckBattleResult",
        args = {trigger = 80, victory = 1}
      },
      [4] = {
        action = "KillAllMonsters",
        args = {}
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [6] = {
        action = "KillAllMonsters",
        args = {}
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "KillAllMonsters",
        args = {}
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "KillAllMonsters",
        args = {}
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [12] = {
        action = "KillAllMonsters",
        args = {}
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [14] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [15] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 404.0,
            [5] = 304.0,
            [6] = 204.0,
            [7] = 205.0,
            [8] = 305.0
          },
          pieceType = 1
        }
      },
      [16] = {
        action = "WaitGameOver",
        args = {}
      },
      name = "血量检测"
    }
  },
  name = "2最后一关的回合数胜利",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1601171,
      level = 1,
      name = "p1"
    }
  },
  remotePet = {},
  setup = {
    [1] = {
      args = {levelID = 1000215, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
