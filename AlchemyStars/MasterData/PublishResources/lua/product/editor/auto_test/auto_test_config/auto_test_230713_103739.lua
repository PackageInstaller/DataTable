AutoTest_230713_103739 = {
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
        args = {name = "team"}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 305
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 505
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 705
        }
      },
      [7] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 806.0
          },
          skillIndex = 1
        }
      },
      [8] = {
        action = "SetAllMonstersHP",
        args = {value = 100000}
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e3",
          key = "CalcDamage_4",
          skillid = 2002051,
          trigger = 102,
          varname = "v1"
        }
      },
      [11] = {
        action = "CheckLocalValue",
        args = {
          target = 1.3999999761581,
          trigger = 88,
          varname = "v1"
        }
      },
      [12] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 702.0,
            [4] = 802.0,
            [5] = 803.0,
            [6] = 804.0,
            [7] = 805.0
          },
          pieceType = 1
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [14] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e3",
          key = "CalcDamage_4",
          skillid = 2002052,
          trigger = 102,
          varname = "v3"
        }
      },
      [15] = {
        action = "CheckLocalValue",
        args = {
          target = 1.4500000476837,
          trigger = 88,
          varname = "v3"
        }
      },
      [16] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 805.0,
            [2] = 905.0,
            [3] = 906.0,
            [4] = 907.0,
            [5] = 807.0,
            [6] = 707.0,
            [7] = 607.0,
            [8] = 606.0,
            [9] = 605.0,
            [10] = 706.0
          },
          pieceType = 1
        }
      },
      [17] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [18] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [19] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e3",
          key = "CalcDamage_4",
          skillid = 2002053,
          trigger = 102,
          varname = "v2"
        }
      },
      [20] = {
        action = "CheckLocalValue",
        args = {
          target = 1.5,
          trigger = 88,
          varname = "v2"
        }
      },
      [21] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 706.0,
            [2] = 606.0,
            [3] = 506.0,
            [4] = 406.0,
            [5] = 405.0,
            [6] = 404.0,
            [7] = 403.0,
            [8] = 402.0,
            [9] = 401.0,
            [10] = 501.0,
            [11] = 601.0,
            [12] = 701.0,
            [13] = 702.0,
            [14] = 703.0,
            [15] = 803.0,
            [16] = 903.0,
            [17] = 904.0,
            [18] = 804.0
          },
          pieceType = 1
        }
      },
      [22] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "觉2强化：改为2/3/4"
    }
  },
  name = "sp白兰突破5",
  petList = {
    [1] = {
      awakening = 5,
      equipRefineLv = 0,
      equiplv = 0,
      grade = 0,
      id = 1502051,
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
