AutoTest_240328_142931 = {
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
          pos = 504
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 204
        }
      },
      [5] = {
        action = "SetAllMonstersHP",
        args = {value = 99999}
      },
      [6] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 2002151,
          trigger = 102,
          varname = "v1"
        }
      },
      [7] = {
        action = "CheckLocalValue",
        args = {
          target = 1.5,
          trigger = 102,
          varname = "v1"
        }
      },
      [8] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 603.0
          },
          pieceType = 1
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "对周围1圈造成150%的伤害。"
    },
    [2] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [3] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 2002152,
          trigger = 102,
          varname = "v2"
        }
      },
      [4] = {
        action = "CheckLocalValue",
        args = {
          target = 1.5499999523163,
          trigger = 102,
          varname = "v2"
        }
      },
      [5] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 603.0,
            [2] = 703.0,
            [3] = 803.0,
            [4] = 903.0,
            [5] = 904.0,
            [6] = 804.0,
            [7] = 704.0
          },
          pieceType = 1
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "对菱形12格造成155%的伤害。"
    },
    [3] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [3] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e2",
          key = "CalcDamage_4",
          skillid = 2002153,
          trigger = 102,
          varname = "v3"
        }
      },
      [4] = {
        action = "CheckLocalValue",
        args = {
          target = 1.6000000238419,
          trigger = 102,
          varname = "v3"
        }
      },
      [5] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 704.0,
            [2] = 804.0,
            [3] = 904.0,
            [4] = 805.0,
            [5] = 706.0,
            [6] = 705.0,
            [7] = 806.0,
            [8] = 906.0,
            [9] = 807.0,
            [10] = 707.0,
            [11] = 608.0,
            [12] = 508.0,
            [13] = 507.0
          },
          pieceType = 1
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "对米字形24格造成160%的伤害。"
    }
  },
  name = "伊莎连锁技",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 0,
      grade = 0,
      id = 1502151,
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
