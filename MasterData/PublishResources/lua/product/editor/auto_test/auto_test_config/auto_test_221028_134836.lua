AutoTest_221028_134836 = {
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
        args = {buffID = 104001, name = "e1"}
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
          target = 72.0,
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
          target = 17.0,
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
            [2] = 402.0,
            [3] = 302.0,
            [4] = 202.0,
            [5] = 203.0,
            [6] = 303.0,
            [7] = 403.0,
            [8] = 503.0,
            [9] = 504.0,
            [10] = 505.0,
            [11] = 605.0,
            [12] = 606.0,
            [13] = 607.0,
            [14] = 608.0
          },
          pieceType = 1
        }
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "受到的流血dot伤害提高3倍"
    }
  },
  name = "恐惧流血",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600191,
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
