AutoTest_211216_115929 = {
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
          id = 2071413,
          name = "e1",
          pos = 402
        }
      },
      [4] = {
        action = "SetEntityHPPercent",
        args = {name = "e1", percent = 0.5}
      },
      [5] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "skillIncreaseParam",
          attr_select_index = 10,
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_1",
          key_select_index = 5,
          skillid = 100116,
          trigger = 102,
          varname = "v1"
        }
      },
      [6] = {
        action = "CheckLocalValue",
        args = {
          target = 1.039999961853,
          trigger = 88,
          varname = "v1"
        }
      },
      [7] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [9] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 2101322,
          name = "e2",
          pos = 602
        }
      },
      [10] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 400116,
          exist = true,
          name = "e2",
          trigger = 88
        }
      },
      [11] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 602.0
          },
          skillIndex = 0
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [13] = {
        action = "SetEntityHPPercent",
        args = {name = "e2", percent = 0.40000000596046}
      },
      [14] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "skillIncreaseParam",
          damageIndex = 1,
          defname = "e2",
          key = "CalcDamage_1",
          skillid = 100116,
          trigger = 102,
          varname = "v2"
        }
      },
      [15] = {
        action = "CheckLocalValue",
        args = {
          target = 1.0599999427795,
          trigger = 88,
          varname = "v2"
        }
      },
      [16] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [17] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [18] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 2101322,
          name = "e3",
          pos = 707
        }
      },
      [19] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 400116,
          exist = true,
          name = "e3",
          trigger = 88
        }
      },
      [20] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [21] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 707.0
          },
          skillIndex = 1
        }
      },
      [22] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [23] = {
        action = "SetEntityHPPercent",
        args = {name = "e3", percent = 0.40000000596046}
      },
      [24] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [25] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "skillIncreaseParam",
          attr_select_index = 10,
          damageIndex = 1,
          defname = "e3",
          key = "CalcDamage_5",
          key_select_index = 8,
          skillid = 300116,
          trigger = 102,
          varname = "v3"
        }
      },
      [26] = {
        action = "CheckLocalValue",
        args = {
          target = 1.0599999427795,
          trigger = 88,
          varname = "v3"
        }
      },
      [27] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 707.0
          },
          skillIndex = 1
        }
      },
      [28] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [29] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e4",
          pos = 306
        }
      },
      [30] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 400116,
          exist = true,
          name = "e4",
          trigger = 88
        }
      },
      [31] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [32] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 306.0
          },
          skillIndex = 1
        }
      },
      [33] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [34] = {
        action = "SetEntityHPPercent",
        args = {name = "e4", percent = 0.40000000596046}
      },
      [35] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "skillIncreaseParam",
          damageIndex = 1,
          defname = "e4",
          key = "CalcDamage_4",
          skillid = 2201161,
          trigger = 102,
          varname = "v4"
        }
      },
      [36] = {
        action = "CheckLocalValue",
        args = {
          target = 1.0599999427795,
          trigger = 88,
          varname = "v4"
        }
      },
      [37] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 505.0,
            [5] = 506.0
          },
          pieceType = 1
        }
      },
      [38] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "被动强化: 对标记的单位额外获得一半的效果"
    }
  },
  name = "费劳尔觉醒3",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 3,
      id = 1601161,
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
