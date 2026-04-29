AutoTest_175 = {
  cases = {
    [1] = {
      [1] = {
        action = "SetTeamPowerFull",
        args = {}
      },
      [2] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 202
        }
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 504
        }
      },
      [4] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 30
        }
      },
      [5] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e2",
          trigger = 30
        }
      },
      [6] = {
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 202,
          trigger = 30
        }
      },
      [7] = {
        action = "CheckEntityPos",
        args = {
          name = "e2",
          pos = 509,
          trigger = 30
        }
      },
      [8] = {
        action = "CheckPieceType",
        args = {
          pieceType = 3,
          pos = 202,
          trigger = 30
        }
      },
      [9] = {
        action = "CheckPieceType",
        args = {
          pieceType = 3,
          pos = 302,
          trigger = 30
        }
      },
      [10] = {
        action = "CheckPieceType",
        args = {
          pieceType = 3,
          pos = 602,
          trigger = 30
        }
      },
      [11] = {
        action = "CheckPieceType",
        args = {
          pieceType = 3,
          pos = 702,
          trigger = 30
        }
      },
      [12] = {
        action = "CheckPieceType",
        args = {
          pieceType = 3,
          pos = 802,
          trigger = 30
        }
      },
      [13] = {
        action = "CheckPieceType",
        args = {
          pieceType = 3,
          pos = 501,
          trigger = 30
        }
      },
      [14] = {
        action = "CheckPieceType",
        args = {
          pieceType = 3,
          pos = 503,
          trigger = 30
        }
      },
      [15] = {
        action = "CheckPieceType",
        args = {
          pieceType = 3,
          pos = 504,
          trigger = 30
        }
      },
      [16] = {
        action = "CheckPieceType",
        args = {
          pieceType = 3,
          pos = 505,
          trigger = 30
        }
      },
      [17] = {
        action = "CheckPieceType",
        args = {
          pieceType = 3,
          pos = 506,
          trigger = 30
        }
      },
      [18] = {
        action = "CheckPieceType",
        args = {
          pieceType = 3,
          pos = 507,
          trigger = 30
        }
      },
      [19] = {
        action = "CheckPieceType",
        args = {
          pieceType = 3,
          pos = 508,
          trigger = 30
        }
      },
      [20] = {
        action = "CheckPieceType",
        args = {
          pieceType = 3,
          pos = 509,
          trigger = 30
        }
      },
      [21] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [22] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "对十字形最大范围造成伤害并击退敌人，同时将攻击范围内的格子转成森属性"
    }
  },
  name = "希卡蕾主动技",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1501001,
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
