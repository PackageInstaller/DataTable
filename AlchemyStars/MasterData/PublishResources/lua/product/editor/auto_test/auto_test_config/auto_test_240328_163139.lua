AutoTest_240328_163139 = {
  cases = {
    [1] = {
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
          name = "e1",
          pos = 403
        }
      },
      [4] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 2803501,
          name = "e2",
          pos = 503
        }
      },
      [5] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 2803501,
          name = "e3",
          pos = 504
        }
      },
      [6] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_162",
          skillid = 1002232,
          trigger = 102,
          varname = "v1"
        }
      },
      [7] = {
        action = "CheckLocalValue",
        args = {
          target = 1.0499999523163,
          trigger = 88,
          varname = "v1"
        }
      },
      [8] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0
          },
          pieceType = 1
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "被动强化：经过深色格时额外触发一次1.5倍伤害的被动。"
    }
  },
  name = "辰霓觉醒2",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 2,
      id = 1602231,
      level = 80,
      name = "p1"
    }
  },
  remotePet = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 0,
      id = 1400071,
      level = 1,
      name = "r1"
    }
  },
  setup = {
    [1] = {
      args = {levelID = 1, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
