AutoTest_221026_152750 = {
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
          disableai = false,
          id = 5100111,
          name = "e1",
          pos = 503
        }
      },
      [3] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "e1"}
      },
      [4] = {
        action = "AddBuffToEntity",
        args = {buffID = 10640101, name = "e1"}
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
          varname = "v1"
        }
      },
      [6] = {
        action = "CheckLocalValue",
        args = {
          target = 0.0,
          trigger = 88,
          varname = "v1"
        }
      },
      [7] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Mobility",
          expect = 2.0,
          name = "e1",
          trigger = 88
        }
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
          attr = "attackPercentage",
          damageIndex = 1,
          defname = "p1",
          key = "FinalAtk",
          skillid = 1002801,
          trigger = 102,
          varname = "v2"
        }
      },
      [11] = {
        action = "CheckLocalValue",
        args = {
          target = 0.050000000745058,
          trigger = 88,
          varname = "v2"
        }
      },
      [12] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Mobility",
          expect = 3.0,
          name = "e1",
          trigger = 88
        }
      },
      [13] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [14] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 503.0
          }
        }
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
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
        action = "CaptureFormulaAttr",
        args = {
          attr = "attackPercentage",
          damageIndex = 1,
          defname = "p1",
          key = "FinalAtk",
          skillid = 1002801,
          trigger = 102,
          varname = "v3"
        }
      },
      [19] = {
        action = "CheckLocalValue",
        args = {
          target = 0.10000000149012,
          trigger = 88,
          varname = "v3"
        }
      },
      [20] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Mobility",
          expect = 4.0,
          name = "e1",
          trigger = 88
        }
      },
      [21] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [22] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [23] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [24] = {
        action = "FakeCastSkill",
        args = {
          name = "p2",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [25] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [26] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [27] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [28] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "反制光灵的主动技，本回合增加自身5%攻击力和1点行动力，可叠加。"
    }
  },
  name = "暗影奔袭",
  petList = {
    [1] = {
      awakening = 5,
      equiplv = 10,
      grade = 3,
      id = 1600141,
      level = 80,
      name = "p1"
    },
    [2] = {
      awakening = 5,
      equiplv = 10,
      grade = 3,
      id = 1600231,
      level = 80,
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
