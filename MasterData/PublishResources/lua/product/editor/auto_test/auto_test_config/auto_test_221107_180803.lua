AutoTest_221107_180803 = {
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
        action = "CheckEntityBuffLayer",
        args = {
          layer = 4,
          layerType = 400176,
          name = "e1",
          trigger = 102
        }
      },
      [5] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 403.0,
            [4] = 404.0,
            [5] = 405.0,
            [6] = 406.0,
            [7] = 507.0,
            [8] = 607.0,
            [9] = 707.0,
            [10] = 806.0
          },
          pieceType = 1
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "SetAllMonstersHP",
        args = {value = 9000}
      },
      [8] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [9] = {
        action = "SetEntityHPPercent",
        args = {name = "team", percent = 0.5}
      },
      [10] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "<",
          name = "team",
          trigger = 88
        }
      },
      [11] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_5",
          skillid = 3201761,
          trigger = 102,
          varname = "v1"
        }
      },
      [12] = {
        action = "CheckLocalValue",
        args = {
          target = 3.2000000476837,
          trigger = 102,
          varname = "v1"
        }
      },
      [13] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [15] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [16] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "主动技强化：恢复等同于本次伤害10%的血量"
    }
  },
  name = "贝尔塔觉醒Ⅱ",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 2,
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
