AutoTest_221025_154125 = {
  cases = {
    [1] = {
      [1] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "team"}
      },
      [2] = {
        action = "AddMonster",
        args = {
          dir = 5,
          disableai = false,
          id = 2011211,
          name = "e1",
          pos = 508
        }
      },
      [3] = {
        action = "AddBuffToEntity",
        args = {buffID = 10500301, name = "e1"}
      },
      [4] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 501.0,
            [2] = 402.0,
            [3] = 503.0,
            [4] = 504.0,
            [5] = 505.0,
            [6] = 406.0,
            [7] = 407.0
          },
          pieceType = 1
        }
      },
      [5] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "skillFinalParam",
          damageIndex = 1,
          defname = "team",
          key = "CalcDamage_2",
          skillid = 500631,
          trigger = 102,
          varname = "v1"
        }
      },
      [6] = {
        action = "CheckLocalValue",
        args = {
          target = 1.5,
          trigger = 102,
          varname = "v1"
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
        action = "FakeInputDoubleClick",
        args = {}
      },
      [11] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "skillFinalParam",
          damageIndex = 1,
          defname = "team",
          key = "CalcDamage_2",
          skillid = 500634,
          trigger = 102,
          varname = "v2"
        }
      },
      [12] = {
        action = "CheckLocalValue",
        args = {
          target = 1.5,
          trigger = 102,
          varname = "v2"
        }
      },
      [13] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "skillFinalParam",
          damageIndex = 1,
          defname = "team",
          key = "CalcDamage_2",
          skillid = 500636,
          trigger = 102,
          varname = "v3"
        }
      },
      [14] = {
        action = "CheckLocalValue",
        args = {
          target = 1.5,
          trigger = 102,
          varname = "v3"
        }
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "造成的所有伤害均提高50%（怪物造成）"
    },
    [2] = {
      [1] = {
        action = "AddMonster",
        args = {
          dir = 7,
          disableai = false,
          id = 5100111,
          name = "e2",
          pos = 807
        }
      },
      [2] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [3] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "skillFinalParam",
          damageIndex = 1,
          defname = "team",
          key = "CalcDamage_2",
          skillid = 1002801,
          trigger = 102,
          varname = "v4"
        }
      },
      [4] = {
        action = "CheckLocalValue",
        args = {
          target = 1.0,
          trigger = 102,
          varname = "v4"
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "造成的所有伤害均提高50%（怪物造成-无BUFF）"
    }
  },
  name = "105003增伤III",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600061,
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
