AutoTest_240327_143632 = {
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
          pos = 504
        }
      },
      [4] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_5",
          skillid = 300221,
          trigger = 102,
          varname = "v1"
        }
      },
      [5] = {
        action = "CheckLocalValue",
        args = {
          target = 2.2000000476837,
          trigger = 102,
          varname = "v1"
        }
      },
      [6] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 505,
          trapIds = {
            [1] = 2803501.0
          },
          trigger = 88
        }
      },
      [7] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 404,
          trapIds = {
            [1] = 2803501.0
          },
          trigger = 88
        }
      },
      [8] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 604,
          trapIds = {
            [1] = 2803501.0
          },
          trigger = 88
        }
      },
      [9] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0,
            [2] = 505.0,
            [3] = 404.0,
            [4] = 604.0
          },
          skillIndex = 1
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "选择一个格子形成9格范围，派出布 尔，在该范围造成XX%伤害，可在范围 内选3格转为深色。先制攻击"
    }
  },
  name = "阿尔戈尔突破3",
  petList = {
    [1] = {
      awakening = 3,
      equipRefineLv = 0,
      equiplv = 0,
      grade = 0,
      id = 1602211,
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
