AutoTest_230511_171757 = {
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
          pos = 305
        }
      },
      [4] = {
        action = "SetAllMonstersHP",
        args = {value = 100000}
      },
      [5] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_5",
          skillid = 3420901,
          trigger = 102,
          varname = "v1"
        }
      },
      [6] = {
        action = "CheckLocalValue",
        args = {
          target = 6.0,
          trigger = 88,
          varname = "v1"
        }
      },
      [7] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          },
          skillIndex = 2
        }
      },
      [8] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 10011,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [9] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Power",
          expect = 5.0,
          name = "p1",
          trigger = 88
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "主动技新增变体1：cd+1，全场无视格子颜色眩晕，技能倍率600%"
    }
  },
  name = "芭芭拉精炼Ⅱ",
  petList = {
    [1] = {
      awakening = 5,
      equipRefineLv = 2,
      equiplv = 10,
      grade = 3,
      id = 1500901,
      level = 80,
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
