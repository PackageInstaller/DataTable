AutoTest_220908_172546 = {
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
        args = {name = "team"}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100112,
          name = "e1",
          pos = 506
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
        action = "CaptureFormulaAttr",
        args = {
          attr = "defencePercentage",
          damageIndex = 1,
          defname = "e1",
          key = "FinalDef",
          skillid = 320166,
          trigger = 102,
          varname = "v1"
        }
      },
      [8] = {
        action = "CheckLocalValue",
        args = {
          target = -0.050000000745058,
          trigger = 102,
          varname = "v1"
        }
      },
      [9] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 506.0
          }
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "降低目标5%防御力，效果可叠加，持续1回合"
    },
    [2] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "defencePercentage",
          damageIndex = 1,
          defname = "e1",
          key = "FinalDef",
          skillid = 1001661,
          trigger = 102,
          varname = "v1"
        }
      },
      [3] = {
        action = "CheckLocalValue",
        args = {
          target = -0.050000000745058,
          trigger = 102,
          varname = "v1"
        }
      },
      [4] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 505.0
          },
          pieceType = 1
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新测试用例"
    },
    [3] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "defencePercentage",
          damageIndex = 1,
          defname = "e1",
          key = "FinalDef",
          skillid = 100166,
          trigger = 102,
          varname = "v1"
        }
      },
      [3] = {
        action = "CheckLocalValue",
        args = {
          target = 0.0,
          trigger = 102,
          varname = "v1"
        }
      },
      [4] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新测试用例"
    }
  },
  name = "菲雅觉醒2",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 2,
      id = 1601661,
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
