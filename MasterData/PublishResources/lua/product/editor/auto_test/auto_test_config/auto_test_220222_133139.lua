AutoTest_220222_133139 = {
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
        action = "AddMonster",
        args = {
          dir = 5,
          disableai = true,
          id = 2100212,
          name = "e1",
          pos = 803
        }
      },
      [4] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 505.0,
            [5] = 506.0,
            [6] = 507.0,
            [7] = 508.0,
            [8] = 509.0,
            [9] = 609.0,
            [10] = 608.0,
            [11] = 607.0,
            [12] = 606.0,
            [13] = 605.0,
            [14] = 604.0,
            [15] = 603.0,
            [16] = 602.0
          },
          pieceType = 1
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [6] = {
        action = "SetPieceType",
        args = {pieceType = 3}
      },
      [7] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "normalSkillAbsorbParam",
          attr_select_index = 15,
          defname = "e1",
          key = "CalcDamage_1",
          key_select_index = 5,
          skillid = 100132,
          trigger = 102,
          varname = "v1"
        }
      },
      [8] = {
        action = "CheckLocalValue",
        args = {
          target = 1.0,
          trigger = 88,
          varname = "v1"
        }
      },
      [9] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 602.0,
            [2] = 702.0,
            [3] = 703.0,
            [4] = 704.0,
            [5] = 705.0
          },
          pieceType = 3
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "被动强化：极光时刻期间，走任何格子都能施放连锁技，且视为森属性伤害（非水森的不普攻）"
    }
  },
  name = "爱洛拉觉醒3（普攻）",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1601311,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1501321,
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
