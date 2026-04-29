AutoTest_221102_185326 = {
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
          pos = 507
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 509
        }
      },
      [5] = {
        action = "AddBuffToEntity",
        args = {buffID = 10090201, name = "e1"}
      },
      [6] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "team"}
      },
      [9] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "finalAtk",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_13",
          skillid = 20031,
          trigger = 102,
          varname = "v1"
        }
      },
      [10] = {
        action = "CheckLocalValue",
        args = {
          target = 158.0,
          trigger = 102,
          varname = "v1"
        }
      },
      [11] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "finalAtk",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_13",
          skillid = 20031,
          trigger = 102,
          varname = "v2"
        }
      },
      [12] = {
        action = "CheckLocalValue",
        args = {
          target = 53.0,
          trigger = 102,
          varname = "v2"
        }
      },
      [13] = {
        action = "CompareLocalValue",
        args = {
          cmp = ">",
          key1 = "v1",
          key2 = "v2",
          trigger = 18
        }
      },
      [14] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 603.0,
            [3] = 703.0,
            [4] = 803.0,
            [5] = 903.0,
            [6] = 904.0,
            [7] = 804.0,
            [8] = 704.0,
            [9] = 604.0,
            [10] = 504.0
          },
          pieceType = 1
        }
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "受到的灼烧、中毒和流血伤害提高到正常值的3倍"
    }
  },
  name = "100902 易伤II",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1500211,
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
