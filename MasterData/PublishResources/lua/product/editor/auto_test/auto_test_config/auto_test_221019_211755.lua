AutoTest_221019_211755 = {
  cases = {
    [1] = {
      [1] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 502}
      },
      [2] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 505
        }
      },
      [3] = {
        action = "AddBuffToEntity",
        args = {buffID = 10180301, name = "e1"}
      },
      [4] = {
        action = "AddBuffToEntity",
        args = {buffID = 10180302, name = "e1"}
      },
      [5] = {
        action = "AddBuffToEntity",
        args = {buffID = 10180303, name = "e1"}
      },
      [6] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 98,
          layerType = 10180301,
          name = "e1",
          trigger = 102
        }
      },
      [7] = {
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
      [8] = {
        action = "CheckLocalValue",
        args = {
          target = 3.0,
          trigger = 102,
          varname = "v1"
        }
      },
      [9] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "defencePercentage",
          damageIndex = 1,
          defname = "e1",
          key = "FinalDef",
          skillid = 200061,
          trigger = 102,
          varname = "v2"
        }
      },
      [10] = {
        action = "CheckLocalValue",
        args = {
          target = 2.9700000286102,
          trigger = 102,
          varname = "v2"
        }
      },
      [11] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 78,
          layerType = 10180301,
          name = "e1",
          trigger = 88
        }
      },
      [12] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0
          },
          pieceType = 1
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [14] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "defencePercentage",
          damageIndex = 1,
          defname = "e1",
          key = "FinalDef",
          skillid = 100006,
          trigger = 102,
          varname = "v3"
        }
      },
      [15] = {
        action = "CheckLocalValue",
        args = {
          target = 2.3399999141693,
          trigger = 102,
          varname = "v3"
        }
      },
      [16] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 57,
          layerType = 10180301,
          name = "e1",
          trigger = 88
        }
      },
      [17] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [18] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "出生100层buff，每层3%防御力，每次受伤减少1层，回合结束少20层"
    },
    [2] = {
      [1] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 404
        }
      },
      [2] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 605
        }
      },
      [3] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 0,
          layerType = 10180301,
          name = "e2",
          trigger = 102
        }
      },
      [4] = {
        action = "AddBuffToEntity",
        args = {buffID = 10180301, name = "e3"}
      },
      [5] = {
        action = "AddBuffToEntity",
        args = {buffID = 10180302, name = "e3"}
      },
      [6] = {
        action = "AddBuffToEntity",
        args = {buffID = 10180303, name = "e3"}
      },
      [7] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 100,
          layerType = 10180301,
          name = "e3",
          trigger = 102
        }
      },
      [8] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "defencePercentage",
          damageIndex = 1,
          defname = "e2",
          key = "FinalDef",
          skillid = 100006,
          trigger = 102,
          varname = "v4"
        }
      },
      [9] = {
        action = "CheckLocalValue",
        args = {
          target = 0.0,
          trigger = 88,
          varname = "v4"
        }
      },
      [10] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "怪物出生无BUFF"
    },
    [3] = {
      [1] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 80,
          layerType = 10180301,
          name = "e3",
          trigger = 102
        }
      },
      [2] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [3] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "未受到伤害每回合减少10层BUFF"
    }
  },
  name = "101803战痕III",
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
