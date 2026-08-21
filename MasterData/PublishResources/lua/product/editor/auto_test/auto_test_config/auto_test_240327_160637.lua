AutoTest_240327_160637 = {
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
        action = "SetAllMonstersHP",
        args = {value = 99999}
      },
      [5] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 2102201,
          trigger = 102,
          varname = "v1"
        }
      },
      [6] = {
        action = "CheckLocalValue",
        args = {
          target = 1.25,
          trigger = 102,
          varname = "v1"
        }
      },
      [7] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 2,
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 2102201,
          trigger = 102,
          varname = "a1"
        }
      },
      [8] = {
        action = "CheckLocalValue",
        args = {
          target = 0.625,
          trigger = 102,
          varname = "a1"
        }
      },
      [9] = {
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
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "造成2次125%的伤害。随机分配到自身周围3圈内的敌人身上。对同一目标造成多次伤害时，从第2次起每次伤害减半。"
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
          skillid = 2002202,
          trigger = 102,
          varname = "v2"
        }
      },
      [4] = {
        action = "CheckLocalValue",
        args = {
          target = 1.2999999523163,
          trigger = 102,
          varname = "v2"
        }
      },
      [5] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 2,
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 2002202,
          trigger = 102,
          varname = "a2"
        }
      },
      [6] = {
        action = "CheckLocalValue",
        args = {
          target = 0.64999997615814,
          trigger = 102,
          varname = "a2"
        }
      },
      [7] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 3,
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 2002202,
          trigger = 102,
          varname = "a3"
        }
      },
      [8] = {
        action = "CheckLocalValue",
        args = {
          target = 0.32499998807907,
          trigger = 102,
          varname = "a3"
        }
      },
      [9] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 401.0,
            [2] = 501.0,
            [3] = 601.0,
            [4] = 701.0,
            [5] = 702.0,
            [6] = 802.0,
            [7] = 903.0,
            [8] = 803.0,
            [9] = 804.0
          },
          pieceType = 1
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "造成3次130%的伤害。随机分配到自身周围3圈内的敌人身上。对同一目标造成多次伤害时，从第2次起每次伤害减半。"
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
          skillid = 2002203,
          trigger = 102,
          varname = "v3"
        }
      },
      [4] = {
        action = "CheckLocalValue",
        args = {
          target = 1.3500000238419,
          trigger = 102,
          varname = "v3"
        }
      },
      [5] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 4,
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 2002203,
          trigger = 102,
          varname = "a4"
        }
      },
      [6] = {
        action = "CheckLocalValue",
        args = {
          target = 0.16875000298023,
          trigger = 102,
          varname = "a4"
        }
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 804.0,
            [2] = 704.0,
            [3] = 604.0,
            [4] = 605.0,
            [5] = 606.0,
            [6] = 506.0,
            [7] = 406.0,
            [8] = 306.0,
            [9] = 305.0,
            [10] = 304.0,
            [11] = 303.0,
            [12] = 302.0,
            [13] = 203.0,
            [14] = 204.0
          },
          pieceType = 1
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "造成4次135%的伤害。随机分配到自身周围3圈内的敌人身上。对同一目标造成多次伤害时，从第2次起每次伤害减半。"
    }
  },
  name = "维吉尔连锁技",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 0,
      grade = 0,
      id = 1502201,
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
