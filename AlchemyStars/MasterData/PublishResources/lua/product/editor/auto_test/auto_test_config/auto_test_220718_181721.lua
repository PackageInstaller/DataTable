AutoTest_220718_181721 = {
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
        action = "SetEntityHP",
        args = {hp = 999999, name = "e3"}
      },
      [5] = {
        action = "ModifySanValue",
        args = {modifyValue = -100}
      },
      [6] = {
        action = "CheckSanValue",
        args = {
          compare = "==",
          expect = 0,
          trigger = 88
        }
      },
      [7] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 3,
          defname = "e3",
          key = "CalcDamage_4",
          skillid = 2301517,
          trigger = 102,
          varname = "v1"
        }
      },
      [8] = {
        action = "CheckLocalValue",
        args = {
          target = 0.69999998807907,
          trigger = 88,
          varname = "v1"
        }
      },
      [9] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 4,
          defname = "e3",
          key = "CalcDamage_4",
          skillid = 2301517,
          trigger = 102,
          varname = "v2"
        }
      },
      [10] = {
        action = "CheckLocalValue",
        args = {
          target = 0.55000001192093,
          trigger = 88,
          varname = "v2"
        }
      },
      [11] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 5,
          defname = "e3",
          key = "CalcDamage_4",
          skillid = 2301517,
          trigger = 102,
          varname = "v3"
        }
      },
      [12] = {
        action = "CheckLocalValue",
        args = {
          target = 0.40000000596046,
          trigger = 88,
          varname = "v3"
        }
      },
      [13] = {
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
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "突6：觉3强化:san值为0时额外3次"
    }
  },
  name = "贾尔斯突6",
  petList = {
    [1] = {
      awakening = 6,
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
