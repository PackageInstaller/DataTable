AutoTest_221103_150038 = {
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
          disableai = false,
          id = 5105417,
          name = "e1",
          pos = 503
        }
      },
      [4] = {
        action = "SetEntityHPPercent",
        args = {name = "e1", percent = 0.5}
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 504
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 403
        }
      },
      [7] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e4",
          pos = 105
        }
      },
      [8] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 603.0
          },
          pieceType = 1
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e2",
          key = "CalcDamage_2",
          skillid = 521026,
          trigger = 102,
          varname = "v1"
        }
      },
      [11] = {
        action = "CheckLocalValue",
        args = {
          target = 10.0,
          trigger = 102,
          varname = "v1"
        }
      },
      [12] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "team",
          key = "CalcDamage_2",
          skillid = 521026,
          trigger = 102,
          varname = "v1"
        }
      },
      [13] = {
        action = "CheckLocalValue",
        args = {
          target = 10.0,
          trigger = 102,
          varname = "v1"
        }
      },
      [14] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "崩蚁自爆造成自身攻击力10倍的范围伤害。"
    }
  },
  name = "40034崩蚁爆发",
  petList = {
    [1] = {
      awakening = 6,
      equiplv = 10,
      grade = 3,
      id = 1601481,
      level = 80,
      name = "p1"
    },
    [2] = {
      awakening = 6,
      equiplv = 10,
      grade = 3,
      id = 1601311,
      level = 80,
      name = "p2"
    },
    [3] = {
      awakening = 6,
      equiplv = 10,
      grade = 3,
      id = 1601551,
      level = 80,
      name = "p3"
    },
    [4] = {
      awakening = 6,
      equiplv = 10,
      grade = 3,
      id = 1701081,
      level = 80,
      name = "p4"
    },
    [5] = {
      awakening = 6,
      equiplv = 10,
      grade = 3,
      id = 1601531,
      level = 80,
      name = "p5"
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
