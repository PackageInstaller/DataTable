AutoTest_230615_111011 = {
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
          pos = 505
        }
      },
      [4] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [6] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Ready",
          expect = 1.0,
          name = "p1",
          trigger = 88
        }
      },
      [11] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [13] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
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
          defname = "e1",
          key = "CalcDamage_5",
          skillid = 3002021,
          trigger = 102,
          varname = "v1"
        }
      },
      [16] = {
        action = "CheckLocalValue",
        args = {
          target = 5.0,
          trigger = 102,
          varname = "v1"
        }
      },
      [17] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 505.0
          },
          skillIndex = 1
        }
      },
      [18] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [19] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [20] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 503,
          trapIds = {
            [1] = 1.602021E8
          },
          trigger = 88
        }
      },
      [21] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 603,
          trapIds = {
            [1] = 1.602021E8
          },
          trigger = 88
        }
      },
      [22] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 506,
          trapIds = {
            [1] = 1.602021E8
          },
          trigger = 88
        }
      },
      [23] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [24] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "三圈内选择一个单体高额伤害，然后在其周围2圈内随机3个格子上生成炸裂的碎片，进场时技能cd-3，拾取碎片会-1主动技cd"
    }
  },
  name = "sp城主主动技",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 0,
      id = 1602021,
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
