AutoTest_220801_135311 = {
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
        action = "CheckEntityAttribute",
        args = {
          attr = "Ready",
          expect = 0.0,
          name = "p1",
          trigger = 0
        }
      },
      [4] = {
        action = "FakeInputDoubleClick",
        args = {}
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
          id = 5100111,
          name = "e1",
          pos = 202
        }
      },
      [7] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 504
        }
      },
      [8] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e1",
          trigger = 88
        }
      },
      [9] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e2",
          trigger = 88
        }
      },
      [10] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 2,
          pos = 202,
          trigger = 88
        }
      },
      [11] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 2,
          pos = 402,
          trigger = 88
        }
      },
      [12] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Ready",
          expect = 1.0,
          name = "p1",
          trigger = 0
        }
      },
      [13] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 302.0
          }
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [15] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_108",
          skillid = 4101641,
          trigger = 102,
          varname = "v1"
        }
      },
      [16] = {
        action = "CheckLocalValue",
        args = {
          target = 0.15000000596046,
          trigger = 88,
          varname = "v1"
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
      name = "卡莲的普攻命中火属性格子上的敌人，会附加基础攻击XX%的真伤"
    }
  },
  name = "sp卡莲觉醒1",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 1,
      id = 1601641,
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
