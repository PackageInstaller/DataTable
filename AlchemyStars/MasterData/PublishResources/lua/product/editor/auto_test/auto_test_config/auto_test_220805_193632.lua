AutoTest_220805_193632 = {
  cases = {
    [1] = {
      [1] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 502}
      },
      [2] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 101311,
          name = "e1",
          pos = 605
        }
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 101314,
          name = "e2",
          pos = 505
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 405
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e4",
          pos = 305
        }
      },
      [6] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e2",
          key = "CalcDamage_5",
          skillid = 3201621,
          trigger = 102,
          varname = "v1"
        }
      },
      [7] = {
        action = "CheckLocalValue",
        args = {
          target = 2.4000000953674,
          trigger = 88,
          varname = "v1"
        }
      },
      [8] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 10,
          layerType = 4001580,
          name = "e2",
          trigger = 88
        }
      },
      [9] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 5,
          layerType = 4001580,
          name = "e1",
          trigger = 88
        }
      },
      [10] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e2",
          trigger = 88
        }
      },
      [11] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e3",
          trigger = 88
        }
      },
      [12] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e4",
          trigger = 88
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
      name = "全屏任选一格，打3列最远，造成2.4%伤害，同时雷属性敌人叠10层"
    }
  },
  name = "mona觉醒2",
  petList = {
    [1] = {
      awakening = 3,
      equiplv = 1,
      grade = 2,
      id = 1501621,
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
