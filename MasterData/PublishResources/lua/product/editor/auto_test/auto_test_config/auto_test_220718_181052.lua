AutoTest_220718_181052 = {
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
          id = 2070421,
          name = "e3",
          pos = 706
        }
      },
      [4] = {
        action = "ModifySanValue",
        args = {modifyValue = -75}
      },
      [5] = {
        action = "CheckSanValue",
        args = {
          compare = "==",
          expect = 25,
          trigger = 88
        }
      },
      [6] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 3,
          defname = "e3",
          key = "CalcDamage_4",
          skillid = 2301514,
          trigger = 102,
          varname = "v1"
        }
      },
      [7] = {
        action = "CheckLocalValue",
        args = {
          target = 0.69999998807907,
          trigger = 88,
          varname = "v1"
        }
      },
      [8] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 4,
          defname = "e3",
          key = "CalcDamage_4",
          skillid = 2301514,
          trigger = 102,
          varname = "v2"
        }
      },
      [9] = {
        action = "CheckLocalValue",
        args = {
          target = 0.55000001192093,
          trigger = 88,
          varname = "v2"
        }
      },
      [10] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 505.0,
            [5] = 506.0
          },
          pieceType = 1
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "连锁技强化：san值低于（包括等于）60时，额外造成1次伤害（服从减少规则）；低于25时额外2次伤害"
    }
  },
  name = "贾尔斯觉醒3 25以下",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
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
