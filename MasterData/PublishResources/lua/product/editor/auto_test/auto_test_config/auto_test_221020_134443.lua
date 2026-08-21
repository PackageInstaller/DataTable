AutoTest_221020_134443 = {
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
          pos = 507
        }
      },
      [4] = {
        action = "AddBuffToEntity",
        args = {buffID = 100001, name = "e1"}
      },
      [5] = {
        action = "AddBuffToEntity",
        args = {buffID = 102801, name = "e1"}
      },
      [6] = {
        action = "SetAllMonstersHP",
        args = {value = 10000}
      },
      [7] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
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
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 505.0
          }
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [12] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [13] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 408,
          trapIds = {
            [1] = 61.0
          },
          trigger = 88
        }
      },
      [14] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 508,
          trapIds = {
            [1] = 61.0
          },
          trigger = 88
        }
      },
      [15] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 608,
          trapIds = {
            [1] = 61.0
          },
          trigger = 88
        }
      },
      [16] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 407,
          trapIds = {
            [1] = 61.0
          },
          trigger = 88
        }
      },
      [17] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 607,
          trapIds = {
            [1] = 61.0
          },
          trigger = 88
        }
      },
      [18] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 406,
          trapIds = {
            [1] = 61.0
          },
          trigger = 88
        }
      },
      [19] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 506,
          trapIds = {
            [1] = 61.0
          },
          trigger = 88
        }
      },
      [20] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 606,
          trapIds = {
            [1] = 61.0
          },
          trigger = 88
        }
      },
      [21] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 100001,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [22] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 102801,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [23] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "清醒状态下，反制转色技，将周围洗版然后上锁（怎么说明转色技？）pet_battle_skill表中tag列包含3的技能"
    }
  },
  name = "1028 湮灭之光",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1401271,
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
