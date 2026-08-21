AutoTest_221026_152807 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 14,
          name = "qhgz1",
          pos = 505
        }
      },
      [3] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 14,
          name = "qhgz2",
          pos = 504
        }
      },
      [4] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 141,
          name = "rhgz1",
          pos = 503
        }
      },
      [5] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 502}
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 5100111,
          name = "e1",
          pos = 506
        }
      },
      [7] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "e1"}
      },
      [8] = {
        action = "AddBuffToEntity",
        args = {buffID = 10610101, name = "e1"}
      },
      [9] = {
        action = "AddBuffToEntity",
        args = {buffID = 10610102, name = "e1"}
      },
      [10] = {
        action = "AddBuffToEntity",
        args = {buffID = 10610103, name = "e1"}
      },
      [11] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 505.0
          },
          pieceType = 1
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [13] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "attackPercentage",
          damageIndex = 1,
          defname = "p1",
          key = "FinalAtk",
          skillid = 1002801,
          trigger = 102,
          varname = "v1"
        }
      },
      [14] = {
        action = "CheckLocalValue",
        args = {
          target = 0.12999999523163,
          trigger = 88,
          varname = "v1"
        }
      },
      [15] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "defencePercentage",
          damageIndex = 1,
          defname = "e1",
          key = "FinalDef",
          skillid = 100006,
          trigger = 102,
          varname = "v2"
        }
      },
      [16] = {
        action = "CheckLocalValue",
        args = {
          target = 0.12999999523163,
          trigger = 88,
          varname = "v2"
        }
      },
      [17] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [18] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "出生携带10层攻防增加印记，光灵经过强化格子将增加怪物的2层印记，经过弱化格子则减少1层"
    }
  },
  name = "反制协议",
  petList = {
    [1] = {
      awakening = 6,
      equiplv = 10,
      grade = 3,
      id = 1600061,
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
