AutoTest_356 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [3] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 502}
      },
      [4] = {
        action = "SetOnePieceType",
        args = {pieceType = 4, pos = 401}
      },
      [5] = {
        action = "SetOnePieceType",
        args = {pieceType = 4, pos = 501}
      },
      [6] = {
        action = "SetOnePieceType",
        args = {pieceType = 4, pos = 504}
      },
      [7] = {
        action = "SetOnePieceType",
        args = {pieceType = 2, pos = 601}
      },
      [8] = {
        action = "SetOnePieceType",
        args = {pieceType = 2, pos = 702}
      },
      [9] = {
        action = "SetOnePieceType",
        args = {pieceType = 2, pos = 802}
      },
      [10] = {
        action = "CheckPieceType",
        args = {
          pieceType = 3,
          pos = 401,
          trigger = 88
        }
      },
      [11] = {
        action = "CheckPieceType",
        args = {
          pieceType = 3,
          pos = 501,
          trigger = 88
        }
      },
      [12] = {
        action = "CheckPieceType",
        args = {
          pieceType = 3,
          pos = 504,
          trigger = 88
        }
      },
      [13] = {
        action = "CheckPieceType",
        args = {
          pieceType = 3,
          pos = 601,
          trigger = 88
        }
      },
      [14] = {
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 702,
          trigger = 88
        }
      },
      [15] = {
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 802,
          trigger = 88
        }
      },
      [16] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [17] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "1.先制攻击 2.最近4个火或雷属性格子转为森属性"
    }
  },
  name = "那席里斯主动技",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600011,
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
