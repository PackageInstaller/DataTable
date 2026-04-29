AutoTest_211206_170427 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "CheckBattleResult",
        args = {trigger = 80, victory = 1}
      },
      [3] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 505.0,
            [5] = 506.0,
            [6] = 507.0,
            [7] = 508.0
          },
          pieceType = 1
        }
      },
      [4] = {
        action = "WaitGameOver",
        args = {}
      },
      name = "获取5个情报后胜利"
    }
  },
  name = "102情报关胜利",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600261,
      level = 1,
      name = "p1"
    }
  },
  remotePet = {},
  setup = {
    [1] = {
      args = {levelID = 102, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
