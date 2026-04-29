AutoTest_230506_144650 = {
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
          id = 2051313,
          name = "e1",
          pos = 506
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 2051313,
          name = "e2",
          pos = 204
        }
      },
      [5] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "skillFinalParam",
          damageIndex = 1,
          defname = "e2",
          key = "CalcDamage_4",
          skillid = 2201992,
          trigger = 102,
          varname = "v1"
        }
      },
      [6] = {
        action = "CheckLocalValue",
        args = {
          target = 1.0599999427795,
          trigger = 88,
          varname = "v1"
        }
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 404.0,
            [4] = 505.0,
            [5] = 405.0,
            [6] = 406.0,
            [7] = 407.0,
            [8] = 508.0,
            [9] = 509.0
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
            [1] = 509.0,
            [2] = 508.0,
            [3] = 608.0,
            [4] = 707.0,
            [5] = 706.0,
            [6] = 605.0,
            [7] = 505.0,
            [8] = 406.0,
            [9] = 407.0
          },
          pieceType = 1
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [12] = {
        action = "SetAllMonstersHP",
        args = {value = 1000000}
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [14] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [15] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 407.0,
            [2] = 508.0,
            [3] = 608.0,
            [4] = 707.0,
            [5] = 706.0,
            [6] = 605.0,
            [7] = 505.0,
            [8] = 406.0
          },
          pieceType = 1
        }
      },
      [16] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [17] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [18] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 406.0,
            [2] = 407.0,
            [3] = 508.0,
            [4] = 608.0,
            [5] = 707.0,
            [6] = 706.0,
            [7] = 605.0,
            [8] = 505.0
          },
          pieceType = 1
        }
      },
      [19] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [20] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [21] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 505.0,
            [2] = 406.0,
            [3] = 407.0,
            [4] = 508.0,
            [5] = 608.0,
            [6] = 707.0,
            [7] = 706.0,
            [8] = 605.0
          },
          pieceType = 1
        }
      },
      [22] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [23] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [24] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 605.0,
            [2] = 505.0,
            [3] = 406.0,
            [4] = 407.0,
            [5] = 508.0,
            [6] = 608.0,
            [7] = 707.0,
            [8] = 706.0
          },
          pieceType = 1
        }
      },
      [25] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 20,
          layerType = 4201992,
          name = "e1",
          trigger = 0
        }
      },
      [26] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "普攻对目标附加创伤标记，最大20层，连锁技优先攻击场上标记数最多且血最高的目标，每层提高3%最终伤害(标记不清空)"
    }
  },
  name = "莺歌觉醒Ⅱ",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 2,
      id = 1601991,
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
