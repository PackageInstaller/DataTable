AutoTest_230515_111606 = {
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
          pos = 305
        }
      },
      [4] = {
        action = "SetAllMonstersHP",
        args = {value = 100000}
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [6] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 503.0,
            [4] = 402.0,
            [5] = 403.0
          },
          pieceType = 1
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
            [1] = 403.0,
            [2] = 302.0,
            [3] = 301.0,
            [4] = 202.0,
            [5] = 303.0
          },
          pieceType = 1
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [11] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 303.0,
            [2] = 202.0,
            [3] = 301.0,
            [4] = 302.0,
            [5] = 401.0
          },
          pieceType = 1
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [13] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 401.0,
            [2] = 501.0,
            [3] = 601.0,
            [4] = 602.0,
            [5] = 603.0,
            [6] = 604.0
          },
          pieceType = 1
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [15] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [16] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 604.0,
            [2] = 504.0,
            [3] = 503.0,
            [4] = 403.0,
            [5] = 404.0
          },
          pieceType = 1
        }
      },
      [17] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 5,
          layerType = 4300231,
          name = "p1",
          trigger = 88
        }
      },
      [18] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [19] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 2,
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 230231,
          trigger = 102,
          varname = "v1"
        }
      },
      [20] = {
        action = "CheckLocalValue",
        args = {
          target = 1.5499999523163,
          trigger = 88,
          varname = "v1"
        }
      },
      [21] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 404.0,
            [2] = 304.0,
            [3] = 204.0,
            [4] = 104.0,
            [5] = 105.0
          },
          pieceType = 1
        }
      },
      [22] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "被动强化：若已有5层印记，施放连锁时会额外对最近目标进行一次连锁伤害"
    }
  },
  name = "克娜莉觉醒Ⅲ",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 3,
      id = 1600231,
      level = 20,
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
