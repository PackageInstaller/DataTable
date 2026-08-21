AutoTest_221014_134123 = {
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
          disableai = false,
          id = 5100111,
          name = "e1",
          pos = 507
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 5100111,
          name = "e2",
          pos = 203
        }
      },
      [5] = {
        action = "AddBuffToEntity",
        args = {buffID = 100001, name = "e1"}
      },
      [6] = {
        action = "AddBuffToEntity",
        args = {buffID = 10010101, name = "e1"}
      },
      [7] = {
        action = "AddBuffToEntity",
        args = {buffID = 10010102, name = "e1"}
      },
      [8] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "team",
          trigger = 88
        }
      },
      [9] = {
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
      [10] = {
        action = "CheckLocalValue",
        args = {
          target = 0.029999999329448,
          trigger = 102,
          varname = "v1"
        }
      },
      [11] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "清醒状态下，提高他敌人3%攻击力及1点行动力"
    },
    [2] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "AddBuffToEntity",
        args = {buffID = 10011, name = "e1"}
      },
      [3] = {
        action = "SetEntityHPPercent",
        args = {name = "e2", percent = 100.0}
      },
      [4] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "team",
          trigger = 88
        }
      },
      [5] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 702.0,
            [4] = 802.0
          },
          pieceType = 1
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "非清醒状态下，不增加1点行动力"
    },
    [3] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "AddBuffToEntity",
        args = {buffID = 10021, name = "e1"}
      },
      [3] = {
        action = "SetEntityHPPercent",
        args = {name = "e2", percent = 100.0}
      },
      [4] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "team",
          trigger = 88
        }
      },
      [5] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "attackPercentage",
          damageIndex = 1,
          defname = "p1",
          key = "FinalAtk",
          skillid = 1002801,
          trigger = 102,
          varname = "v2"
        }
      },
      [6] = {
        action = "CheckLocalValue",
        args = {
          target = 0.0,
          trigger = 102,
          varname = "v2"
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
      name = "非清醒状态下，不提高他敌人3%攻击"
    }
  },
  name = "强化1",
  petList = {
    [1] = {
      awakening = 5,
      equiplv = 3,
      grade = 2,
      id = 1600061,
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
