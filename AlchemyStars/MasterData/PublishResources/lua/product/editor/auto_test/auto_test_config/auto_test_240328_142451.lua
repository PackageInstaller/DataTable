AutoTest_240328_142451 = {
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
        action = "FakeInputDoubleClick",
        args = {}
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [6] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_5",
          skillid = 300215,
          trigger = 102,
          varname = "v1"
        }
      },
      [9] = {
        action = "CheckLocalValue",
        args = {
          target = 2.0,
          trigger = 102,
          varname = "v1"
        }
      },
      [10] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 504,
          trapIds = {
            [1] = 2803501.0
          },
          trigger = 88
        }
      },
      [11] = {
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 505,
          trigger = 88
        }
      },
      [12] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0,
            [2] = 505.0
          },
          skillIndex = 1
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "选择一个敌人脚下的格子，再十字4格选一个方向，把怪向所选方向拽1格，造成XX%伤害并将选中的格（怪物原来位置）变为深色格(CD2)"
    }
  },
  name = "伊莎主动技",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 0,
      grade = 0,
      id = 1502151,
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
