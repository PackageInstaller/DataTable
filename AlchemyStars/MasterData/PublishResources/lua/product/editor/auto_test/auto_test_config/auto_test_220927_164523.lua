AutoTest_220927_164523 = {
  cases = {
    [1] = {
      [1] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 509
        }
      },
      [2] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 808
        }
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 506
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e5",
          pos = 706
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e4",
          pos = 606
        }
      },
      [6] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 502}
      },
      [7] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e1",
          trigger = 102
        }
      },
      [8] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e2",
          trigger = 102
        }
      },
      [9] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e3",
          trigger = 102
        }
      },
      [10] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e4",
          trigger = 102
        }
      },
      [11] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e5",
          trigger = 102
        }
      },
      [12] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e3",
          key = "CalcDamage_4",
          skillid = 2001681,
          trigger = 102,
          varname = "v1"
        }
      },
      [13] = {
        action = "CheckLocalValue",
        args = {
          target = 1.5,
          trigger = 88,
          varname = "v1"
        }
      },
      [14] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 506,
          trapIds = {
            [1] = 1.501681E7
          },
          trigger = 88
        }
      },
      [15] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 503.0,
            [4] = 504.0,
            [5] = 404.0
          },
          pieceType = 1
        }
      },
      [16] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "场上所有印记爆发喷泉，对十字5格造成伤害240%；印记在场上可存在3回合"
    },
    [2] = {
      [1] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 404.0,
            [2] = 304.0,
            [3] = 204.0,
            [4] = 205.0,
            [5] = 305.0
          },
          pieceType = 1
        }
      },
      [2] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新测试用例"
    },
    [3] = {
      [1] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [2] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e5",
          key = "CalcDamage_5",
          skillid = 300168,
          trigger = 102,
          varname = "v1"
        }
      },
      [3] = {
        action = "CheckLocalValue",
        args = {
          target = 2.4000000953674,
          trigger = 102,
          varname = "v1"
        }
      },
      [4] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      name = "新测试用例"
    }
  },
  name = "虹霞主动技",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1501681,
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
