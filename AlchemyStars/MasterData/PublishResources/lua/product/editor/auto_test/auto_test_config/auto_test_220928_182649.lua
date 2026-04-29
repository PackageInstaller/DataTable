AutoTest_220928_182649 = {
  cases = {
    [1] = {
      [1] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 507
        }
      },
      [2] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e1",
          trigger = 88
        }
      },
      [3] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 507.0
          }
        }
      },
      [4] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 507,
          trapIds = {
            [1] = 1.6016611E7
          },
          trigger = 88
        }
      },
      [5] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [6] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0
          },
          pieceType = 1
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "选1个格子放诱饵"
    },
    [2] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 506
        }
      },
      [3] = {
        action = "CheckGridTrap",
        args = {
          exist = false,
          pos = 507,
          trapIds = {
            [1] = 1.6016611E7
          },
          trigger = 88
        }
      },
      [4] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e2",
          trigger = 102
        }
      },
      [5] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_5",
          skillid = 306166,
          trigger = 102,
          varname = "v1"
        }
      },
      [6] = {
        action = "CheckLocalValue",
        args = {
          target = 2.0,
          trigger = 102,
          varname = "v1"
        }
      },
      [7] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e2",
          key = "CalcDamage_5",
          skillid = 306166,
          trigger = 102,
          varname = "v2"
        }
      },
      [8] = {
        action = "CheckLocalValue",
        args = {
          target = 2.0,
          trigger = 102,
          varname = "v2"
        }
      },
      [9] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 507.0
          }
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [11] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 507.0
          }
        }
      },
      [12] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 602.0,
            [2] = 702.0
          },
          pieceType = 1
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "1回合:对十字5格200%伤害"
    },
    [3] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [3] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "等待回合"
    },
    [4] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 509
        }
      },
      [3] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e3",
          key = "CalcDamage_5",
          skillid = 306166,
          trigger = 102,
          varname = "v3"
        }
      },
      [4] = {
        action = "CheckLocalValue",
        args = {
          target = 3.5,
          trigger = 102,
          varname = "v3"
        }
      },
      [5] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 507.0
          }
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 507.0
          }
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "2回合对菱形13格造成350%伤害"
    }
  },
  name = "菲亚突破6",
  petList = {
    [1] = {
      awakening = 6,
      equiplv = 1,
      grade = 1,
      id = 1601661,
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
