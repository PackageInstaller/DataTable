AutoTest_210817_165003 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPowerFull",
        args = {}
      },
      [3] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 61,
          name = "e1",
          pos = 505
        }
      },
      [4] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 505,
          trigger = 88
        }
      },
      [5] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 505.0
          }
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 2000900,
          name = "e2",
          pos = 505
        }
      },
      [8] = {
        action = "CheckPieceType",
        args = {
          pieceType = 0,
          pos = 505,
          trigger = 88
        }
      },
      [9] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0
          },
          pieceType = 0
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "贴纸死亡转色被阻挡"
    }
  },
  name = "贴纸格子转色阻挡",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1401271,
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
