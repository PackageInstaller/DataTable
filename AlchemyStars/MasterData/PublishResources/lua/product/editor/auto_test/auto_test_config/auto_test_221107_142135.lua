AutoTest_221107_142135 = {
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
          pos = 706
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 509
        }
      },
      [5] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 2001763,
          trigger = 102,
          varname = "v1"
        }
      },
      [6] = {
        action = "CheckLocalValue",
        args = {
          target = 1.0,
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
          skillid = 2001763,
          trigger = 102,
          varname = "v2"
        }
      },
      [8] = {
        action = "CheckLocalValue",
        args = {
          target = 0.5,
          trigger = 102,
          varname = "v2"
        }
      },
      [9] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 3,
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 2001763,
          trigger = 102,
          varname = "v3"
        }
      },
      [10] = {
        action = "CheckLocalValue",
        args = {
          target = 0.25,
          trigger = 102,
          varname = "v3"
        }
      },
      [11] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 4,
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 2001763,
          trigger = 102,
          varname = "v4"
        }
      },
      [12] = {
        action = "CheckLocalValue",
        args = {
          target = 0.125,
          trigger = 102,
          varname = "v4"
        }
      },
      [13] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e2",
          trigger = 88
        }
      },
      [14] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 4,
          layerType = 400176,
          name = "e1",
          trigger = 102
        }
      },
      [15] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 702.0,
            [4] = 802.0,
            [5] = 701.0,
            [6] = 601.0,
            [7] = 501.0,
            [8] = 401.0,
            [9] = 301.0,
            [10] = 302.0,
            [11] = 402.0,
            [12] = 403.0,
            [13] = 503.0,
            [14] = 504.0
          },
          pieceType = 1
        }
      },
      [16] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "造成4次100%的伤害。随机分配到自身周围3圈内的敌人身上。对同一目标造成多次伤害时，从第2次起每次伤害减半。每个目标身上插一根矛，最多5跟。"
    }
  },
  name = "贝尔塔连锁技Ⅲ",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1501761,
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
