AutoTest_221102_120409 = {
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
        action = "SetEntityHPPercent",
        args = {name = "team", percent = 0.5}
      },
      [4] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 502}
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 305
        }
      },
      [6] = {
        action = "AddBuffToEntity",
        args = {buffID = 100001, name = "e1"}
      },
      [7] = {
        action = "AddBuffToEntity",
        args = {buffID = 100501, name = "e1"}
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
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e1",
          trigger = 88
        }
      },
      [11] = {
        action = "CheckBuffLogic",
        args = {
          exist = true,
          logic = "ATBuffForbidAddHP",
          name = "p1",
          trigger = 88
        }
      },
      [12] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 100001,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [13] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 100501,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [14] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "清醒状态下，星灵无法恢复生命"
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
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [4] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 100001,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [5] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 100501,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [6] = {
        action = "CheckBuffLogic",
        args = {
          exist = false,
          logic = "ATBuffForbidAddHP",
          name = "p1",
          trigger = 88
        }
      },
      [7] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "<",
          name = "team",
          trigger = 30
        }
      },
      [8] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "非清醒状态 可恢复"
    }
  },
  name = "1005 治愈禁忌",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1400571,
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
