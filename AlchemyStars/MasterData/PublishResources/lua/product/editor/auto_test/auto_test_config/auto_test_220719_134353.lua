AutoTest_220719_134353 = {
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
          id = 2040124,
          name = "e2",
          pos = 505
        }
      },
      [4] = {
        action = "CheckSanValue",
        args = {
          compare = "==",
          expect = 100,
          trigger = 0
        }
      },
      [5] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e2",
          trigger = 88
        }
      },
      [6] = {
        action = "CheckSanValue",
        args = {
          compare = "==",
          expect = 94,
          trigger = 88
        }
      },
      [7] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e2",
          key = "CalcDamage_5",
          skillid = 3001501,
          trigger = 102,
          varname = "v1"
        }
      },
      [8] = {
        action = "CheckLocalValue",
        args = {
          target = 3.3299999237061,
          trigger = 88,
          varname = "v1"
        }
      },
      [9] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 2,
          defname = "e2",
          key = "CalcDamage_5",
          skillid = 3001501,
          trigger = 102,
          varname = "v2"
        }
      },
      [10] = {
        action = "CheckLocalValue",
        args = {
          target = 1.0988999605179,
          trigger = 88,
          varname = "v2"
        }
      },
      [11] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 505.0,
            [2] = 506.0
          }
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "先选一个格子，然后点选该格周围两圈内的另一格框出一个矩形造成XX%伤害，每个格子扣3点san值，对同一个敌人造成多次伤害时后续只有33%效果"
    }
  },
  name = "莲主动技",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 0,
      grade = 0,
      id = 1601501,
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
