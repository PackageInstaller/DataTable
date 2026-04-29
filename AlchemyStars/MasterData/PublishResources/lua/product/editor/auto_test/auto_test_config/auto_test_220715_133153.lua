AutoTest_220715_133153 = {
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
          pos = 305
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 505
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 705
        }
      },
      [6] = {
        action = "SetEntityHPPercent",
        args = {name = "e2", percent = 0.20000000298023}
      },
      [7] = {
        action = "CheckSanValue",
        args = {
          compare = "==",
          expect = 100,
          trigger = 0
        }
      },
      [8] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e2",
          trigger = 88
        }
      },
      [9] = {
        action = "CheckSanValue",
        args = {
          compare = "==",
          expect = 85,
          trigger = 88
        }
      },
      [10] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [12] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_5",
          skillid = 3001511,
          trigger = 102,
          varname = "v1"
        }
      },
      [13] = {
        action = "CheckLocalValue",
        args = {
          target = 6.6599998474121,
          trigger = 88,
          varname = "v1"
        }
      },
      [14] = {
        action = "CheckSanValue",
        args = {
          compare = "==",
          expect = 55,
          trigger = 88
        }
      },
      [15] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 304.0
          }
        }
      },
      [16] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [17] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e3",
          key = "CalcDamage_5",
          skillid = 3001512,
          trigger = 102,
          varname = "v2"
        }
      },
      [18] = {
        action = "CheckLocalValue",
        args = {
          target = 13.319999694824,
          trigger = 88,
          varname = "v2"
        }
      },
      [19] = {
        action = "CheckSanValue",
        args = {
          compare = "==",
          expect = 0,
          trigger = 88
        }
      },
      [20] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 704.0
          }
        }
      },
      [21] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "主动技杀死敌人后可以立即再次施放，但是消耗的san值和造成的最终伤害均翻倍，重复效果叠乘"
    }
  },
  name = "贾尔斯觉醒2",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 2,
      id = 1601511,
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
