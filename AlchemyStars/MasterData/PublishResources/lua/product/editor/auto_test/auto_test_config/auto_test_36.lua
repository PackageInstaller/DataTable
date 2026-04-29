AutoTest_36 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 502}
      },
      [3] = {
        action = "SetOnePieceType",
        args = {pieceType = 4, pos = 203}
      },
      [4] = {
        action = "SetOnePieceType",
        args = {pieceType = 4, pos = 303}
      },
      [5] = {
        action = "SetOnePieceType",
        args = {pieceType = 4, pos = 405}
      },
      [6] = {
        action = "SetOnePieceType",
        args = {pieceType = 4, pos = 603}
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
          pieceType = 4,
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
      name = "将最近的4个雷属性格子转为火属性"
    }
  },
  name = "浮士德主动技",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 0,
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
