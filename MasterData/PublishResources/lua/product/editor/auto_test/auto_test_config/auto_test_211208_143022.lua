AutoTest_211208_143022 = {
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
            [2] = 402.0,
            [3] = 302.0,
            [4] = 202.0
          },
          pieceType = 1
        }
      },
      [4] = {
        action = "WaitGameOver",
        args = {}
      },
      name = "逃离到出口"
    }
  },
  name = "108逃离关",
  petList = {
    [1] = {
      awakening = 3,
      equiplv = 1,
      grade = 3,
      id = 1600061,
      level = 1,
      name = "p1"
    }
  },
  remotePet = {},
  setup = {
    [1] = {
      args = {levelID = 108, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
