AutoTest_230512_112617 = {
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
          pos = 303
        }
      },
      [4] = {
        action = "SetAllMonstersHP",
        args = {value = 1000000}
      },
      [5] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 503.0,
            [4] = 604.0,
            [5] = 603.0,
            [6] = 703.0,
            [7] = 702.0,
            [8] = 601.0,
            [9] = 501.0,
            [10] = 402.0
          },
          pieceType = 1
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "skillIncreaseParam",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_1",
          skillid = 100046,
          trigger = 102,
          varname = "v1"
        }
      },
      [8] = {
        action = "CheckLocalValue",
        args = {
          target = 1.0720000267029,
          trigger = 88,
          varname = "v1"
        }
      },
      [9] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "skillIncreaseParam",
          damageIndex = 1,
          defname = "e2",
          key = "CalcDamage_1",
          skillid = 100089,
          trigger = 102,
          varname = "v2"
        }
      },
      [10] = {
        action = "CheckLocalValue",
        args = {
          target = 1.0360000133514,
          trigger = 88,
          varname = "v2"
        }
      },
      [11] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 402.0,
            [2] = 403.0
          },
          pieceType = 1
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "自身的普攻伤害。效果翻倍"
    }
  },
  name = "基汀精炼Ⅰ",
  petList = {
    [1] = {
      awakening = 5,
      equipRefineLv = 1,
      equiplv = 10,
      grade = 3,
      id = 1300461,
      level = 80,
      name = "p1"
    },
    [2] = {
      awakening = 5,
      equipRefineLv = 1,
      equiplv = 10,
      grade = 3,
      id = 1600891,
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
