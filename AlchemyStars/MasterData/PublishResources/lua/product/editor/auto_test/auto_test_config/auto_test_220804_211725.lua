AutoTest_220804_211725 = {
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
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 509.0
          }
        }
      },
      [4] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 606
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 2010211,
          name = "e3",
          pos = 508
        }
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0
          },
          pieceType = 1
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [9] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
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
          name = "e2",
          trigger = 88
        }
      },
      [12] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e3",
          key = "CalcDamage_5",
          skillid = 3001560,
          trigger = 102,
          varname = "v1"
        }
      },
      [13] = {
        action = "CheckLocalValue",
        args = {
          target = 6.4000000953674,
          trigger = 88,
          varname = "v1"
        }
      },
      [14] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "空手:将伞收回,对沿途造成8倍伤害"
    }
  },
  name = "妮娜主动技",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 0,
      grade = 0,
      id = 1601561,
      level = 30,
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
