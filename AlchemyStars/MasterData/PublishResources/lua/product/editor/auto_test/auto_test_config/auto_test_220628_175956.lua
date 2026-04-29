AutoTest_220628_175956 = {
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
          pos = 508
        }
      },
      [5] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 507,
          trapIds = {
            [1] = 1.601531E7
          },
          trigger = 88
        }
      },
      [6] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 507.0,
            [2] = 509.0,
            [3] = 408.0,
            [4] = 608.0
          }
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "skillFinalParam",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 20015311,
          trigger = 102,
          varname = "v1"
        }
      },
      [9] = {
        action = "CheckLocalValue",
        args = {
          target = 1.0,
          trigger = 88,
          varname = "v1"
        }
      },
      [10] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "skillFinalParam",
          damageIndex = 2,
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 20015311,
          trigger = 102,
          varname = "v2"
        }
      },
      [11] = {
        action = "CheckLocalValue",
        args = {
          target = 0.80000001192093,
          trigger = 88,
          varname = "v2"
        }
      },
      [12] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "skillFinalParam",
          damageIndex = 3,
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 20015311,
          trigger = 102,
          varname = "v3"
        }
      },
      [13] = {
        action = "CheckLocalValue",
        args = {
          target = 0.60000002384186,
          trigger = 88,
          varname = "v3"
        }
      },
      [14] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "skillFinalParam",
          damageIndex = 4,
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 20015311,
          trigger = 102,
          varname = "v4"
        }
      },
      [15] = {
        action = "CheckLocalValue",
        args = {
          target = 0.40000000596046,
          trigger = 88,
          varname = "v4"
        }
      },
      [16] = {
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
      [17] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "单个格子多次造成伤害时，后续伤害逐次衰减20%"
    }
  },
  name = "莱因哈特主动技伤害递减",
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
