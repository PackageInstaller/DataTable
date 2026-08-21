AutoTest_220628_174613 = {
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
        args = {name = "team", name_select_index = 0}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 406
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 304
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 904
        }
      },
      [7] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 303,
          trapIds = {
            [1] = 1.601531E7
          },
          trigger = 88
        }
      },
      [8] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 306,
          trapIds = {
            [1] = 1.601531E7
          },
          trigger = 88
        }
      },
      [9] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 506,
          trapIds = {
            [1] = 1.601531E7
          },
          trigger = 88
        }
      },
      [10] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 804,
          trapIds = {
            [1] = 1.601531E7
          },
          trigger = 88
        }
      },
      [11] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 303.0,
            [2] = 306.0,
            [3] = 506.0,
            [4] = 804.0
          }
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [13] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "normalSkillAbsorbParam",
          defname = "e2",
          key = "CalcDamage_1",
          skillid = 1001531,
          trigger = 102,
          varname = "v1"
        }
      },
      [14] = {
        action = "CheckLocalValue",
        args = {
          target = 1.0,
          trigger = 88,
          varname = "v1"
        }
      },
      [15] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          defname = "e3",
          key = "CalcDamage_4",
          skillid = 20015311,
          trigger = 102,
          varname = "v2"
        }
      },
      [16] = {
        action = "CheckLocalValue",
        args = {
          target = 0.69999998807907,
          trigger = 88,
          varname = "v2"
        }
      },
      [17] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 402.0,
            [3] = 403.0,
            [4] = 503.0
          },
          pieceType = 1
        }
      },
      [18] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "任选4个格子，标记，进入过载状态 持续2回合：普攻8方向，额外连锁技：对4个十字5格造成一半系数的伤害，单个格子多次造成伤害时，后续伤害逐次衰减20%"
    }
  },
  name = "莱因哈特主动技",
  petList = {
    [1] = {
      affinity = 0,
      awakening = 0,
      equiplv = 0,
      grade = 0,
      id = 1601531,
      level = 1,
      name = "p1"
    }
  },
  setup = {
    [1] = {
      args = {levelID = 1, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
