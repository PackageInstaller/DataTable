AutoTest_138 = {
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
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 305
        }
      },
      [4] = {
        action = "SetOnePieceType",
        args = {pieceType = 2, pos = 203}
      },
      [5] = {
        action = "SetOnePieceType",
        args = {pieceType = 2, pos = 303}
      },
      [6] = {
        action = "SetOnePieceType",
        args = {pieceType = 2, pos = 405}
      },
      [7] = {
        action = "SetOnePieceType",
        args = {pieceType = 2, pos = 603}
      },
      [8] = {
        action = "SetOnePieceType",
        args = {pieceType = 2, pos = 702}
      },
      [9] = {
        action = "SetOnePieceType",
        args = {pieceType = 2, pos = 806}
      },
      [10] = {
        action = "CheckPieceType",
        args = {
          pieceType = 4,
          pos = 203,
          trigger = 88
        }
      },
      [11] = {
        action = "CheckPieceType",
        args = {
          pieceType = 4,
          pos = 303,
          trigger = 88
        }
      },
      [12] = {
        action = "CheckPieceType",
        args = {
          pieceType = 4,
          pos = 405,
          trigger = 88
        }
      },
      [13] = {
        action = "CheckPieceType",
        args = {
          pieceType = 4,
          pos = 603,
          trigger = 88
        }
      },
      [14] = {
        action = "CheckPieceType",
        args = {
          pieceType = 4,
          pos = 702,
          trigger = 88
        }
      },
      [15] = {
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 806,
          trigger = 88
        }
      },
      [16] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [17] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "主动技强化：改变5个格子"
    }
  },
  name = "贝芙丽突5：转色格子+1",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 5,
      equiplv = 1,
      grade = 2,
      id = 1500871,
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
