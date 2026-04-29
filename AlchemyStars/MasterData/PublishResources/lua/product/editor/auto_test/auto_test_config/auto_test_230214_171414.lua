AutoTest_230214_171414 = {
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
          pos = 806
        }
      },
      [4] = {
        action = "SetAllMonstersHP",
        args = {value = 1000000}
      },
      [5] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 2201841,
          trigger = 102,
          varname = "v1"
        }
      },
      [6] = {
        action = "CheckLocalValue",
        args = {
          target = 1.5,
          trigger = 102,
          varname = "v1"
        }
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 702.0,
            [4] = 803.0,
            [5] = 804.0
          },
          pieceType = 1
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [9] = {
        action = "CheckTrapCount",
        args = {
          expect = 0,
          trapIDs = {
            [1] = 14.0
          },
          trigger = 0
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "连锁技强化：范围内随机0/1/2个格子上产生强化格"
    },
    [2] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 2201842,
          trigger = 102,
          varname = "v2"
        }
      },
      [3] = {
        action = "CheckLocalValue",
        args = {
          target = 1.6000000238419,
          trigger = 102,
          varname = "v2"
        }
      },
      [4] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 804.0,
            [2] = 704.0,
            [3] = 604.0,
            [4] = 703.0,
            [5] = 603.0,
            [6] = 503.0,
            [7] = 504.0,
            [8] = 505.0,
            [9] = 506.0,
            [10] = 605.0,
            [11] = 705.0
          },
          pieceType = 1
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [6] = {
        action = "CheckTrapCount",
        args = {
          expect = 1,
          trapIDs = {
            [1] = 14.0
          },
          trigger = 0
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "耶利亚连锁技Ⅱ  对米字形16格造成160%攻击力的伤害。"
    },
    [3] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [3] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 2201843,
          trigger = 102,
          varname = "v3"
        }
      },
      [4] = {
        action = "CheckLocalValue",
        args = {
          target = 1.7000000476837,
          trigger = 102,
          varname = "v3"
        }
      },
      [5] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 705.0,
            [2] = 606.0,
            [3] = 506.0,
            [4] = 406.0,
            [5] = 306.0,
            [6] = 206.0,
            [7] = 106.0,
            [8] = 107.0,
            [9] = 208.0,
            [10] = 207.0,
            [11] = 307.0,
            [12] = 407.0,
            [13] = 507.0,
            [14] = 607.0
          },
          pieceType = 1
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "CheckTrapCount",
        args = {
          expect = 3,
          trapIDs = {
            [1] = 14.0
          },
          trigger = 0
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "耶利亚连锁技Ⅲ   对周围2圈造成170%攻击力的伤害。"
    }
  },
  name = "耶利亚觉醒Ⅱ",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 2,
      id = 1601841,
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
