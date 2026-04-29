AutoTest_240326_162905 = {
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
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 2102251,
          trigger = 102,
          varname = "v1"
        }
      },
      [6] = {
        action = "CheckLocalValue",
        args = {
          target = 1.2999999523163,
          trigger = 102,
          varname = "v1"
        }
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 402.0,
            [3] = 302.0,
            [4] = 202.0,
            [5] = 203.0,
            [6] = 303.0
          },
          pieceType = 1
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "连锁朝向距离最近的敌人，对身前身后造成130%伤害（可引爆1次弱点）"
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
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 604
        }
      },
      [4] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e3",
          key = "CalcDamage_4",
          skillid = 2102252,
          trigger = 102,
          varname = "v2"
        }
      },
      [5] = {
        action = "CheckLocalValue",
        args = {
          target = 1.2999999523163,
          trigger = 102,
          varname = "v2"
        }
      },
      [6] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 303.0,
            [2] = 403.0,
            [3] = 402.0,
            [4] = 302.0,
            [5] = 301.0,
            [6] = 401.0,
            [7] = 501.0,
            [8] = 601.0,
            [9] = 602.0,
            [10] = 603.0,
            [11] = 503.0
          },
          pieceType = 1
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "连锁朝向距离最近的敌人，对身前身后造成130%伤害（可引爆1次弱点）"
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
          defname = "e3",
          key = "CalcDamage_4",
          skillid = 2102253,
          trigger = 102,
          varname = "v3"
        }
      },
      [4] = {
        action = "CheckLocalValue",
        args = {
          target = 1.5,
          trigger = 102,
          varname = "v3"
        }
      },
      [5] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 503.0,
            [2] = 403.0,
            [3] = 303.0,
            [4] = 203.0,
            [5] = 204.0,
            [6] = 205.0,
            [7] = 206.0,
            [8] = 306.0,
            [9] = 307.0,
            [10] = 308.0,
            [11] = 309.0,
            [12] = 409.0,
            [13] = 408.0,
            [14] = 407.0,
            [15] = 507.0
          },
          pieceType = 1
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "连锁朝向距离最近的敌人，对身前身后造成150%伤害（可引爆2次弱点）"
    }
  },
  name = "缇亚拉连锁技",
  petList = {
    [1] = {
      awakening = 3,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 1,
      id = 1602251,
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
