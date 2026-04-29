AutoTest_240326_175934 = {
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
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 2803501,
          name = "a1",
          pos = 402
        }
      },
      [6] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 2803501,
          name = "a2",
          pos = 302
        }
      },
      [7] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 2803501,
          name = "a3",
          pos = 202
        }
      },
      [8] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 2803501,
          name = "a4",
          pos = 203
        }
      },
      [9] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 2803501,
          name = "a5",
          pos = 303
        }
      },
      [10] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e2",
          key = "CalcDamage_149",
          skillid = 2302251,
          trigger = 102,
          varname = "v1"
        }
      },
      [11] = {
        action = "CheckLocalValue",
        args = {
          target = 0.40000000596046,
          trigger = 102,
          varname = "v1"
        }
      },
      [12] = {
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
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "被动弱点的爆炸范围扩大至十字5格，按触发格伤害率的50%"
    }
  },
  name = "缇亚拉觉醒3",
  petList = {
    [1] = {
      awakening = 3,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 3,
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
