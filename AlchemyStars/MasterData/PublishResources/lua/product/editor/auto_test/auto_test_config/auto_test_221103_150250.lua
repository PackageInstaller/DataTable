AutoTest_221103_150250 = {
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
          disableai = false,
          id = 5102711,
          name = "e1",
          pos = 305
        }
      },
      [4] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "team",
          key = "CalcDamage_11",
          skillid = 9100121,
          trigger = 102,
          varname = "v1"
        }
      },
      [5] = {
        action = "CheckLocalValue",
        args = {
          target = 0.050000000745058,
          trigger = 102,
          varname = "v1"
        }
      },
      [6] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "怪物攻击时附带玩家当前血量5%的伤害。"
    }
  },
  name = "40007嗜血屠杀",
  petList = {
    [1] = {
      awakening = 6,
      equiplv = 10,
      grade = 3,
      id = 1601481,
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
