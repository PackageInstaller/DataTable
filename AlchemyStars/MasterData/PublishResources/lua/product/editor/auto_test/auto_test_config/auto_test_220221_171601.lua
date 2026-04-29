AutoTest_220221_171601 = {
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
          dir = 5,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 803
        }
      },
      [4] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 505.0,
            [5] = 506.0,
            [6] = 507.0,
            [7] = 508.0,
            [8] = 509.0,
            [9] = 609.0,
            [10] = 608.0,
            [11] = 607.0,
            [12] = 606.0,
            [13] = 605.0,
            [14] = 604.0,
            [15] = 603.0,
            [16] = 602.0
          },
          pieceType = 1
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [6] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "attackPercentage",
          attr_select_index = 12,
          defname = "e1",
          key = "FinalAtk",
          key_select_index = 3,
          skillid = 100132,
          trigger = 102,
          varname = "v1"
        }
      },
      [7] = {
        action = "CheckLocalValue",
        args = {
          target = 0.15000000596046,
          trigger = 88,
          varname = "v1"
        }
      },
      [8] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "attackPercentage",
          attr_select_index = 12,
          defname = "e1",
          key = "FinalAtk",
          key_select_index = 3,
          skillid = 2001321,
          trigger = 102,
          varname = "v2"
        }
      },
      [9] = {
        action = "CheckLocalValue",
        args = {
          target = 0.15000000596046,
          trigger = 88,
          varname = "v2"
        }
      },
      [10] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 602.0,
            [2] = 601.0,
            [3] = 701.0,
            [4] = 702.0,
            [5] = 703.0
          },
          pieceType = 1
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "极光时刻期间，攻击力提高XXX%"
    }
  },
  name = "爱洛拉觉醒1",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 1,
      id = 1501321,
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
