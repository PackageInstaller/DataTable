AutoTest_230104_184551 = {
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
          id = 5100111,
          name = "e1",
          pos = 507
        }
      },
      [4] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "skillFinalParam",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_WeikeCompanionNormalAttack",
          skillid = 4301831,
          trigger = 102,
          varname = "v1"
        }
      },
      [5] = {
        action = "CheckLocalValue",
        args = {
          target = 1.0299999713898,
          trigger = 102,
          varname = "v1"
        }
      },
      [6] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 505.0,
            [5] = 506.0
          },
          pieceType = 1
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "被动强化目标身上的每层印记回提高3%的最终伤害"
    }
  },
  name = "厘青觉醒Ⅱ",
  petList = {
    [1] = {
      awakening = 3,
      equiplv = 1,
      grade = 2,
      id = 1501831,
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
