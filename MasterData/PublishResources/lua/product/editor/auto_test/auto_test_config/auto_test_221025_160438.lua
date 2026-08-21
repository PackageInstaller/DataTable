AutoTest_221025_160438 = {
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
        action = "AddBuffToEntity",
        args = {buffID = 10510301, name = "e1"}
      },
      [5] = {
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
      [6] = {
        action = "CheckLocalValue",
        args = {
          target = 1.0,
          trigger = 102,
          varname = "v1"
        }
      },
      [7] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "chainSkillAbsorbParam",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 200061,
          trigger = 102,
          varname = "v2"
        }
      },
      [8] = {
        action = "CheckLocalValue",
        args = {
          target = 1.0,
          trigger = 102,
          varname = "v1"
        }
      },
      [9] = {
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
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "受到主动技的伤害是正常的2倍（普攻+连锁正常：不增加伤害）"
    },
    [2] = {
      [1] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "activeSkillAbsorbParam",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_5",
          skillid = 303006,
          trigger = 102,
          varname = "v3"
        }
      },
      [2] = {
        action = "CheckLocalValue",
        args = {
          target = 2.0499999523163,
          trigger = 102,
          varname = "v3"
        }
      },
      [3] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [4] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "受到主动技的伤害是正常的2倍（主动技）"
    }
  },
  name = "105103破绽III",
  petList = {
    [1] = {
      awakening = 6,
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
