AutoTest_211213_204122 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetPieceType",
        args = {pieceType = 2}
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 2070421,
          name = "e1",
          pos = 304
        }
      },
      [4] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 303.0
          }
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 2070421,
          name = "e2",
          pos = 704
        }
      },
      [7] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          attr_select_index = 8,
          defname = "e2",
          key = "CalcDamage_4",
          key_select_index = 7,
          skillid = 2001031,
          trigger = 102,
          varname = "Val1"
        }
      },
      [8] = {
        action = "CheckLocalValue",
        args = {
          target = 1.7999999523163,
          trigger = 88,
          varname = "Val1"
        }
      },
      [9] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 303.0,
            [2] = 403.0,
            [3] = 503.0,
            [4] = 603.0,
            [5] = 703.0
          },
          pieceType = 2
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "被动强化：振奋全军，本回合所有火属性光灵连锁技伤害系数增加10%"
    }
  },
  name = "吉纳维芙觉醒3",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1601031,
      level = 1,
      name = "p2"
    },
    [2] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1501141,
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
