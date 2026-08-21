AutoTest_220221_111452 = {
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
        action = "AddMonster",
        args = {
          dir = 5,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 804
        }
      },
      [5] = {
        action = "SetPieceType",
        args = {pieceType = 4}
      },
      [6] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 1,
          pos = 405,
          trigger = 88
        }
      },
      [7] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 1,
          pos = 606,
          trigger = 88
        }
      },
      [8] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 1,
          pos = 903,
          trigger = 88
        }
      },
      [9] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 207,
          trigger = 88
        }
      },
      [10] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 405.0,
            [2] = 606.0,
            [3] = 903.0,
            [4] = 207.0
          }
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [12] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "attackPercentage",
          attr_select_index = 12,
          defname = "e1",
          key = "FinalAtk",
          key_select_index = 3,
          skillid = 100077,
          trigger = 102,
          varname = "v1"
        }
      },
      [13] = {
        action = "CheckLocalValue",
        args = {
          target = 0.03999999910593,
          trigger = 88,
          varname = "v1"
        }
      },
      [14] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "attackPercentage",
          attr_select_index = 12,
          defname = "e1",
          key = "FinalAtk",
          key_select_index = 3,
          skillid = 210771,
          trigger = 102,
          varname = "v2"
        }
      },
      [15] = {
        action = "CheckLocalValue",
        args = {
          target = 0.03999999910593,
          trigger = 88,
          varname = "v2"
        }
      },
      [16] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 702.0,
            [4] = 703.0,
            [5] = 704.0
          },
          pieceType = 4
        }
      },
      [17] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "施放主动技后，本回合提高伯利恒XXX%的基础攻击力"
    }
  },
  name = "伯利恒觉醒1",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 1,
      id = 1600771,
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
