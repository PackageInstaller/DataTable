AutoTest_221028_134828 = {
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
        args = {buffID = 103901, name = "e1"}
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
          key = "CalcDamage_15",
          skillid = 20021,
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
          defname = "e2",
          key = "CalcDamage_15",
          skillid = 20021,
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
            [2] = 402.0,
            [3] = 302.0,
            [4] = 303.0,
            [5] = 403.0,
            [6] = 503.0,
            [7] = 504.0
          },
          pieceType = 1
        }
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "受到的中毒dot伤害提高3倍"
    }
  },
  name = "恐惧中毒 ",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1500751,
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
