AutoTest_220714_201741 = {
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
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 506
        }
      },
      [4] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e1",
          trigger = 88
        }
      },
      [5] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 506.0
          }
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "FakeInputDoubleClick",
        args = {}
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
          name = "e1",
          trigger = 88
        }
      },
      [11] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "skillFinalParam",
          damageIndex = 2,
          defname = "e1",
          key = "CalcDamage_132",
          skillid = 200154,
          trigger = 102,
          varname = "v1"
        }
      },
      [12] = {
        action = "CheckLocalValue",
        args = {
          target = 1.0049999952316,
          trigger = 88,
          varname = "v1"
        }
      },
      [13] = {
        action = "CheckUIBuffIcon",
        args = {
          buffID = 400154,
          expect = 2,
          name = "e1",
          trigger = 88
        }
      },
      [14] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 402.0,
            [3] = 302.0,
            [4] = 202.0,
            [5] = 203.0,
            [6] = 303.0,
            [7] = 403.0
          },
          pieceType = 1
        }
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "对标记的目标造成伤害时附加印记，增加目标受到来自薇丝的所有伤害；中途切换目标后印记清空；每层印记提高XXX%的伤害（最大99层）"
    }
  },
  name = "sp薇丝觉醒1",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 1,
      id = 1601541,
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
