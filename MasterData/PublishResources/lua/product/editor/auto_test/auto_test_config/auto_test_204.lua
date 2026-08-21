AutoTest_204 = {
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
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 204
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 504
        }
      },
      [7] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e1",
          trigger = 88
        }
      },
      [8] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e2",
          trigger = 88
        }
      },
      [9] = {
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 204,
          trigger = 88
        }
      },
      [10] = {
        action = "CheckEntityPos",
        args = {
          name = "e2",
          pos = 509,
          trigger = 88
        }
      },
      [11] = {
        action = "CheckPieceType",
        args = {
          pieceType = 3,
          pos = 204,
          trigger = 88
        }
      },
      [12] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 202,
          trigger = 88
        }
      },
      [13] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 302,
          trigger = 88
        }
      },
      [14] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 402,
          trigger = 88
        }
      },
      [15] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 501,
          trigger = 88
        }
      },
      [16] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 503,
          trigger = 88
        }
      },
      [17] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 504,
          trigger = 88
        }
      },
      [18] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 505,
          trigger = 88
        }
      },
      [19] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 506,
          trigger = 88
        }
      },
      [20] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 507,
          trigger = 88
        }
      },
      [21] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 508,
          trigger = 88
        }
      },
      [22] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 509,
          trigger = 88
        }
      },
      [23] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 602,
          trigger = 88
        }
      },
      [24] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 702,
          trigger = 88
        }
      },
      [25] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 802,
          trigger = 88
        }
      },
      [26] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [27] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "对十字形最大范围造成450%攻击力的伤害并击退敌人，同时将攻击范围的格子转成水属性"
    }
  },
  name = "巴顿主动技",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1500421,
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
