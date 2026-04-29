AutoTest_240327_151142 = {
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
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 2803501,
          name = "e2",
          pos = 603
        }
      },
      [5] = {
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
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
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
      [8] = {
        action = "CheckLocalValue",
        args = {
          target = 1.1200000047684,
          trigger = 88,
          varname = "v1"
        }
      },
      [9] = {
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
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [11] = {
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
      [12] = {
        action = "CheckLocalValue",
        args = {
          target = 1.0599999427795,
          trigger = 88,
          varname = "v2"
        }
      },
      [13] = {
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
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "主动技每造成一次伤害获得1点运算值"
    }
  },
  name = "阿尔戈尔觉醒2",
  petList = {
    [1] = {
      awakening = 6,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 2,
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
