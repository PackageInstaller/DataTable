AutoTest_220711_111053 = {
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
          expect = 85,
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
          skillid = 300151,
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
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "15 san，选一个格子，对相邻4格造成XXX%伤害；如果选择玩家光灵所在格，造成2倍基础伤害"
    }
  },
  name = "贾尔斯主动技",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 0,
      grade = 0,
      id = 1601511,
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
