AutoTest_221026_132623 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetPieceType",
        args = {pieceType = 2}
      },
      [3] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 502}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 507
        }
      },
      [5] = {
        action = "AddBuffToEntity",
        args = {buffID = 10590101, name = "e1"}
      },
      [6] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "defenderFinal",
          damageIndex = 1,
          defname = "e1",
          key = "FinalDamage",
          skillid = 100030,
          trigger = 102,
          varname = "v1"
        }
      },
      [7] = {
        action = "CheckLocalValue",
        args = {
          target = 0.69999998807907,
          trigger = 102,
          varname = "v1"
        }
      },
      [8] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "defenderFinal",
          damageIndex = 1,
          defname = "e1",
          key = "FinalDamage",
          skillid = 100071,
          trigger = 102,
          varname = "v2"
        }
      },
      [9] = {
        action = "CheckLocalValue",
        args = {
          target = 1.0,
          trigger = 102,
          varname = "v2"
        }
      },
      [10] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "defenderFinal",
          damageIndex = 1,
          defname = "e1",
          key = "FinalAtk",
          skillid = 200301,
          trigger = 102,
          varname = "v3"
        }
      },
      [11] = {
        action = "CheckLocalValue",
        args = {
          target = 0.69999998807907,
          trigger = 102,
          varname = "v3"
        }
      },
      [12] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 505.0,
            [5] = 506.0
          },
          pieceType = 2
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "队长伤害降低30%"
    }
  },
  name = "专注Ⅰ（调试",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600301,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1500711,
      level = 1,
      name = "p1"
    },
    [3] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1601121,
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
