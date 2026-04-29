AutoTest_220223_114351 = {
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
        args = {name = "team", name_select_index = 0}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 2100212,
          name = "e1",
          pos = 404
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 2100212,
          name = "e2",
          pos = 505
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 2100212,
          name = "e3",
          pos = 606
        }
      },
      [7] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 2100212,
          name = "e4",
          pos = 705
        }
      },
      [8] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [9] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e2",
          trigger = 88
        }
      },
      [10] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e3",
          trigger = 88
        }
      },
      [11] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e4",
          trigger = 88
        }
      },
      [12] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          attr_select_index = 9,
          defname = "e2",
          key = "CalcDamage_5",
          key_select_index = 9,
          skillid = 320134,
          trigger = 102,
          varname = "v1"
        }
      },
      [13] = {
        action = "CheckLocalValue",
        args = {
          target = 3.6400001049042,
          trigger = 88,
          varname = "v1"
        }
      },
      [14] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 509.0
          }
        }
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "全屏任选，打3列最远（等同雷天使范围），附加击退到最远"
    }
  },
  name = "康纳觉醒2",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 2,
      id = 1601341,
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
