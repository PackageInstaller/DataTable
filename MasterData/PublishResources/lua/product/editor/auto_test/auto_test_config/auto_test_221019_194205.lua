AutoTest_221019_194205 = {
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
        args = {buffID = 10180101, name = "e1"}
      },
      [4] = {
        action = "AddBuffToEntity",
        args = {buffID = 10180102, name = "e1"}
      },
      [5] = {
        action = "AddBuffToEntity",
        args = {buffID = 10180103, name = "e1"}
      },
      [6] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 28,
          layerType = 10180101,
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
          target = 0.89999997615814,
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
          target = 0.87000000476837,
          trigger = 102,
          varname = "v2"
        }
      },
      [11] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 18,
          layerType = 10180101,
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
          target = 0.54000002145767,
          trigger = 102,
          varname = "v3"
        }
      },
      [16] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 7,
          layerType = 10180101,
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
      name = "出生30层buff，每层3%防御力，每次受伤减少1层，回合结束少10层"
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
          layerType = 10180101,
          name = "e2",
          trigger = 102
        }
      },
      [4] = {
        action = "AddBuffToEntity",
        args = {buffID = 10180101, name = "e3"}
      },
      [5] = {
        action = "AddBuffToEntity",
        args = {buffID = 10180102, name = "e3"}
      },
      [6] = {
        action = "AddBuffToEntity",
        args = {buffID = 10180103, name = "e3"}
      },
      [7] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 30,
          layerType = 10180101,
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
          layer = 20,
          layerType = 10180101,
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
  name = "101801战痕I",
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
