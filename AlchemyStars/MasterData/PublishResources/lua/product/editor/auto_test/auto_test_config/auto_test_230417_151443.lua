AutoTest_230417_151443 = {
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
          pos = 509
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 508
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 503
        }
      },
      [6] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [7] = {
        action = "CheckFormulaAttr",
        args = {
          attr = "skillIncreaseParam",
          defname = "e1",
          expect = 1.6000000238419,
          key = "CalcDamage_5",
          skillid = 3301931,
          trigger = 102
        }
      },
      [8] = {
        action = "CheckFormulaAttr",
        args = {
          attr = "skillIncreaseParam",
          defname = "e2",
          expect = 1.5,
          key = "CalcDamage_5",
          skillid = 3301931,
          trigger = 102
        }
      },
      [9] = {
        action = "CheckFormulaAttr",
        args = {
          attr = "skillIncreaseParam",
          defname = "e3",
          expect = 1.0,
          key = "CalcDamage_5",
          skillid = 3301931,
          trigger = 102
        }
      },
      [10] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 503.0
          },
          skillIndex = 1
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "主动技强化：距离越远伤害越高（每格提高10%最终伤害）"
    }
  },
  name = "克里斯汀觉醒3",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1501931,
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
