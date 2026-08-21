AutoTest_230713_103719 = {
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
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 305
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 505
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 705
        }
      },
      [7] = {
        action = "SetAllMonstersHP",
        args = {value = 100000}
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [9] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 806.0
          },
          skillIndex = 1
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [11] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e3",
          key = "CalcDamage_4",
          skillid = 2202051,
          trigger = 102,
          varname = "v1"
        }
      },
      [12] = {
        action = "CheckLocalValue",
        args = {
          target = 1.6000000238419,
          trigger = 88,
          varname = "v1"
        }
      },
      [13] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 702.0,
            [4] = 802.0,
            [5] = 803.0,
            [6] = 804.0,
            [7] = 805.0
          },
          pieceType = 1
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [15] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e3",
          key = "CalcDamage_4",
          skillid = 2202052,
          trigger = 102,
          varname = "v3"
        }
      },
      [16] = {
        action = "CheckLocalValue",
        args = {
          target = 1.8500000238419,
          trigger = 88,
          varname = "v3"
        }
      },
      [17] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 805.0,
            [2] = 905.0,
            [3] = 906.0,
            [4] = 907.0,
            [5] = 807.0,
            [6] = 707.0,
            [7] = 607.0,
            [8] = 606.0,
            [9] = 605.0,
            [10] = 706.0
          },
          pieceType = 1
        }
      },
      [18] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [19] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [20] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e3",
          key = "CalcDamage_4",
          skillid = 2202053,
          trigger = 102,
          varname = "v2"
        }
      },
      [21] = {
        action = "CheckLocalValue",
        args = {
          target = 1.8999999761581,
          trigger = 88,
          varname = "v2"
        }
      },
      [22] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 706.0,
            [2] = 606.0,
            [3] = 506.0,
            [4] = 406.0,
            [5] = 405.0,
            [6] = 404.0,
            [7] = 403.0,
            [8] = 402.0,
            [9] = 401.0,
            [10] = 501.0,
            [11] = 601.0,
            [12] = 701.0,
            [13] = 702.0,
            [14] = 703.0,
            [15] = 803.0,
            [16] = 903.0,
            [17] = 904.0,
            [18] = 804.0
          },
          pieceType = 1
        }
      },
      [23] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "连锁技强化:获得减少伤害范围内坏格子cd的机制,对应三段分别降低1/2/3"
    }
  },
  name = "sp白兰觉醒2",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 2,
      id = 1502051,
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
