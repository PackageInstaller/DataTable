AutoTest_220224_182005 = {
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
        action = "SetOnePieceType",
        args = {pieceType = 4, pos = 303}
      },
      [4] = {
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 303
        }
      },
      [6] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "skillIncreaseParam",
          attr_select_index = 10,
          defname = "e1",
          key = "CalcDamage_5",
          key_select_index = 9,
          skillid = 300134,
          trigger = 102,
          varname = "v1"
        }
      },
      [7] = {
        action = "CheckLocalValue",
        args = {
          target = 1.0125000476837,
          trigger = 88,
          varname = "v1"
        }
      },
      [8] = {
        action = "FakeCastSkill",
        args = {
          name = "p2",
          pickUpPos = {
            [1] = 106.0
          }
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "被动强化：雷属性光灵享受本卡一半系数的加成"
    }
  },
  name = "艾莉法觉醒3",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1501391,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1601341,
      level = 1,
      name = "p2"
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
