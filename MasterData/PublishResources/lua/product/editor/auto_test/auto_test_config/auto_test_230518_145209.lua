AutoTest_230518_145209 = {
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
          id = 2000524,
          name = "e1",
          pos = 505
        }
      },
      [4] = {
        action = "SetAllMonstersHP",
        args = {value = 100000}
      },
      [5] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 604.0,
            [5] = 705.0,
            [6] = 706.0,
            [7] = 607.0,
            [8] = 507.0,
            [9] = 406.0,
            [10] = 405.0,
            [11] = 404.0
          },
          pieceType = 1
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [8] = {
        action = "SetAllMonstersHP",
        args = {value = 1000000}
      },
      [9] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 404.0,
            [2] = 504.0,
            [3] = 604.0,
            [4] = 705.0,
            [5] = 706.0,
            [6] = 607.0,
            [7] = 507.0,
            [8] = 406.0,
            [9] = 405.0
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
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 405.0,
            [2] = 404.0,
            [3] = 504.0,
            [4] = 604.0,
            [5] = 705.0,
            [6] = 706.0,
            [7] = 607.0,
            [8] = 507.0,
            [9] = 406.0
          },
          pieceType = 1
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [14] = {
        action = "SetAllMonstersHP",
        args = {value = 1000000}
      },
      [15] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [16] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 406.0,
            [2] = 306.0,
            [3] = 206.0,
            [4] = 205.0,
            [5] = 106.0,
            [6] = 105.0,
            [7] = 204.0,
            [8] = 305.0
          },
          pieceType = 1
        }
      },
      [17] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [18] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 305.0,
            [2] = 304.0,
            [3] = 303.0,
            [4] = 203.0,
            [5] = 103.0,
            [6] = 202.0,
            [7] = 301.0,
            [8] = 302.0,
            [9] = 401.0,
            [10] = 402.0,
            [11] = 403.0,
            [12] = 504.0
          },
          pieceType = 1
        }
      },
      [19] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [20] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "skillIncreaseParam",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 210981,
          trigger = 102,
          varname = "v1"
        }
      },
      [21] = {
        action = "CheckLocalValue",
        args = {
          target = 1.6000000238419,
          trigger = 88,
          varname = "v1"
        }
      },
      [22] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 504.0,
            [2] = 503.0,
            [3] = 502.0,
            [4] = 602.0,
            [5] = 702.0,
            [6] = 703.0,
            [7] = 704.0,
            [8] = 705.0
          },
          pieceType = 1
        }
      },
      [23] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 10,
          layerType = 410098,
          name = "e1",
          trigger = 0
        }
      },
      [24] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "被动最大层数提高到10，系数提高到0.06"
    }
  },
  name = "库斯库塔精炼Ⅱ",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 2,
      equiplv = 10,
      grade = 3,
      id = 1500981,
      level = 80,
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
