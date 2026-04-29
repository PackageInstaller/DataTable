AutoTest_211213_190007 = {
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
        action = "SetPieceType",
        args = {pieceType = 4}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 803
        }
      },
      [5] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [6] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          attr_select_index = 8,
          defname = "e1",
          key = "CalcDamage_4",
          key_select_index = 7,
          skillid = 200871,
          trigger = 102,
          varname = "Val1"
        }
      },
      [7] = {
        action = "CheckLocalValue",
        args = {
          target = 1.3999999761581,
          trigger = 88,
          varname = "Val1"
        }
      },
      [8] = {
        action = "CheckFormulaAttr",
        args = {
          attr = "damagePercent",
          attr_select_index = 8,
          defname = "e1",
          expect = 1.3999999761581,
          key = "CalcDamage_4",
          key_select_index = 7,
          skillid = 2001131,
          trigger = 102
        }
      },
      [9] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 402.0,
            [3] = 302.0,
            [4] = 203.0,
            [5] = 303.0,
            [6] = 403.0
          },
          pieceType = 4
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "被动强化：傀儡存在，全队雷属性光灵的连锁技伤害系数提高10%"
    }
  },
  name = "波娜瑟觉醒2",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1500871,
      level = 1,
      name = "p2"
    },
    [2] = {
      awakening = 0,
      equiplv = 1,
      grade = 2,
      id = 1501131,
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
