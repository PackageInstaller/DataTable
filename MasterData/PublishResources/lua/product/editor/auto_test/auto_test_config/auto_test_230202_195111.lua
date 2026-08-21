AutoTest_230202_195111 = {
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
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 507
        }
      },
      [4] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "defenderFinal",
          damageIndex = 1,
          defname = "e1",
          key = "FinalDamage",
          skillid = 200061,
          trigger = 102,
          varname = "v1"
        }
      },
      [5] = {
        action = "CheckLocalValue",
        args = {
          target = 1.0,
          trigger = 102,
          varname = "v1"
        }
      },
      [6] = {
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
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "AddBuffToEntity",
        args = {buffID = 103501, name = "e1"}
      },
      [9] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 506.0,
            [2] = 406.0
          },
          pieceType = 1
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [11] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [12] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "defenderFinal",
          damageIndex = 1,
          defname = "e1",
          key = "FinalDamage",
          skillid = 200061,
          trigger = 102,
          varname = "v2"
        }
      },
      [13] = {
        action = "CheckLocalValue",
        args = {
          target = 0.40000000596046,
          trigger = 102,
          varname = "v2"
        }
      },
      [14] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 406.0,
            [2] = 405.0,
            [3] = 505.0,
            [4] = 606.0,
            [5] = 607.0
          },
          pieceType = 1
        }
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [16] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [17] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "defenderFinal",
          damageIndex = 1,
          defname = "e1",
          key = "FinalDamage",
          skillid = 200061,
          trigger = 102,
          varname = "v3"
        }
      },
      [18] = {
        action = "CheckLocalValue",
        args = {
          target = 0.69999998807907,
          trigger = 102,
          varname = "v3"
        }
      },
      [19] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 607.0,
            [2] = 606.0,
            [3] = 706.0,
            [4] = 806.0,
            [5] = 805.0,
            [6] = 705.0,
            [7] = 605.0,
            [8] = 504.0,
            [9] = 505.0
          },
          pieceType = 1
        }
      },
      [20] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [21] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [22] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "defenderFinal",
          damageIndex = 1,
          defname = "e1",
          key = "FinalDamage",
          skillid = 200061,
          trigger = 102,
          varname = "v4"
        }
      },
      [23] = {
        action = "CheckLocalValue",
        args = {
          target = 0.89999997615814,
          trigger = 102,
          varname = "v4"
        }
      },
      [24] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 505.0,
            [2] = 406.0,
            [3] = 306.0,
            [4] = 206.0,
            [5] = 106.0,
            [6] = 105.0,
            [7] = 205.0,
            [8] = 305.0,
            [9] = 405.0,
            [10] = 304.0,
            [11] = 204.0,
            [12] = 203.0,
            [13] = 303.0,
            [14] = 404.0,
            [15] = 504.0
          },
          pieceType = 1
        }
      },
      [25] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [26] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [27] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "defenderFinal",
          damageIndex = 1,
          defname = "e1",
          key = "FinalDamage",
          skillid = 200061,
          trigger = 102,
          varname = "v5"
        }
      },
      [28] = {
        action = "CheckLocalValue",
        args = {
          target = 1.0,
          trigger = 102,
          varname = "v5"
        }
      },
      [29] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 504.0,
            [2] = 604.0,
            [3] = 605.0,
            [4] = 706.0,
            [5] = 806.0,
            [6] = 906.0,
            [7] = 905.0,
            [8] = 904.0,
            [9] = 804.0,
            [10] = 803.0,
            [11] = 802.0,
            [12] = 702.0,
            [13] = 703.0,
            [14] = 603.0,
            [15] = 503.0
          },
          pieceType = 1
        }
      },
      [30] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "受到连锁伤害时，敌人和队伍距离越近，受到的伤害越低（减伤系数：1圈0.6，2圈0.3，3圈0.1，4圈及以上不减伤）"
    }
  },
  name = "弱点隐藏（问题）",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600061,
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
