AutoTest_209 = {
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
        args = {pieceType = 3, pos = 804}
      },
      [8] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 203,
          trigger = 30
        }
      },
      [9] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 303,
          trigger = 30
        }
      },
      [10] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 405,
          trigger = 30
        }
      },
      [11] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 603,
          trigger = 30
        }
      },
      [12] = {
        action = "CheckPieceType",
        args = {
          pieceType = 3,
          pos = 804,
          trigger = 30
        }
      },
      [13] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "将最近的4个森属性格子转为水属性"
    }
  },
  name = "克莱肯主动技：转色",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
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
