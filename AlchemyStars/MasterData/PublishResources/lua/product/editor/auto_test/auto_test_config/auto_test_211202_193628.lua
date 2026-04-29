AutoTest_211202_193628 = {
  cases = {
    [1] = {
      [1] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 9000351,
          name = "e1",
          pos = 305
        }
      },
      [2] = {
        action = "AddTrap",
        args = {
          dir = 101,
          disableai = true,
          id = 61,
          name = "e3",
          pos = 905
        }
      },
      [3] = {
        action = "CheckPieceType",
        args = {
          invert = 0.0,
          pieceType = 0,
          pos = 905,
          trigger = 88
        }
      },
      [4] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 505.0
          },
          pieceType = 1
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "击飞小怪把人击退到锁格子上"
    }
  },
  name = "击退人到锁格子",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 6,
      equiplv = 1,
      grade = 3,
      id = 1600191,
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
