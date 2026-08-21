AutoTest_221026_152723 = {
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
          pos = 503
        }
      },
      [4] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "e1"}
      },
      [5] = {
        action = "AddBuffToEntity",
        args = {buffID = 10620101, name = "e1"}
      },
      [6] = {
        action = "AddBuffToEntity",
        args = {buffID = 10620102, name = "e1"}
      },
      [7] = {
        action = "AddBuffToEntity",
        args = {buffID = 10620103, name = "e1"}
      },
      [8] = {
        action = "AddBuffToEntity",
        args = {buffID = 10620104, name = "e1"}
      },
      [9] = {
        action = "AddBuffToEntity",
        args = {buffID = 10620105, name = "e1"}
      },
      [10] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [11] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "attackPercentage",
          damageIndex = 1,
          defname = "p1",
          key = "FinalAtk",
          skillid = 1002801,
          trigger = 102,
          varname = "v1"
        }
      },
      [12] = {
        action = "CheckLocalValue",
        args = {
          target = 0.20000000298023,
          trigger = 88,
          varname = "v1"
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [14] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 14,
          name = "qhgz1",
          pos = 305
        }
      },
      [15] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 14,
          name = "qhgz2",
          pos = 304
        }
      },
      [16] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [17] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [18] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [19] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [20] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [21] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "attackPercentage",
          damageIndex = 1,
          defname = "p1",
          key = "FinalAtk",
          skillid = 1002801,
          trigger = 102,
          varname = "v2"
        }
      },
      [22] = {
        action = "CheckLocalValue",
        args = {
          target = 0.28000000119209,
          trigger = 88,
          varname = "v2"
        }
      },
      [23] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [24] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 141,
          name = "rhgz1",
          pos = 305
        }
      },
      [25] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [26] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [27] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [28] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [29] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [30] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "attackPercentage",
          damageIndex = 1,
          defname = "p1",
          key = "FinalAtk",
          skillid = 1002801,
          trigger = 102,
          varname = "v3"
        }
      },
      [31] = {
        action = "CheckLocalValue",
        args = {
          target = 0.25999999046326,
          trigger = 88,
          varname = "v3"
        }
      },
      [32] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "出生携带10层攻击增加印记，每3回合吸收场上强化及弱化格子，每个强化格子累积2层印记，弱化格子则减少1层，每层印记提高2%攻击力。"
    }
  },
  name = "吸收格子",
  petList = {
    [1] = {
      awakening = 6,
      equiplv = 10,
      grade = 3,
      id = 1600061,
      level = 80,
      name = "p1"
    },
    [2] = {
      awakening = 6,
      equiplv = 10,
      grade = 3,
      id = 1600111,
      level = 80,
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
