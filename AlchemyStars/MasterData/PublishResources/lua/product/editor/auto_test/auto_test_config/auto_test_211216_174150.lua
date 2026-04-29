AutoTest_211216_174150 = {
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
          attr = "skillFinalParam",
          attr_select_index = 10,
          defname = "e1",
          key = "CalcDamage_5",
          key_select_index = 8,
          skillid = 305055,
          trigger = 102,
          varname = "v1"
        }
      },
      [6] = {
        action = "CheckLocalValue",
        args = {
          target = 1.25,
          trigger = 88,
          varname = "v1"
        }
      },
      [7] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 503.0
          }
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "1.突5:主动技强化：击退越远伤害越高（每格增加5%最终伤害）"
    }
  },
  name = "彼亚塔曼突5",
  petList = {
    [1] = {
      awakening = 5,
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
