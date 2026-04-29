AutoTest_221102_150808 = {
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
          disableai = false,
          id = 5100111,
          name = "e1",
          pos = 409
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 5100111,
          name = "e2",
          pos = 509
        }
      },
      [6] = {
        action = "AddBuffToEntity",
        args = {buffID = 10070301, name = "e1"}
      },
      [7] = {
        action = "AddBuffToEntity",
        args = {buffID = 10070301, name = "e2"}
      },
      [8] = {
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 407,
          trigger = 88
        }
      },
      [9] = {
        action = "CheckEntityPos",
        args = {
          name = "e2",
          pos = 507,
          trigger = 88
        }
      },
      [10] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [12] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 10070301,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [13] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
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
          target = 0.059999998658895,
          trigger = 88,
          varname = "v1"
        }
      },
      [17] = {
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 505,
          trigger = 88
        }
      },
      [18] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [19] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "死亡后，提高其他敌人6%攻击力及1点行动力"
    }
  },
  name = "100703 狂暴III",
  petList = {
    [1] = {
      awakening = 6,
      equiplv = 1,
      grade = 3,
      id = 1600061,
      level = 30,
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
