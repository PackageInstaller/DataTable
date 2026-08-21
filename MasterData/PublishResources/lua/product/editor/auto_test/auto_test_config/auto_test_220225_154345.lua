AutoTest_220225_154345 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 503}
      },
      [3] = {
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 603
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 706
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 203
        }
      },
      [7] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e4",
          pos = 505
        }
      },
      [8] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e5",
          pos = 404
        }
      },
      [9] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [10] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e2",
          trigger = 88
        }
      },
      [11] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e3",
          trigger = 88
        }
      },
      [12] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e4",
          trigger = 88
        }
      },
      [13] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e5",
          trigger = 88
        }
      },
      [14] = {
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 604,
          trigger = 88
        }
      },
      [15] = {
        action = "CheckEntityPos",
        args = {
          name = "e2",
          pos = 606,
          trigger = 88
        }
      },
      [16] = {
        action = "CheckEntityPos",
        args = {
          name = "e3",
          pos = 203,
          trigger = 88
        }
      },
      [17] = {
        action = "CheckEntityPos",
        args = {
          name = "e4",
          pos = 505,
          trigger = 88
        }
      },
      [18] = {
        action = "CheckEntityPos",
        args = {
          name = "e5",
          pos = 404,
          trigger = 88
        }
      },
      [19] = {
        action = "CheckFormulaAttr",
        args = {
          attr = "damagePercent",
          attr_select_index = 9,
          defname = "e1",
          expect = 2.9700000286102,
          key = "CalcDamage_5",
          key_select_index = 9,
          skillid = 300142,
          trigger = 102
        }
      },
      [20] = {
        action = "CheckFormulaAttr",
        args = {
          attr = "damagePercent",
          attr_select_index = 9,
          defname = "e2",
          expect = 2.9700000286102,
          key = "CalcDamage_5",
          key_select_index = 9,
          skillid = 300142,
          trigger = 102
        }
      },
      [21] = {
        action = "CheckFormulaAttr",
        args = {
          attr = "damagePercent",
          attr_select_index = 9,
          defname = "e4",
          expect = 3.5,
          key = "CalcDamage_5",
          key_select_index = 9,
          skillid = 300142,
          trigger = 102
        }
      },
      [22] = {
        action = "CheckFormulaAttr",
        args = {
          attr = "damagePercent",
          attr_select_index = 9,
          defname = "e5",
          expect = 2.9700000286102,
          key = "CalcDamage_5",
          key_select_index = 9,
          skillid = 300142,
          trigger = 102
        }
      },
      [23] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 505.0
          },
          skillIndex = 0
        }
      },
      [24] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "菱形12范围内选一个格子，目标周围两圈造成伤害，选定格是XXX%，每外扩一圈伤害率下降53%；范围内的所有敌人往选择的格子强制位移2格"
    }
  },
  name = "花云主动技",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 0,
      id = 1501421,
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
