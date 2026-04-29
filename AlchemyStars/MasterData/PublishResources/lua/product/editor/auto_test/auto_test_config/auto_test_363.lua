AutoTest_363 = {
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
          pos = 603
        }
      },
      [4] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 200961,
          trigger = 102,
          varname = "v1"
        }
      },
      [5] = {
        action = "CheckLocalValue",
        args = {
          target = 1.2999999523163,
          trigger = 88,
          varname = "v1"
        }
      },
      [6] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 2,
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 200961,
          trigger = 102,
          varname = "v2"
        }
      },
      [7] = {
        action = "CheckLocalValue",
        args = {
          target = 0.64999997615814,
          trigger = 88,
          varname = "v2"
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
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 402.0,
            [3] = 302.0,
            [4] = 303.0,
            [5] = 403.0
          },
          pieceType = 1
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [11] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 605
        }
      },
      [12] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 606
        }
      },
      [13] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e2",
          key = "CalcDamage_4",
          skillid = 200961,
          trigger = 102,
          varname = "v3"
        }
      },
      [14] = {
        action = "CheckLocalValue",
        args = {
          target = 1.2999999523163,
          trigger = 88,
          varname = "v3"
        }
      },
      [15] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e3",
          key = "CalcDamage_4",
          skillid = 200961,
          trigger = 102,
          varname = "v4"
        }
      },
      [16] = {
        action = "CheckLocalValue",
        args = {
          target = 1.2999999523163,
          trigger = 88,
          varname = "v4"
        }
      },
      [17] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 403.0,
            [2] = 404.0,
            [3] = 405.0,
            [4] = 406.0,
            [5] = 407.0
          },
          pieceType = 1
        }
      },
      [18] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "造成3次{1}%的伤害。随机分配到自身周围2圈内的敌人身上。对同一目标造成多次伤害时，从第2次起每次伤害减半。"
    }
  },
  name = "沙利叶连锁技",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 0,
      id = 1600961,
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
