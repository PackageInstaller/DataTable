AutoTest_110 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetOnePieceType",
        args = {pieceType = 4, pos = 203}
      },
      [3] = {
        action = "SetOnePieceType",
        args = {pieceType = 4, pos = 303}
      },
      [4] = {
        action = "SetOnePieceType",
        args = {pieceType = 4, pos = 405}
      },
      [5] = {
        action = "SetOnePieceType",
        args = {pieceType = 4, pos = 603}
      },
      [6] = {
        action = "SetOnePieceType",
        args = {pieceType = 4, pos = 702}
      },
      [7] = {
        action = "SetOnePieceType",
        args = {pieceType = 4, pos = 804}
      },
      [8] = {
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 203,
          trigger = 30
        }
      },
      [9] = {
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 303,
          trigger = 30
        }
      },
      [10] = {
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 405,
          trigger = 30
        }
      },
      [11] = {
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 603,
          trigger = 30
        }
      },
      [12] = {
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 702,
          trigger = 30
        }
      },
      [13] = {
        action = "CheckPieceType",
        args = {
          pieceType = 4,
          pos = 804,
          trigger = 30
        }
      },
      [14] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "主动技强化：改变5个格子"
    }
  },
  name = "浮士德突5：转色格子+1",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 5,
      equiplv = 1,
      grade = 3,
      id = 1500091,
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
