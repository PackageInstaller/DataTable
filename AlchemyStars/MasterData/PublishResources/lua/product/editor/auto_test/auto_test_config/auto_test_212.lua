AutoTest_212 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPosition",
        args = {pos = 502}
      },
      [3] = {
        action = "SetOnePieceType",
        args = {pieceType = 3, pos = 203}
      },
      [4] = {
        action = "SetOnePieceType",
        args = {pieceType = 3, pos = 303}
      },
      [5] = {
        action = "SetOnePieceType",
        args = {pieceType = 3, pos = 405}
      },
      [6] = {
        action = "SetOnePieceType",
        args = {pieceType = 3, pos = 603}
      },
      [7] = {
        action = "SetOnePieceType",
        args = {pieceType = 3, pos = 702}
      },
      [8] = {
        action = "SetOnePieceType",
        args = {pieceType = 3, pos = 804}
      },
      [9] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 203,
          trigger = 88
        }
      },
      [10] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 303,
          trigger = 88
        }
      },
      [11] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 405,
          trigger = 88
        }
      },
      [12] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 603,
          trigger = 88
        }
      },
      [13] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 702,
          trigger = 88
        }
      },
      [14] = {
        action = "CheckPieceType",
        args = {
          pieceType = 3,
          pos = 804,
          trigger = 88
        }
      },
      [15] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [16] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "主动技强化：改变5个格子"
    }
  },
  name = "克莱肯突5：转色格子+1",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 5,
      equiplv = 1,
      grade = 0,
      id = 1500761,
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
