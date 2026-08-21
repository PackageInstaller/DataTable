AutoTest_221024_212439 = {
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
        args = {name = "team", pos = 505}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 507
        }
      },
      [5] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "defencePercentage",
          damageIndex = 1,
          defname = "e1",
          key = "FinalDef",
          skillid = 100007,
          trigger = 102,
          varname = "v1"
        }
      },
      [6] = {
        action = "CheckLocalValue",
        args = {
          target = 0.0,
          trigger = 88,
          varname = "v1"
        }
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 505.0,
            [2] = 506.0,
            [3] = 405.0
          },
          pieceType = 1
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [9] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [10] = {
        action = "AddBuffToEntity",
        args = {buffID = 103601, name = "e1"}
      },
      [11] = {
        action = "AddBuffToEntity",
        args = {buffID = 103602, name = "e1"}
      },
      [12] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [14] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "defencePercentage",
          damageIndex = 1,
          defname = "e1",
          key = "FinalDef",
          skillid = 100007,
          trigger = 102,
          varname = "v2"
        }
      },
      [15] = {
        action = "CheckLocalValue",
        args = {
          target = 0.20000000298023,
          trigger = 102,
          varname = "v2"
        }
      },
      [16] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 405.0,
            [2] = 406.0,
            [3] = 306.0,
            [4] = 307.0,
            [5] = 407.0
          },
          pieceType = 1
        }
      },
      [17] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "队伍连线每移动一格，敌人获得1层防御提高的效果，该效果回合结束清空（每层5%）"
    }
  },
  name = "移动之盾",
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
