AutoTest_220628_112939 = {
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
          pos = 709
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 403
        }
      },
      [6] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e2",
          trigger = 88
        }
      },
      [7] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 503.0
          }
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [9] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 205.0
          }
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [11] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          defname = "e2",
          key = "CalcDamage_108",
          skillid = 3101451,
          trigger = 102,
          varname = "v1"
        }
      },
      [12] = {
        action = "CheckLocalValue",
        args = {
          target = 0.60000002384186,
          trigger = 88,
          varname = "v1"
        }
      },
      [13] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 503.0
          }
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [15] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [16] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [17] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [18] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 509.0
          }
        }
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
            [1] = 309.0
          }
        }
      },
      [21] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [22] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          defname = "e1",
          key = "CalcDamage_108",
          skillid = 3101451,
          trigger = 102,
          varname = "v1"
        }
      },
      [23] = {
        action = "CheckLocalValue",
        args = {
          target = 0.47999998927116,
          trigger = 88,
          varname = "v1"
        }
      },
      [24] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 509.0
          }
        }
      },
      [25] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "跳到刀上后其余的刀飞回手中（仅表现），每回手一把刀就对最近的敌人造成一次最高XX%的真伤，距离越远伤害越低（相邻100%，扩1圈减20%，最低20%)"
    }
  },
  name = "雨森觉醒1",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 1,
      id = 1601451,
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
