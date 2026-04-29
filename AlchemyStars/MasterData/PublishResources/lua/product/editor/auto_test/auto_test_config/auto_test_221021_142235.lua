AutoTest_221021_142235 = {
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
        args = {name = "team"}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 5100111,
          name = "e1",
          pos = 505
        }
      },
      [5] = {
        action = "SetEntityHP",
        args = {hp = 100000, name = "e1"}
      },
      [6] = {
        action = "AddBuffToEntity",
        args = {buffID = 10440301, name = "e1"}
      },
      [7] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 10440301,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [8] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_10",
          skillid = 10440302,
          trigger = 102,
          varname = "v1"
        }
      },
      [9] = {
        action = "CheckLocalValue",
        args = {
          target = 0.5,
          trigger = 102,
          varname = "v1"
        }
      },
      [10] = {
        action = "SetPieceType",
        args = {pieceType = 2}
      },
      [11] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 505.0
          }
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [13] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "怪物将要受到恐惧、眩晕或麻痹的效果时，免疫本次控制，改为流失50%最大血量"
    }
  },
  name = "转伤Ⅲ",
  petList = {
    [1] = {
      awakening = 5,
      equiplv = 10,
      grade = 3,
      id = 1500901,
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
