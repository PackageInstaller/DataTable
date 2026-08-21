AutoTest_230505_163831 = {
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
          pos = 503
        }
      },
      [4] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 14,
          name = "e2",
          pos = 603
        }
      },
      [5] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 14,
          name = "e3",
          pos = 703
        }
      },
      [6] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 14,
          name = "e4",
          pos = 704
        }
      },
      [7] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 14,
          name = "e5",
          pos = 604
        }
      },
      [8] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 14,
          name = "e6",
          pos = 504
        }
      },
      [9] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 14,
          name = "e7",
          pos = 404
        }
      },
      [10] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 14,
          name = "e8",
          pos = 304
        }
      },
      [11] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 14,
          name = "e9",
          pos = 204
        }
      },
      [12] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 14,
          name = "e10",
          pos = 205
        }
      },
      [13] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          },
          skillIndex = 1
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [15] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 603.0,
            [4] = 703.0,
            [5] = 704.0,
            [6] = 604.0,
            [7] = 504.0,
            [8] = 404.0,
            [9] = 304.0,
            [10] = 204.0,
            [11] = 205.0,
            [12] = 206.0
          },
          pieceType = 1
        }
      },
      [16] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [17] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [18] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "c1",
          pos = 707
        }
      },
      [19] = {
        action = "SetAllMonstersHP",
        args = {value = 100000}
      },
      [20] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          },
          skillIndex = 2
        }
      },
      [21] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [22] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          },
          skillIndex = 2
        }
      },
      [23] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [24] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "c1",
          key = "CalcDamage_1",
          skillid = 140192,
          trigger = 102,
          varname = "v1"
        }
      },
      [25] = {
        action = "CheckLocalValue",
        args = {
          target = 1.3999999761581,
          trigger = 102,
          varname = "v1"
        }
      },
      [26] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 206.0,
            [2] = 306.0,
            [3] = 406.0,
            [4] = 506.0,
            [5] = 606.0,
            [6] = 706.0
          },
          pieceType = 1
        }
      },
      [27] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "获得2技能：消耗5层获得：普攻8方向，普攻伤害率+20%，一回合，可重复施放但不视为使用主动技"
    }
  },
  name = "列奥觉醒Ⅲ",
  petList = {
    [1] = {
      awakening = 3,
      equiplv = 1,
      grade = 3,
      id = 1601921,
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
