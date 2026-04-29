AutoTest_211213_001325 = {
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
          pos = 403
        }
      },
      [5] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [6] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          attr_select_index = 8,
          defname = "e1",
          key = "CalcDamage_5",
          key_select_index = 8,
          skillid = 325123,
          trigger = 102,
          varname = "Val1"
        }
      },
      [7] = {
        action = "CheckLocalValue",
        args = {
          target = 2.0,
          trigger = 88,
          varname = "Val1"
        }
      },
      [8] = {
        action = "CheckBuffLogic",
        args = {
          exist = true,
          logic = "ATBuffStun",
          logic_select_index = 15,
          name = "e1",
          trigger = 88
        }
      },
      [9] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 403.0
          }
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "1，突2：主动技伤害提高40% 2，突6：主动技强化：首次就击晕"
    }
  },
  name = "柯蒂突2突5",
  petList = {
    [1] = {
      awakening = 5,
      equiplv = 1,
      grade = 3,
      id = 1601231,
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
