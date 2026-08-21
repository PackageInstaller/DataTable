AutoTest_220221_113851 = {
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
          dir = 5,
          disableai = true,
          id = 2071313,
          name = "e1",
          pos = 406
        }
      },
      [6] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 503.0,
            [2] = 504.0,
            [3] = 505.0,
            [4] = 506.0
          }
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "attackConstantFix",
          attr_select_index = 13,
          defname = "e1",
          key = "FinalAtk",
          key_select_index = 3,
          skillid = 100023,
          trigger = 102,
          varname = "v1"
        }
      },
      [9] = {
        action = "CheckLocalValue",
        args = {
          target = 36.599998474121,
          trigger = 88,
          varname = "v1"
        }
      },
      [10] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "attackConstantFix",
          attr_select_index = 13,
          defname = "e1",
          key = "FinalAtk",
          key_select_index = 3,
          skillid = 200231,
          trigger = 102,
          varname = "v2"
        }
      },
      [11] = {
        action = "CheckLocalValue",
        args = {
          target = 36.599998474121,
          trigger = 88,
          varname = "v2"
        }
      },
      [12] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 505.0,
            [5] = 506.0
          },
          pieceType = 1
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "被动强化：所有水属性光灵获得一半效果的加成（基于伯利恒的基础攻击力）"
    }
  },
  name = "伯利恒觉醒3",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1600771,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600231,
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
