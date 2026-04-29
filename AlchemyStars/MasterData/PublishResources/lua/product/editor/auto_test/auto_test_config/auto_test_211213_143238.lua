AutoTest_211213_143238 = {
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
          id = 2090921,
          name = "e1",
          pos = 204
        }
      },
      [4] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [5] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          attr_select_index = 9,
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_5",
          key_select_index = 9,
          skillid = 320111,
          trigger = 102,
          varname = "Val1"
        }
      },
      [6] = {
        action = "CheckLocalValue",
        args = {
          target = 3.0,
          trigger = 88,
          varname = "Val1"
        }
      },
      [7] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          },
          skillIndex = 0
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "1，突3：主动系数50% 2，突6：先制攻击"
    }
  },
  name = "拜里厄突3突6",
  petList = {
    [1] = {
      awakening = 6,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 3,
      id = 1601111,
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
