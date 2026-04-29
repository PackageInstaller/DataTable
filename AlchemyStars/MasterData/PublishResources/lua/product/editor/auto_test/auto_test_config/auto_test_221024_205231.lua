AutoTest_221024_205231 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "team"}
      },
      [3] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 506}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 5100111,
          name = "e1",
          pos = 507
        }
      },
      [5] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "attackPercentage",
          damageIndex = 1,
          defname = "team",
          key = "FinalAtk",
          skillid = 1002801,
          trigger = 102,
          varname = "v1"
        }
      },
      [6] = {
        action = "CheckLocalValue",
        args = {
          target = 0.0,
          trigger = 102,
          varname = "v1"
        }
      },
      [7] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Mobility",
          expect = 2.0,
          name = "e1",
          trigger = 102
        }
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
        action = "AddBuffToEntity",
        args = {buffID = 10370101, name = "e1"}
      },
      [11] = {
        action = "AddBuffToEntity",
        args = {buffID = 10370102, name = "e1"}
      },
      [12] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 506.0,
            [2] = 505.0,
            [3] = 504.0,
            [4] = 503.0,
            [5] = 502.0,
            [6] = 501.0
          },
          pieceType = 1
        }
      },
      [13] = {
        action = "CheckEntityBuffValue",
        args = {
          key = "HPShield",
          name = "e1",
          trigger = 102,
          value = 157.88999938965
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [15] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Mobility",
          expect = 3.0,
          name = "e1",
          trigger = 102
        }
      },
      [16] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "attackPercentage",
          damageIndex = 1,
          defname = "team",
          key = "FinalAtk",
          skillid = 1002801,
          trigger = 102,
          varname = "v2"
        }
      },
      [17] = {
        action = "CheckLocalValue",
        args = {
          target = 0.029999999329448,
          trigger = 102,
          varname = "v2"
        }
      },
      [18] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [19] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "每回合刷新一个3%最大血量的数值护盾，如果护盾未被打破，则提高3%攻击力及1点行动力(怪物血量5263)"
    }
  },
  name = "祝福Ⅰ",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1400071,
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
