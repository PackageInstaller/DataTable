AutoTest_220628_152417 = {
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
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 508
        }
      },
      [5] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 705.0
          }
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "attackPercentage",
          defname = "e1",
          key = "FinalAtk",
          skillid = 2201481,
          trigger = 102,
          varname = "v1"
        }
      },
      [8] = {
        action = "CheckLocalValue",
        args = {
          target = 0.079999998211861,
          trigger = 88,
          varname = "v1"
        }
      },
      [9] = {
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
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "突3：被动强化：范围扩大到两圈"
    }
  },
  name = "清瞳突3",
  petList = {
    [1] = {
      affinity = 0,
      awakening = 3,
      equiplv = 1,
      grade = 3,
      id = 1601481,
      level = 1,
      name = "p1"
    }
  },
  setup = {
    [1] = {
      args = {levelID = 1, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
