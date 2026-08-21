AutoTest_221103_150239 = {
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
        action = "AddBuffToEntity",
        args = {buffID = 88842023, name = "p1"}
      },
      [5] = {
        action = "AddBuffToEntity",
        args = {buffID = 88841023, name = "e1"}
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
        action = "CheckEntityBuff",
        args = {
          buffId = 20011,
          exist = true,
          name = "team",
          trigger = 88
        }
      },
      [9] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "attackPercentage",
          damageIndex = 1,
          defname = "e1",
          key = "FinalAtk",
          skillid = 100148,
          trigger = 102,
          varname = "v1"
        }
      },
      [10] = {
        action = "CheckLocalValue",
        args = {
          target = 0.60000002384186,
          trigger = 88,
          varname = "v1"
        }
      },
      [11] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 604.0,
            [4] = 705.0,
            [5] = 606.0,
            [6] = 507.0,
            [7] = 506.0
          },
          pieceType = 1
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "怪物移动时生成火焰陷阱，玩家踩入将被灼烧，每层灼烧提高玩家30%攻击。"
    }
  },
  name = "400231狱火步行",
  petList = {
    [1] = {
      awakening = 6,
      equiplv = 10,
      grade = 1,
      id = 1601481,
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
