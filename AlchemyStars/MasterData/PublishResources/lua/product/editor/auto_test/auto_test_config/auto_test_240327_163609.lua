AutoTest_240327_163609 = {
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
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 602.0
          },
          skillIndex = 1
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 604
        }
      },
      [7] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 704
        }
      },
      [8] = {
        action = "SetAllMonstersHP",
        args = {value = 999999}
      },
      [9] = {
        action = "CheckUIBuffIcon",
        args = {
          buffID = 200221,
          expect = 1,
          name = "e1",
          trigger = 88
        }
      },
      [10] = {
        action = "CheckUIBuffIcon",
        args = {
          buffID = 200221,
          expect = 0,
          name = "e2",
          trigger = 88
        }
      },
      [11] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0
          },
          pieceType = 1
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [13] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [14] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_RebeccaPoisonNormalDamage",
          skillid = 200221,
          trigger = 102,
          varname = "v1"
        }
      },
      [15] = {
        action = "CheckLocalValue",
        args = {
          target = 0.20000000298023,
          trigger = 88,
          varname = "v1"
        }
      },
      [16] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "每次自己经过深色格子时对菱形12格范围洒毒（按格子算），在怪物回合开始时结算，每层基于自己攻击力N%造成伤害.上限40层，持续3回合（先洒毒再计算普攻）"
    },
    [2] = {
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
      [4] = {
        action = "SetEntityPosition",
        args = {name = "p1", pos = 502}
      },
      [5] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [6] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 602.0
          },
          skillIndex = 1
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "AddBuffToEntity",
        args = {buffID = 200221, name = "e1"}
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "SetEntityBuffLayer",
        args = {
          display = true,
          layer = 40,
          layerType = 20022,
          name = "e1"
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [12] = {
        action = "CheckUIBuffIcon",
        args = {
          buffID = 200221,
          expect = 40,
          name = "e1",
          trigger = 88
        }
      },
      [13] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 603.0
          },
          pieceType = 1
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "buff上限40层"
    }
  },
  name = "丽蓓卡觉1",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 1,
      id = 1602141,
      level = 40,
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
