AutoTest_221102_174847 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [3] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 505}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 5100111,
          name = "e1",
          pos = 509
        }
      },
      [5] = {
        action = "SetAllMonstersHPPercent",
        args = {percent = 0.89999997615814}
      },
      [6] = {
        action = "AddBuffToEntity",
        args = {buffID = 100001, name = "e1"}
      },
      [7] = {
        action = "AddBuffToEntity",
        args = {buffID = 10080201, name = "e1"}
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
        action = "CheckEntityBuff",
        args = {
          buffId = 100001,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [11] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 10080201,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [12] = {
        action = "CheckAttributeChange",
        args = {
          attr = "HP",
          cmp = "<",
          name = "e1",
          trigger = 30
        }
      },
      [13] = {
        action = "FakeCastSkill",
        args = {
          name = "p2",
          pickUpPos = {
            [1] = 301.0
          }
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [15] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "attackPercentage",
          damageIndex = 1,
          defname = "p1",
          key = "FinalAtk",
          skillid = 1002801,
          trigger = 102,
          varname = "v1"
        }
      },
      [16] = {
        action = "CheckLocalValue",
        args = {
          target = 0.014999999664724,
          trigger = 88,
          varname = "v1"
        }
      },
      [17] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [18] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "清醒状态下，反制任何主动技能，增加自己1.5%攻击力及恢复4%血量"
    }
  },
  name = "100802 汲取II",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 1,
      id = 1600061,
      level = 30,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1601481,
      level = 1,
      name = "p2"
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
