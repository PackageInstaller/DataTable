AutoTest_230517_152911 = {
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
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_5",
          skillid = 3300112,
          trigger = 102,
          varname = "v1"
        }
      },
      [5] = {
        action = "CheckLocalValue",
        args = {
          target = 3.5999999046326,
          trigger = 88,
          varname = "v1"
        }
      },
      [6] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          },
          skillIndex = 3
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "MaxPower",
          expect = 4.0,
          name = "p1",
          trigger = 0
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "变体2：CD+1,全屏跳，3圈伤害，伤害360%"
    }
  },
  name = "希罗娜精炼Ⅲ",
  petList = {
    [1] = {
      awakening = 6,
      equipRefineLv = 3,
      equiplv = 10,
      grade = 3,
      id = 1600111,
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
