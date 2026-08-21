AutoTest_221103_150322 = {
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
          id = 5107111,
          name = "e1",
          pos = 506
        }
      },
      [4] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "activeSkillAbsorbParam",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_5",
          skillid = 300006,
          trigger = 102,
          varname = "v1"
        }
      },
      [5] = {
        action = "CheckLocalValue",
        args = {
          target = 1.0499999523163,
          trigger = 88,
          varname = "v1"
        }
      },
      [6] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "normalSkillAbsorbParam",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_1",
          skillid = 100006,
          trigger = 102,
          varname = "v1"
        }
      },
      [7] = {
        action = "CheckLocalValue",
        args = {
          target = 0.30000001192093,
          trigger = 88,
          varname = "v1"
        }
      },
      [8] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "chainSkillAbsorbParam",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 200061,
          trigger = 102,
          varname = "v1"
        }
      },
      [9] = {
        action = "CheckLocalValue",
        args = {
          target = 0.30000001192093,
          trigger = 88,
          varname = "v1"
        }
      },
      [10] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [11] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [13] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 503.0,
            [4] = 504.0,
            [5] = 505.0,
            [6] = 506.0,
            [7] = 507.0,
            [8] = 508.0
          },
          pieceType = 1
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "普攻与连锁技只能造成30%的输出。"
    }
  },
  name = "40029孱弱诅咒",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600061,
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
