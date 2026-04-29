AutoTest_211215_113218 = {
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
          id = 2101512,
          name = "e1",
          pos = 504
        }
      },
      [4] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [6] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [7] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          attr_select_index = 8,
          defname = "e1",
          key = "CalcDamage_5",
          key_select_index = 8,
          skillid = 3020551,
          trigger = 102,
          varname = "v1"
        }
      },
      [8] = {
        action = "CheckLocalValue",
        args = {
          target = 2.2000000476837,
          trigger = 88,
          varname = "v1"
        }
      },
      [9] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 503.0
          }
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "1，突2：主动技强化：若上回合未使用主动技，伤害率增加60%"
    }
  },
  name = "彼亚塔曼突2",
  petList = {
    [1] = {
      awakening = 2,
      equiplv = 1,
      grade = 3,
      id = 1500551,
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
