AutoTest_211214_172127 = {
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
          expect = 10,
          name = "p1",
          trigger = 88
        }
      },
      [5] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 410117,
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
          skillid = 100117,
          trigger = 102,
          varname = "v1"
        }
      },
      [8] = {
        action = "CheckLocalValue",
        args = {
          target = 0.019999999552965,
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
      name = "每波次开始时，增加10层狂化值，每提高一层增加XXX%的基础攻击力，最大99层"
    }
  },
  name = "克觉醒1",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 1,
      id = 1601171,
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
