AutoTest_339 = {
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
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [4] = {
        action = "SetPieceType",
        args = {pieceType = 4}
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
        args = {pieceType = 3, pos = 601}
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
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0
          },
          pieceType = 0
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [13] = {
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 401,
          trigger = 30
        }
      },
      [14] = {
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 501,
          trigger = 30
        }
      },
      [15] = {
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 504,
          trigger = 30
        }
      },
      [16] = {
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 601,
          trigger = 30
        }
      },
      [17] = {
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 702,
          trigger = 30
        }
      },
      [18] = {
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 802,
          trigger = 88
        }
      },
      [19] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 505.0
          }
        }
      },
      [20] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = ".改变5个格子属性"
    }
  },
  name = "艾希主动技-改变格子属性",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 6,
      equiplv = 1,
      grade = 3,
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
