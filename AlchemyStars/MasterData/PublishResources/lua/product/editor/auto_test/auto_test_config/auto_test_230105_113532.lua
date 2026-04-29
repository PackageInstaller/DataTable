AutoTest_230105_113532 = {
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
          pos = 506
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 507
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 309
        }
      },
      [7] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e4",
          pos = 802
        }
      },
      [8] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 3,
          layerType = 400182,
          name = "p1",
          trigger = 0
        }
      },
      [9] = {
        action = "SetAllMonstersHP",
        args = {value = 9999}
      },
      [10] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [11] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e2",
          trigger = 88
        }
      },
      [12] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e3",
          trigger = 88
        }
      },
      [13] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e4",
          trigger = 88
        }
      },
      [14] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e3",
          key = "CalcDamage_5",
          skillid = 3101821,
          trigger = 102,
          varname = "v1"
        }
      },
      [15] = {
        action = "CheckLocalValue",
        args = {
          target = 1.5,
          trigger = 88,
          varname = "v1"
        }
      },
      [16] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 0,
          layerType = 400182,
          name = "p1",
          trigger = 88
        }
      },
      [17] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 506.0
          }
        }
      },
      [18] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "施放主动技时，立即对全屏造成XX%单体伤害"
    }
  },
  name = "木月白觉醒1主动技",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 1,
      id = 1601821,
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
