AutoTest_221024_161215 = {
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
          pos = 503
        }
      },
      [4] = {
        action = "AddBuffToEntity",
        args = {buffID = 102703, name = "e1"}
      },
      [5] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 102703,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [6] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "team",
          key = "CalcDamage_2",
          skillid = 102703,
          trigger = 102,
          varname = "v1"
        }
      },
      [9] = {
        action = "CheckLocalValue",
        args = {
          target = 0.25,
          trigger = 88,
          varname = "v1"
        }
      },
      [10] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 501.0,
            [2] = 502.0
          },
          pieceType = 1
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "只要队伍在其周围一圈内移动，就会受到伤害（该怪的(攻-防 )*0.25）"
    }
  },
  name = "102701 暗能萦绕",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600061,
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
