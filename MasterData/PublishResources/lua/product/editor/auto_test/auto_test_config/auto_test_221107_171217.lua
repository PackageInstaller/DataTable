AutoTest_221107_171217 = {
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
          id = 2010913,
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
          pos = 207
        }
      },
      [5] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 1,
          layerType = 400176,
          name = "e1",
          trigger = 102
        }
      },
      [6] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 4,
          layerType = 400176,
          name = "e2",
          trigger = 88
        }
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 603.0,
            [3] = 703.0,
            [4] = 804.0,
            [5] = 805.0,
            [6] = 806.0,
            [7] = 707.0,
            [8] = 607.0,
            [9] = 507.0,
            [10] = 406.0,
            [11] = 306.0,
            [12] = 206.0,
            [13] = 106.0
          },
          pieceType = 1
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [9] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [10] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 106.0,
            [2] = 205.0,
            [3] = 304.0,
            [4] = 404.0
          },
          pieceType = 1
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [12] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_5",
          skillid = 3001761,
          trigger = 102,
          varname = "v1"
        }
      },
      [13] = {
        action = "CheckLocalValue",
        args = {
          target = 0.80000001192093,
          trigger = 102,
          varname = "v1"
        }
      },
      [14] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "将周围2圈所有敌人身上插的矛拔出来回手，每根矛造成8%伤害"
    }
  },
  name = "贝尔塔主动技",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 1,
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
