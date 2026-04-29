AutoTest_109 = {
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
        args = {pieceType = 4, pos = 702}
      },
      [8] = {
        action = "SetOnePieceType",
        args = {pieceType = 4, pos = 803}
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
      [11] = {
        action = "CheckPieceType",
        args = {
          pieceType = 4,
          pos = 203,
          trigger = 30
        }
      },
      [12] = {
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 303,
          trigger = 30
        }
      },
      [13] = {
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 405,
          trigger = 30
        }
      },
      [14] = {
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 603,
          trigger = 30
        }
      },
      [15] = {
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 702,
          trigger = 30
        }
      },
      [16] = {
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 803,
          trigger = 30
        }
      },
      [17] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [18] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "主动技上回合处于就绪状态，本回合转色数量+1"
    }
  },
  name = "浮士德：主动技上回合就绪，本回合转色+1",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 2,
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
