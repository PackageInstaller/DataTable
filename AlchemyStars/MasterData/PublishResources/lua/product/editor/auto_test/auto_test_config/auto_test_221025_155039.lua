AutoTest_221025_155039 = {
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
          pos = 508
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 2011012,
          name = "e2",
          pos = 305
        }
      },
      [5] = {
        action = "AddBuffToEntity",
        args = {buffID = 10570101, name = "e1"}
      },
      [6] = {
        action = "AddBuffToEntity",
        args = {buffID = 10570101, name = "e2"}
      },
      [7] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "defenderFinal",
          damageIndex = 1,
          defname = "e1",
          key = "FinalDamage",
          skillid = 200331,
          trigger = 102,
          varname = "v1"
        }
      },
      [8] = {
        action = "CheckLocalValue",
        args = {
          target = 1.0,
          trigger = 102,
          varname = "v1"
        }
      },
      [9] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "defenderFinal",
          damageIndex = 2,
          defname = "e2",
          key = "FinalDamage",
          skillid = 200331,
          trigger = 102,
          varname = "v2"
        }
      },
      [10] = {
        action = "CheckLocalValue",
        args = {
          target = 1.2999999523163,
          trigger = 102,
          varname = "v2"
        }
      },
      [11] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 505.0,
            [5] = 506.0,
            [6] = 507.0
          },
          pieceType = 1
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "受到对单体类型伤害时，根据占地面积提高最终伤害值"
    }
  },
  name = "狙击爆破（待调试）",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1500331,
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
