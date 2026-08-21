AutoTest_230810_151405 = {
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
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 405
        }
      },
      [4] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [5] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_5",
          skillid = 3002061,
          trigger = 102,
          varname = "v1"
        }
      },
      [6] = {
        action = "CheckLocalValue",
        args = {
          target = 3.0,
          trigger = 102,
          varname = "v1"
        }
      },
      [7] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 2,
          pos = 401,
          trigger = 88
        }
      },
      [8] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 2,
          pos = 402,
          trigger = 88
        }
      },
      [9] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 2,
          pos = 403,
          trigger = 88
        }
      },
      [10] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 2,
          pos = 404,
          trigger = 88
        }
      },
      [11] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 2,
          pos = 405,
          trigger = 88
        }
      },
      [12] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 2,
          pos = 406,
          trigger = 88
        }
      },
      [13] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 2,
          pos = 407,
          trigger = 88
        }
      },
      [14] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 2,
          pos = 408,
          trigger = 88
        }
      },
      [15] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 2,
          pos = 409,
          trigger = 88
        }
      },
      [16] = {
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 409,
          trigger = 88
        }
      },
      [17] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 404.0
          },
          skillIndex = 1
        }
      },
      [18] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新测试用例"
    }
  },
  name = "莱蕾主动技",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 0,
      id = 1602061,
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
