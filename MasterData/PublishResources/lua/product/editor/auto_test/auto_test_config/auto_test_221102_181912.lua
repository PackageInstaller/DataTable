AutoTest_221102_181912 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetPieceType",
        args = {pieceType = 3}
      },
      [3] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [4] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 502}
      },
      [5] = {
        action = "SetAllMonstersHP",
        args = {value = 99999}
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 507
        }
      },
      [7] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 509
        }
      },
      [8] = {
        action = "AddBuffToEntity",
        args = {buffID = 10090101, name = "e1"}
      },
      [9] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [11] = {
        action = "FakeCastSkill",
        args = {
          name = "p3",
          pickUpPos = {
            [1] = 508.0
          }
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [13] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "finalAtk",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_14",
          skillid = 20011,
          trigger = 102,
          varname = "v1"
        }
      },
      [14] = {
        action = "CheckLocalValue",
        args = {
          target = 110.0,
          trigger = 102,
          varname = "v1"
        }
      },
      [15] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "finalAtk",
          damageIndex = 1,
          defname = "e2",
          key = "CalcDamage_14",
          skillid = 20011,
          trigger = 102,
          varname = "v2"
        }
      },
      [16] = {
        action = "CheckLocalValue",
        args = {
          target = 56.0,
          trigger = 102,
          varname = "v2"
        }
      },
      [17] = {
        action = "CompareLocalValue",
        args = {
          cmp = ">",
          key1 = "v1",
          key2 = "v2",
          trigger = 10
        }
      },
      [18] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 603.0,
            [3] = 703.0,
            [4] = 803.0,
            [5] = 903.0,
            [6] = 904.0,
            [7] = 804.0,
            [8] = 704.0,
            [9] = 604.0,
            [10] = 504.0
          },
          pieceType = 3
        }
      },
      [19] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "受到的dot（灼烧/中毒/流血）伤害提高1倍，等同于提高到2倍"
    }
  },
  name = "100901 易伤I",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600261,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1500211,
      level = 1,
      name = "p2"
    },
    [3] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1400451,
      level = 1,
      name = "p3"
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
