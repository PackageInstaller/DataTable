AutoTest_240327_181044 = {
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
          pos = 505
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 506
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e4",
          pos = 507
        }
      },
      [7] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e5",
          pos = 508
        }
      },
      [8] = {
        action = "SetAllMonstersHP",
        args = {value = 99999}
      },
      [9] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 2002161,
          trigger = 102,
          varname = "v1"
        }
      },
      [10] = {
        action = "CheckLocalValue",
        args = {
          target = 1.5499999523163,
          trigger = 102,
          varname = "v1"
        }
      },
      [11] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e2",
          key = "CalcDamage_4",
          skillid = 2002161,
          trigger = 102,
          varname = "v2"
        }
      },
      [12] = {
        action = "CheckLocalValue",
        args = {
          target = 1.5499999523163,
          trigger = 102,
          varname = "v2"
        }
      },
      [13] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 601.0,
            [4] = 501.0,
            [5] = 401.0
          },
          pieceType = 1
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "对最近的2个敌人造成155%的伤害。"
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
          skillid = 2002162,
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
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e2",
          key = "CalcDamage_4",
          skillid = 2002162,
          trigger = 102,
          varname = "v4"
        }
      },
      [6] = {
        action = "CheckLocalValue",
        args = {
          target = 1.6000000238419,
          trigger = 102,
          varname = "v4"
        }
      },
      [7] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e3",
          key = "CalcDamage_4",
          skillid = 2002162,
          trigger = 102,
          varname = "v5"
        }
      },
      [8] = {
        action = "CheckLocalValue",
        args = {
          target = 1.6000000238419,
          trigger = 102,
          varname = "v5"
        }
      },
      [9] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 401.0,
            [2] = 301.0,
            [3] = 202.0,
            [4] = 203.0,
            [5] = 303.0,
            [6] = 302.0,
            [7] = 403.0,
            [8] = 402.0,
            [9] = 501.0,
            [10] = 601.0
          },
          pieceType = 1
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "对最近的3个敌人造成160%的伤害。"
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
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 2002163,
          trigger = 102,
          varname = "v6"
        }
      },
      [4] = {
        action = "CheckLocalValue",
        args = {
          target = 1.6499999761581,
          trigger = 102,
          varname = "v6"
        }
      },
      [5] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e4",
          key = "CalcDamage_4",
          skillid = 2002163,
          trigger = 102,
          varname = "v7"
        }
      },
      [6] = {
        action = "CheckLocalValue",
        args = {
          target = 1.6499999761581,
          trigger = 102,
          varname = "v7"
        }
      },
      [7] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e5",
          trigger = 88
        }
      },
      [8] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 601.0,
            [2] = 701.0,
            [3] = 802.0,
            [4] = 702.0,
            [5] = 602.0,
            [6] = 501.0,
            [7] = 401.0,
            [8] = 301.0,
            [9] = 202.0,
            [10] = 302.0,
            [11] = 402.0,
            [12] = 303.0,
            [13] = 403.0,
            [14] = 503.0
          },
          pieceType = 1
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "对最近的4个敌人造成165%的伤害。"
    }
  },
  name = "璇极连锁技",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 0,
      grade = 0,
      id = 1602161,
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
