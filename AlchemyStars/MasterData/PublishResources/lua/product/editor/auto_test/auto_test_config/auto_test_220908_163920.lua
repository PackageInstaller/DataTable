AutoTest_220908_163920 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 507
        }
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 309
        }
      },
      [4] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 505}
      },
      [5] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 507.0
          }
        }
      },
      [6] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新测试用例"
    },
    [2] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [3] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "等待回合"
    },
    [3] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [3] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "等待回合"
    },
    [4] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e2",
          key = "CalcDamage_5",
          skillid = 300166,
          trigger = 102,
          varname = "v1"
        }
      },
      [3] = {
        action = "CheckLocalValue",
        args = {
          target = 3.0,
          trigger = 88,
          varname = "v1"
        }
      },
      [4] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 507.0
          }
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "3回合对方形25格造成300%伤害"
    }
  },
  name = "菲亚主动技3回合",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1601661,
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
