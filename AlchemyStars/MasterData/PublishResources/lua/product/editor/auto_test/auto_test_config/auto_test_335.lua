AutoTest_335 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetPieceType",
        args = {pieceType = 4}
      },
      [3] = {
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [4] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 502}
      },
      [5] = {
        action = "SetOnePieceType",
        args = {pieceType = 1, pos = 401}
      },
      [6] = {
        action = "SetOnePieceType",
        args = {pieceType = 1, pos = 501}
      },
      [7] = {
        action = "SetOnePieceType",
        args = {pieceType = 1, pos = 504}
      },
      [8] = {
        action = "SetOnePieceType",
        args = {pieceType = 3, pos = 607}
      },
      [9] = {
        action = "SetOnePieceType",
        args = {pieceType = 3, pos = 702}
      },
      [10] = {
        action = "SetOnePieceType",
        args = {pieceType = 3, pos = 802}
      },
      [11] = {
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 401,
          trigger = 30
        }
      },
      [12] = {
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 501,
          trigger = 30
        }
      },
      [13] = {
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 504,
          trigger = 88
        }
      },
      [14] = {
        action = "CheckPieceType",
        args = {
          pieceType = 3,
          pos = 607,
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
          pieceType = 3,
          pos = 802,
          trigger = 88
        }
      },
      [17] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 505.0
          }
        }
      },
      [18] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "1.最近4个水或森属性格子转为火属性 2.先制攻击"
    }
  },
  name = "艾希主动技",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1601031,
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
