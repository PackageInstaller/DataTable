AutoTest_220225_164746 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetPieceType",
        args = {pieceType = 4}
      },
      [3] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 502}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 2100212,
          name = "e2",
          pos = 304
        }
      },
      [5] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e2",
          trigger = 88
        }
      },
      [6] = {
        action = "CheckFormulaAttr",
        args = {
          attr = "damagePercent",
          attr_select_index = 9,
          defname = "e2",
          expect = 1.4700000286102,
          key = "CalcDamage_4",
          key_select_index = 8,
          skillid = 2001401,
          trigger = 102
        }
      },
      [7] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          attr_select_index = 9,
          defname = "e2",
          key = "CalcDamage_4",
          key_select_index = 8,
          skillid = 2001341,
          trigger = 102,
          varname = "v1"
        }
      },
      [8] = {
        action = "CheckLocalValue",
        args = {
          target = 1.7200000286102,
          trigger = 88,
          varname = "v1"
        }
      },
      [9] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 501.0,
            [3] = 401.0,
            [4] = 301.0,
            [5] = 302.0
          },
          pieceType = 4
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "所有雷属性光灵的连锁技伤害系数提高a/b/c（分别对应个阶段的值，加法处理）"
    },
    [2] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 2100212,
          name = "e4",
          pos = 206
        }
      },
      [3] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e4",
          trigger = 88
        }
      },
      [4] = {
        action = "CheckFormulaAttr",
        args = {
          attr = "damagePercent",
          attr_select_index = 9,
          defname = "e4",
          expect = 1.5900000333786,
          key = "CalcDamage_4",
          key_select_index = 8,
          skillid = 2001402,
          trigger = 102
        }
      },
      [5] = {
        action = "CheckFormulaAttr",
        args = {
          attr = "damagePercent",
          attr_select_index = 9,
          defname = "e4",
          expect = 1.789999961853,
          key = "CalcDamage_4",
          key_select_index = 8,
          skillid = 2001342,
          trigger = 102
        }
      },
      [6] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 302.0,
            [2] = 303.0,
            [3] = 403.0,
            [4] = 404.0,
            [5] = 405.0,
            [6] = 406.0,
            [7] = 506.0,
            [8] = 507.0,
            [9] = 407.0,
            [10] = 408.0
          },
          pieceType = 4
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "所有雷属性光灵的连锁技伤害系数提高a/b/c（分别对应个阶段的值，加法处理）"
    },
    [3] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 2100212,
          name = "e6",
          pos = 905
        }
      },
      [3] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e6",
          trigger = 88
        }
      },
      [4] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          attr_select_index = 9,
          defname = "e6",
          key = "CalcDamage_4",
          key_select_index = 8,
          skillid = 2001403,
          trigger = 102,
          varname = "v2"
        }
      },
      [5] = {
        action = "CheckLocalValue",
        args = {
          target = 1.710000038147,
          trigger = 88,
          varname = "v2"
        }
      },
      [6] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          attr_select_index = 9,
          defname = "e6",
          key = "CalcDamage_4",
          key_select_index = 8,
          skillid = 2001343,
          trigger = 102,
          varname = "v3"
        }
      },
      [7] = {
        action = "CheckLocalValue",
        args = {
          target = 1.8600000143051,
          trigger = 88,
          varname = "v3"
        }
      },
      [8] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 408.0,
            [2] = 508.0,
            [3] = 608.0,
            [4] = 708.0,
            [5] = 707.0,
            [6] = 607.0,
            [7] = 706.0,
            [8] = 606.0,
            [9] = 605.0,
            [10] = 705.0,
            [11] = 805.0,
            [12] = 804.0,
            [13] = 703.0
          },
          pieceType = 4
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "所有雷属性光灵的连锁技伤害系数提高a/b/c（分别对应个阶段的值，加法处理）"
    }
  },
  name = "芙罗琳觉醒1",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 1,
      id = 1601401,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1601341,
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
