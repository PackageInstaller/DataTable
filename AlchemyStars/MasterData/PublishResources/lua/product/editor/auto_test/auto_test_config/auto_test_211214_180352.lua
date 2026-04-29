AutoTest_211214_180352 = {
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
          pos = 503
        }
      },
      [4] = {
        action = "CheckUIPetLayerCount",
        args = {
          expect = 8,
          name = "p1",
          trigger = 0
        }
      },
      [5] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 410119,
          exist = true,
          name = "p1",
          trigger = 88
        }
      },
      [6] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [7] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "attackPercentage",
          attr_select_index = 11,
          defname = "e1",
          key = "FinalAtk",
          key_select_index = 2,
          skillid = 100119,
          trigger = 102,
          varname = "v1"
        }
      },
      [8] = {
        action = "CheckLocalValue",
        args = {
          target = 0.024000000208616,
          trigger = 88,
          varname = "v1"
        }
      },
      [9] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "每波次开始时获得7层狂化，每回合开始获得1层狂化，每层狂化提高XXX%的基础攻击力，最大99层"
    }
  },
  name = "雷文顿觉醒1",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 1,
      id = 1601191,
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
