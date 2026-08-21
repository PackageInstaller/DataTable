AutoTest_240327_153007 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 501}
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
        action = "SetAllMonstersHP",
        args = {value = 99999}
      },
      [5] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 2803501,
          name = "e2",
          pos = 603
        }
      },
      [6] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0,
            [2] = 506.0,
            [3] = 502.0,
            [4] = 304.0,
            [5] = 704.0
          },
          skillIndex = 1
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "skillIncreaseParam",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 2002211,
          trigger = 102,
          varname = "v1"
        }
      },
      [9] = {
        action = "CheckLocalValue",
        args = {
          target = 1.3600000143051,
          trigger = 88,
          varname = "v1"
        }
      },
      [10] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 501.0,
            [2] = 502.0,
            [3] = 603.0,
            [4] = 704.0,
            [5] = 605.0,
            [6] = 506.0,
            [7] = 405.0,
            [8] = 304.0
          },
          pieceType = 1
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [12] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "skillIncreaseParam",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 2002211,
          trigger = 102,
          varname = "v2"
        }
      },
      [13] = {
        action = "CheckLocalValue",
        args = {
          target = 1.1799999475479,
          trigger = 88,
          varname = "v2"
        }
      },
      [14] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 304.0,
            [2] = 303.0,
            [3] = 302.0,
            [4] = 402.0,
            [5] = 403.0
          },
          pieceType = 1
        }
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "精炼1：每次经过深色格子时，获得层数，每层提升布尔6%的伤害，层数每回合减半"
    }
  },
  name = "阿尔戈尔精炼1",
  petList = {
    [1] = {
      awakening = 6,
      equipRefineLv = 1,
      equiplv = 10,
      grade = 3,
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
