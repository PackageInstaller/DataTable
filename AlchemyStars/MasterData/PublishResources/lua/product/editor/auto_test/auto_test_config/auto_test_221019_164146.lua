AutoTest_221019_164146 = {
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
          pos = 504
        }
      },
      [4] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "defence",
          damageIndex = 1,
          defname = "team",
          key = "FinalDef",
          skillid = 1002801,
          trigger = 102,
          varname = "v1"
        }
      },
      [5] = {
        action = "CheckLocalValue",
        args = {
          target = 592.0,
          trigger = 102,
          varname = "v1"
        }
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
        action = "AddBuffToEntity",
        args = {buffID = 104201, name = "e1"}
      },
      [9] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "defence",
          damageIndex = 1,
          defname = "team",
          key = "FinalDef",
          skillid = 1002801,
          trigger = 102,
          varname = "v2"
        }
      },
      [10] = {
        action = "CheckLocalValue",
        args = {
          target = 197.0,
          trigger = 102,
          varname = "v2"
        }
      },
      [11] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "对星灵造成伤害时，无视队员防御力，只计算队长的防御力"
    }
  },
  name = "防御瓦解",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1601561,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1200501,
      level = 1,
      name = "p1"
    },
    [3] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1300221,
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
