AutoTest_220224_180635 = {
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
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [4] = {
        action = "SetPieceType",
        args = {pieceType = 4}
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 504
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 509
        }
      },
      [7] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 501
        }
      },
      [8] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [9] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e2",
          trigger = 88
        }
      },
      [10] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e3",
          trigger = 88
        }
      },
      [11] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "skillIncreaseParam",
          attr_select_index = 10,
          defname = "e1",
          key = "CalcDamage_5",
          key_select_index = 9,
          skillid = 300139,
          trigger = 102,
          varname = "v1"
        }
      },
      [12] = {
        action = "CheckLocalValue",
        args = {
          target = 1.0249999761581,
          trigger = 88,
          varname = "v1"
        }
      },
      [13] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "skillIncreaseParam",
          attr_select_index = 10,
          defname = "e2",
          key = "CalcDamage_5",
          key_select_index = 9,
          skillid = 300139,
          trigger = 102,
          varname = "v2"
        }
      },
      [14] = {
        action = "CheckLocalValue",
        args = {
          target = 1.1499999761581,
          trigger = 88,
          varname = "v2"
        }
      },
      [15] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 503.0
          }
        }
      },
      [16] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "对所选方向及相邻两列格子上的敌人造成伤害，范围内非雷属性的格子将被重置（雷格子出率0.12~0.2）"
    }
  },
  name = "艾莉法觉醒1",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 1,
      id = 1501391,
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
