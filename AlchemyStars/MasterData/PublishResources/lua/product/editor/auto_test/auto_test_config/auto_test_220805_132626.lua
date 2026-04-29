AutoTest_220805_132626 = {
  cases = {
    [1] = {
      [1] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 101311,
          name = "e1",
          pos = 604
        }
      },
      [2] = {
        action = "AddBuffToAllMonsters",
        args = {buffID = 4001581}
      },
      [3] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "skillFinalParam",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_5",
          skillid = 300161,
          trigger = 102,
          varname = "v1"
        }
      },
      [4] = {
        action = "CheckLocalValue",
        args = {
          target = 1.1000000238419,
          trigger = 88,
          varname = "v1"
        }
      },
      [5] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 602.0
          }
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "skillFinalParam",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_1",
          skillid = 100161,
          trigger = 102,
          varname = "v2"
        }
      },
      [8] = {
        action = "CheckLocalValue",
        args = {
          target = 1.1000000238419,
          trigger = 88,
          varname = "v2"
        }
      },
      [9] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "skillFinalParam",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 2001612,
          trigger = 102,
          varname = "v3"
        }
      },
      [10] = {
        action = "CheckLocalValue",
        args = {
          target = 1.1000000238419,
          trigger = 88,
          varname = "v3"
        }
      },
      [11] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 601.0,
            [4] = 501.0,
            [5] = 401.0,
            [6] = 402.0,
            [7] = 403.0,
            [8] = 503.0,
            [9] = 603.0,
            [10] = 703.0,
            [11] = 704.0
          },
          pieceType = 1
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "对处于weak状态的敌人造成的所有伤害均提高10%"
    }
  },
  name = "芳泽霞觉醒1",
  petList = {
    [1] = {
      awakening = 3,
      equiplv = 3,
      grade = 1,
      id = 1501611,
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
