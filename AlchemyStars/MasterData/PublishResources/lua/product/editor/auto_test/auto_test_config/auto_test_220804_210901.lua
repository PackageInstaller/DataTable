AutoTest_220804_210901 = {
  cases = {
    [1] = {
      [1] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 101311,
          name = "e1",
          pos = 604
        }
      },
      [2] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 101312,
          name = "e2",
          pos = 704
        }
      },
      [3] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 1,
          layerType = 4001580,
          name = "e1",
          trigger = 88
        }
      },
      [4] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 2,
          layerType = 4001580,
          name = "e2",
          trigger = 88
        }
      },
      [5] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "skillIncreaseParam",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_1",
          skillid = 130160,
          trigger = 102,
          varname = "v1"
        }
      },
      [6] = {
        action = "CheckLocalValue",
        args = {
          target = 1.5,
          trigger = 14,
          varname = "v1"
        }
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 603.0,
            [4] = 703.0,
            [5] = 803.0
          },
          pieceType = 1
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "每回合的第一次普攻，是正常伤害的1.5倍"
    }
  },
  name = "喜多川觉醒3",
  petList = {
    [1] = {
      awakening = 1,
      equiplv = 1,
      grade = 3,
      id = 1501601,
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
