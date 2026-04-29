AutoTest_221103_141127 = {
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
          pos = 504
        }
      },
      [4] = {
        action = "SetEntityHP",
        args = {hp = 5000, name = "e1"}
      },
      [5] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "AddBuffToAllMonsters",
        args = {buffID = 10110301}
      },
      [8] = {
        action = "CheckEntityHP",
        args = {
          compare = ">",
          hp = 5000,
          name = "e1",
          trigger = 0
        }
      },
      [9] = {
        action = "CheckEntityHP",
        args = {
          compare = "==",
          hp = 3000,
          name = "e1",
          trigger = 0
        }
      },
      [10] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "defencePercentage",
          damageIndex = 1,
          defname = "e1",
          key = "FinalDef",
          skillid = 100006,
          trigger = 102,
          varname = "v1"
        }
      },
      [11] = {
        action = "CheckLocalValue",
        args = {
          target = 1.5,
          trigger = 88,
          varname = "v1"
        }
      },
      [12] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 10110301,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [13] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0
          },
          pieceType = 1
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "自身最大血量降低40%，但防御力提高150%"
    }
  },
  name = "101103 坚毅III",
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
