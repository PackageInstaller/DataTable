AutoTest_230414_142745 = {
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
        action = "CheckFormulaAttr",
        args = {
          attr = "skillFinalParam",
          defname = "e1",
          expect = 1.0,
          key = "CalcDamage_1",
          skillid = 100191,
          trigger = 102
        }
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
        action = "CheckFormulaAttr",
        args = {
          attr = "skillFinalParam",
          defname = "e1",
          expect = 1.0423412322998,
          key = "CalcDamage_1",
          skillid = 100191,
          trigger = 102
        }
      },
      [8] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "CheckFormulaAttr",
        args = {
          attr = "skillFinalParam",
          defname = "e1",
          expect = 1.0846825838089,
          key = "CalcDamage_1",
          skillid = 100191,
          trigger = 102
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
      name = "哈提觉一"
    }
  },
  name = "哈提觉醒1",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1601911,
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
