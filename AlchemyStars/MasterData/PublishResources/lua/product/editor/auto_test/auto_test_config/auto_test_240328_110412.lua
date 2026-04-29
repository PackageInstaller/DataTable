AutoTest_240328_110412 = {
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
          pos = 504
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 505
        }
      },
      [5] = {
        action = "SetAllMonstersHP",
        args = {value = 99999}
      },
      [6] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 401.0
          },
          skillIndex = 1
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 501.0,
            [4] = 401.0,
            [5] = 402.0
          },
          pieceType = 1
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "attackPercentage",
          damageIndex = 1,
          defname = "e1",
          key = "FinalAtk",
          skillid = 2232161,
          trigger = 102,
          varname = "v1"
        }
      },
      [11] = {
        action = "CheckLocalValue",
        args = {
          target = 0.03999999910593,
          trigger = 102,
          varname = "v1"
        }
      },
      [12] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "attackPercentage",
          damageIndex = 1,
          defname = "e1",
          key = "FinalAtk",
          skillid = 110216,
          trigger = 102,
          varname = "v2"
        }
      },
      [13] = {
        action = "CheckLocalValue",
        args = {
          target = 0.03999999910593,
          trigger = 102,
          varname = "v2"
        }
      },
      [14] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 402.0,
            [2] = 302.0,
            [3] = 303.0,
            [4] = 403.0,
            [5] = 503.0
          },
          pieceType = 1
        }
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "连锁技放完时，如果站在璇玑处于结界内，获得4%攻击力加成"
    },
    [2] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [3] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 605.0
          },
          skillIndex = 1
        }
      },
      [4] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [5] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 503.0,
            [2] = 603.0,
            [3] = 703.0,
            [4] = 803.0,
            [5] = 804.0
          },
          pieceType = 1
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 804.0,
            [2] = 904.0,
            [3] = 805.0,
            [4] = 704.0,
            [5] = 705.0
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
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 705.0,
            [2] = 805.0,
            [3] = 704.0,
            [4] = 703.0,
            [5] = 604.0
          },
          pieceType = 1
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
          damageIndex = 1,
          defname = "e1",
          key = "FinalAtk",
          skillid = 2232161,
          trigger = 102,
          varname = "v3"
        }
      },
      [13] = {
        action = "CheckLocalValue",
        args = {
          target = 0.20000000298023,
          trigger = 102,
          varname = "v3"
        }
      },
      [14] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "attackPercentage",
          damageIndex = 1,
          defname = "e1",
          key = "FinalAtk",
          skillid = 100216,
          trigger = 102,
          varname = "v4"
        }
      },
      [15] = {
        action = "CheckLocalValue",
        args = {
          target = 0.20000000298023,
          trigger = 102,
          varname = "v4"
        }
      },
      [16] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 604.0,
            [2] = 503.0,
            [3] = 403.0,
            [4] = 303.0,
            [5] = 204.0
          },
          pieceType = 1
        }
      },
      [17] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "连锁技放完时，如果站在璇玑处于结界内，获得4%攻击力加成，可叠5层。"
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
          attr = "attackPercentage",
          damageIndex = 1,
          defname = "e1",
          key = "FinalAtk",
          skillid = 2232161,
          trigger = 102,
          varname = "v5"
        }
      },
      [4] = {
        action = "CheckLocalValue",
        args = {
          target = 0.079999998211861,
          trigger = 102,
          varname = "v5"
        }
      },
      [5] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "attackPercentage",
          damageIndex = 1,
          defname = "e1",
          key = "FinalAtk",
          skillid = 100216,
          trigger = 102,
          varname = "v6"
        }
      },
      [6] = {
        action = "CheckLocalValue",
        args = {
          target = 0.079999998211861,
          trigger = 102,
          varname = "v6"
        }
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 204.0,
            [2] = 303.0,
            [3] = 304.0,
            [4] = 403.0,
            [5] = 503.0
          },
          pieceType = 1
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "如果回合结束时，不在范围内，层数减半（向下取整）。"
    }
  },
  name = "璇极觉醒3",
  petList = {
    [1] = {
      awakening = 3,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 3,
      id = 1602161,
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
