AutoTest_240326_111053 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetEntityPosition",
        args = {name = "p1", pos = 502}
      },
      [3] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [4] = {
        action = "SetEntityHPPercent",
        args = {name = "team", percent = 0.80000001192093}
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [6] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "rate",
          damageIndex = 1,
          defname = "p1",
          key = "CalcAddBlood",
          skillid = 4302121,
          trigger = 102,
          varname = "v1"
        }
      },
      [7] = {
        action = "CheckLocalValue",
        args = {
          target = 0.20000000298023,
          trigger = 88,
          varname = "v1"
        }
      },
      [8] = {
        action = "FakeCastSkill",
        args = {
          name = "p2",
          pickUpPos = {
            [1] = 503.0
          },
          skillIndex = 1
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "SetEntityHPPercent",
        args = {name = "team", percent = 0.10000000149012}
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [12] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [14] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "rate",
          damageIndex = 1,
          defname = "p1",
          key = "CalcAddBlood",
          skillid = 4302121,
          trigger = 102,
          varname = "v2"
        }
      },
      [15] = {
        action = "CheckLocalValue",
        args = {
          target = 0.89999997615814,
          trigger = 88,
          varname = "v2"
        }
      },
      [16] = {
        action = "FakeCastSkill",
        args = {
          name = "p2",
          pickUpPos = {
            [1] = 403.0
          },
          skillIndex = 2
        }
      },
      [17] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "装备技强化：血量越低，被动效果越高最高提高100%"
    }
  },
  name = "安顿觉3",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 3,
      id = 1602121,
      level = 130,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 3,
      id = 1600061,
      level = 0,
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
