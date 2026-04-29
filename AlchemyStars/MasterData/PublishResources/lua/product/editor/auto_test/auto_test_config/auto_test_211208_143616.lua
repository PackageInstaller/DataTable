AutoTest_211208_143616 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetAllMonstersHP",
        args = {value = 1000}
      },
      [3] = {
        action = "CheckBattleResult",
        args = {trigger = 80, victory = 1}
      },
      [4] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 505.0,
            [5] = 506.0,
            [6] = 507.0
          },
          pieceType = 1
        }
      },
      [5] = {
        action = "WaitGameOver",
        args = {}
      },
      name = "新测试用例"
    }
  },
  name = "109Boss死亡",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1500121,
      level = 1,
      name = "p1"
    }
  },
  remotePet = {},
  setup = {
    [1] = {
      args = {levelID = 109, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
