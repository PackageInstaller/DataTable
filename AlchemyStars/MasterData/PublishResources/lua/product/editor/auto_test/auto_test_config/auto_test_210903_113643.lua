AutoTest_210903_113643 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 9990002,
          name = "e1",
          pos = 404
        }
      },
      [3] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 9990001,
          name = "e2",
          pos = 105
        }
      },
      [4] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 9990001,
          name = "e3",
          pos = 905
        }
      },
      [5] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 9990001,
          name = "e4",
          pos = 509
        }
      },
      [6] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0
          },
          pieceType = 1
        }
      },
      [7] = {
        action = "CheckDump",
        args = {trigger = 88}
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "buffTargetType.HPPercentHighestMonster   没有判断目标数量是0的情况"
    }
  },
  name = "25736-泷进入格子机关报错",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 5,
      equiplv = 1,
      grade = 3,
      id = 1500711,
      level = 1,
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
