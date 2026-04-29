AutoTest_355 = {
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
        args = {}
      },
      [4] = {
        action = "SetPieceType",
        args = {pieceType = 3}
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
        args = {pieceType = 2, pos = 601}
      },
      [9] = {
        action = "SetOnePieceType",
        args = {pieceType = 2, pos = 702}
      },
      [10] = {
        action = "SetOnePieceType",
        args = {pieceType = 2, pos = 802}
      },
      [11] = {
        action = "CheckPieceType",
        args = {
          pieceType = 4,
          pos = 401,
          trigger = 30
        }
      },
      [12] = {
        action = "CheckPieceType",
        args = {
          pieceType = 4,
          pos = 501,
          trigger = 30
        }
      },
      [13] = {
        action = "CheckPieceType",
        args = {
          pieceType = 4,
          pos = 504,
          trigger = 30
        }
      },
      [14] = {
        action = "CheckPieceType",
        args = {
          pieceType = 4,
          pos = 601,
          trigger = 30
        }
      },
      [15] = {
        action = "CheckPieceType",
        args = {
          pieceType = 4,
          pos = 702,
          trigger = 30
        }
      },
      [16] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 0,
          layerType = 4049,
          name = "p1",
          trigger = 30
        }
      },
      [17] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [18] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "1.获得磁暴状态 2.6突：改变5个格子属性"
    }
  },
  name = "贡露主动技-磁爆",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 6,
      equiplv = 1,
      grade = 3,
      id = 1600381,
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
