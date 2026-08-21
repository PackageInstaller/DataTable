AutoTest_220225_132841 = {
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
        action = "SetPieceType",
        args = {pieceType = 2}
      },
      [4] = {
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 304
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 503
        }
      },
      [7] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 704
        }
      },
      [8] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [9] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e2",
          trigger = 88
        }
      },
      [10] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e3",
          trigger = 88
        }
      },
      [11] = {
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 106,
          trigger = 88
        }
      },
      [12] = {
        action = "CheckEntityPos",
        args = {
          name = "e2",
          pos = 503,
          trigger = 88
        }
      },
      [13] = {
        action = "CheckEntityPos",
        args = {
          name = "e3",
          pos = 906,
          trigger = 88
        }
      },
      [14] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 1,
          pos = 401,
          trigger = 88
        }
      },
      [15] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 1,
          pos = 601,
          trigger = 88
        }
      },
      [16] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 2,
          pos = 501,
          trigger = 88
        }
      },
      [17] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 1,
          pos = 603,
          trigger = 88
        }
      },
      [18] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 1,
          pos = 704,
          trigger = 88
        }
      },
      [19] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 1,
          pos = 805,
          trigger = 88
        }
      },
      [20] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 1,
          pos = 906,
          trigger = 88
        }
      },
      [21] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 1,
          pos = 106,
          trigger = 88
        }
      },
      [22] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 1,
          pos = 205,
          trigger = 88
        }
      },
      [23] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 1,
          pos = 304,
          trigger = 88
        }
      },
      [24] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 1,
          pos = 403,
          trigger = 88
        }
      },
      [25] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 403.0
          }
        }
      },
      [26] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "对十字或斜十字最大范围造成{1}%的伤害，并击退敌人。同时将攻击范围内的格子转成水属性。"
    }
  },
  name = "露比主动技",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1601411,
      level = 1,
      name = "p1"
    }
  },
  remotePet = {},
  setup = {
    [1] = {
      args = {levelID = 1, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
