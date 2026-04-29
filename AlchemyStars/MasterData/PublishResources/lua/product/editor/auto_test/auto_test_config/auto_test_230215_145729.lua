AutoTest_230215_145729 = {
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
          pos = 505
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 208
        }
      },
      [5] = {
        action = "SetAllMonstersHP",
        args = {value = 100000}
      },
      [6] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          },
          skillIndex = 1
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "FakeInputDoubleClick",
        args = {}
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
          defname = "e1",
          key = "CalcDamage_5",
          skillid = 3101851,
          trigger = 102,
          varname = "v1"
        }
      },
      [11] = {
        action = "CheckLocalValue",
        args = {
          target = 0.94999998807907,
          trigger = 88,
          varname = "v1"
        }
      },
      [12] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 404.0
          },
          skillIndex = 1
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [14] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [16] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 405.0
          },
          skillIndex = 1
        }
      },
      [17] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [18] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [19] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [20] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 406.0
          },
          skillIndex = 1
        }
      },
      [21] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [22] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [23] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [24] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 506.0
          },
          skillIndex = 1
        }
      },
      [25] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [26] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 5,
          layerType = 4101850,
          name = "p1",
          trigger = 0
        }
      },
      [27] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [28] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e2",
          key = "CalcDamage_5",
          skillid = 3101851,
          trigger = 102,
          varname = "v2"
        }
      },
      [29] = {
        action = "CheckLocalValue",
        args = {
          target = 1.1499999761581,
          trigger = 102,
          varname = "v2"
        }
      },
      [30] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 208.0
          },
          skillIndex = 2
        }
      },
      [31] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "被动强化：每层提高5%基础伤害率"
    }
  },
  name = "凯亚突破Ⅴ",
  petList = {
    [1] = {
      awakening = 5,
      equiplv = 1,
      grade = 3,
      id = 1501851,
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
