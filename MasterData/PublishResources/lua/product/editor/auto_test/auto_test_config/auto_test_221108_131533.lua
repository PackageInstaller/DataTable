AutoTest_221108_131533 = {
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
          id = 2031422,
          name = "e2",
          pos = 207
        }
      },
      [5] = {
        action = "SetAllMonstersHP",
        args = {value = 9999999}
      },
      [6] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 1,
          layerType = 400176,
          name = "e1",
          trigger = 88
        }
      },
      [7] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 4,
          layerType = 400176,
          name = "e2",
          trigger = 88
        }
      },
      [8] = {
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
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "SetEntityHPPercent",
        args = {name = "team", percent = 0.5}
      },
      [11] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [12] = {
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
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [14] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "<",
          name = "team",
          trigger = 102
        }
      },
      [15] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_5",
          skillid = 3251761,
          trigger = 102,
          varname = "v1"
        }
      },
      [16] = {
        action = "CheckLocalValue",
        args = {
          target = 0.80000001192093,
          trigger = 102,
          varname = "v1"
        }
      },
      [17] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e2",
          key = "CalcDamage_5",
          skillid = 3251761,
          trigger = 102,
          varname = "v2"
        }
      },
      [18] = {
        action = "CheckLocalValue",
        args = {
          target = 3.2000000476837,
          trigger = 102,
          varname = "v2"
        }
      },
      [19] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [20] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "主动技强化：目标当前血量越低伤害越高，最大50%"
    }
  },
  name = "贝尔塔突破5",
  petList = {
    [1] = {
      awakening = 5,
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
