AutoTest_230505_153921 = {
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
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 14,
          name = "e1",
          pos = 504
        }
      },
      [4] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 141,
          name = "e2",
          pos = 505
        }
      },
      [5] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 1994,
          name = "e3",
          pos = 506
        }
      },
      [6] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 2004,
          name = "e4",
          pos = 507
        }
      },
      [7] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 60,
          name = "e5",
          pos = 508
        }
      },
      [8] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 61,
          name = "e6",
          pos = 608
        }
      },
      [9] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e7",
          pos = 708
        }
      },
      [10] = {
        action = "SetAllMonstersHP",
        args = {value = 100000}
      },
      [11] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 1,
          layerType = 4101920,
          name = "p1",
          trigger = 88
        }
      },
      [12] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e7",
          key = "CalcDamage_4",
          skillid = 2001921,
          trigger = 102,
          varname = "v1"
        }
      },
      [13] = {
        action = "CheckLocalValue",
        args = {
          target = 1.5099999904633,
          trigger = 102,
          varname = "v1"
        }
      },
      [14] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 505.0,
            [5] = 506.0,
            [6] = 507.0,
            [7] = 508.0,
            [8] = 608.0
          },
          pieceType = 1
        }
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [16] = {
        action = "SetEntityBuffLayer",
        args = {
          display = true,
          layer = 98,
          layerType = 4101920,
          name = "p1"
        }
      },
      [17] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 14,
          name = "w1",
          pos = 607
        }
      },
      [18] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 14,
          name = "w2",
          pos = 606
        }
      },
      [19] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 14,
          name = "w3",
          pos = 605
        }
      },
      [20] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e7",
          key = "CalcDamage_4",
          skillid = 2001921,
          trigger = 102,
          varname = "v2"
        }
      },
      [21] = {
        action = "CheckLocalValue",
        args = {
          target = 2.4900000095367,
          trigger = 88,
          varname = "v2"
        }
      },
      [22] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 608.0,
            [2] = 607.0,
            [3] = 606.0,
            [4] = 605.0,
            [5] = 705.0,
            [6] = 706.0,
            [7] = 707.0
          },
          pieceType = 1
        }
      },
      [23] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 99,
          layerType = 4101920,
          name = "p1",
          trigger = 88
        }
      },
      [24] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "每当获得强化格，获得1层标记，每层提高XX%的连锁技伤害率，持续整场，最大99层"
    }
  },
  name = "列奥觉醒Ⅰ",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 1,
      id = 1601921,
      level = 31,
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
