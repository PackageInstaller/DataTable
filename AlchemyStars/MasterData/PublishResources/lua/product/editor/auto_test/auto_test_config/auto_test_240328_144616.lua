AutoTest_240328_144616 = {
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
          skillid = 2002241,
          trigger = 102,
          varname = "v1"
        }
      },
      [10] = {
        action = "CheckLocalValue",
        args = {
          target = 1.3999999761581,
          trigger = 102,
          varname = "v1"
        }
      },
      [11] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 601.0,
            [4] = 501.0
          },
          pieceType = 1
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "朝最近的敌人抛手榴弹，对一格造成140%伤害。"
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
          defname = "e3",
          key = "CalcDamage_4",
          skillid = 2002241,
          trigger = 102,
          varname = "v2"
        }
      },
      [4] = {
        action = "CheckLocalValue",
        args = {
          target = 1.5,
          trigger = 102,
          varname = "v2"
        }
      },
      [5] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e4",
          key = "CalcDamage_4",
          skillid = 2002241,
          trigger = 102,
          varname = "v4"
        }
      },
      [6] = {
        action = "CheckLocalValue",
        args = {
          target = 0.30000001192093,
          trigger = 102,
          varname = "v4"
        }
      },
      [7] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e6",
          key = "CalcDamage_4",
          skillid = 2002241,
          trigger = 102,
          varname = "v5"
        }
      },
      [8] = {
        action = "CheckLocalValue",
        args = {
          target = 0.0,
          trigger = 102,
          varname = "v5"
        }
      },
      [9] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 501.0,
            [2] = 401.0,
            [3] = 301.0,
            [4] = 202.0,
            [5] = 103.0,
            [6] = 104.0,
            [7] = 105.0,
            [8] = 106.0,
            [9] = 107.0,
            [10] = 208.0,
            [11] = 207.0
          },
          pieceType = 1
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "朝最近的敌人抛手榴弹，对一格造成150%伤害，然后扩散周围4格造成30%溅射伤害"
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
          skillid = 2002241,
          trigger = 102,
          varname = "v6"
        }
      },
      [4] = {
        action = "CheckLocalValue",
        args = {
          target = 1.6000000238419,
          trigger = 102,
          varname = "v6"
        }
      },
      [5] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e2",
          key = "CalcDamage_4",
          skillid = 2002241,
          trigger = 102,
          varname = "v7"
        }
      },
      [6] = {
        action = "CheckLocalValue",
        args = {
          target = 0.30000001192093,
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
            [1] = 207.0,
            [2] = 206.0,
            [3] = 205.0,
            [4] = 204.0,
            [5] = 203.0,
            [6] = 202.0,
            [7] = 302.0,
            [8] = 402.0,
            [9] = 502.0,
            [10] = 602.0,
            [11] = 702.0,
            [12] = 802.0,
            [13] = 701.0,
            [14] = 601.0,
            [15] = 501.0
          },
          pieceType = 1
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "朝最近的敌人抛手榴弹，对一格造成160%伤害，然后扩散周围一圈造成30%溅射伤害"
    }
  },
  name = "罗松连锁技",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 0,
      grade = 0,
      id = 1502241,
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
