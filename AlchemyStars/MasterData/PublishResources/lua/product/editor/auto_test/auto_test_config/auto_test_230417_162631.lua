AutoTest_230417_162631 = {
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
        action = "CheckFormulaAttr",
        args = {
          attr = "damagePercent",
          defname = "e1",
          expect = 2.0,
          key = "CalcDamage_5",
          skillid = 3051931,
          trigger = 102
        }
      },
      [5] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 503.0
          },
          skillIndex = 1
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "主动技系数提高到200%"
    }
  },
  name = "克里斯汀突破5",
  petList = {
    [1] = {
      awakening = 5,
      equiplv = 1,
      grade = 0,
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
