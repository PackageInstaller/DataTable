AutoTest_221103_150124 = {
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
          pos = 305
        }
      },
      [4] = {
        action = "AddBuffToEntity",
        args = {buffID = 88841018, name = "team"}
      },
      [5] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "rate",
          damageIndex = 1,
          defname = "team",
          key = "CalcAddBlood",
          skillid = 200471,
          trigger = 102,
          varname = "v1"
        }
      },
      [6] = {
        action = "CheckLocalValue",
        args = {
          target = -0.5,
          trigger = 88,
          varname = "v1"
        }
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 402.0,
            [3] = 302.0,
            [4] = 202.0,
            [5] = 103.0,
            [6] = 104.0
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
        action = "CaptureFormulaAttr",
        args = {
          attr = "rate",
          damageIndex = 1,
          defname = "team",
          key = "CalcAddBlood",
          skillid = 300047,
          trigger = 102,
          varname = "v1"
        }
      },
      [11] = {
        action = "CheckLocalValue",
        args = {
          target = -0.5,
          trigger = 88,
          varname = "v1"
        }
      },
      [12] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 104.0
          }
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "所有光灵获得的治疗效果减半。"
    }
  },
  name = "40018黯障滞光",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1300471,
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
