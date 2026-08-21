AutoTest_220225_183354 = {
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
          id = 2070224,
          name = "e1",
          pos = 303
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 2100212,
          name = "e2",
          pos = 604
        }
      },
      [5] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [6] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e2",
          trigger = 88
        }
      },
      [7] = {
        action = "CheckFormulaAttr",
        args = {
          attr = "skillFinalParam",
          attr_select_index = 11,
          defname = "e2",
          expect = 1.0299999713898,
          key = "CalcDamage_1",
          key_select_index = 5,
          skillid = 1001421,
          trigger = 102
        }
      },
      [8] = {
        action = "CheckFormulaAttr",
        args = {
          attr = "skillFinalParam",
          attr_select_index = 11,
          defname = "e1",
          expect = 1.0210000276566,
          key = "CalcDamage_1",
          key_select_index = 5,
          skillid = 1001421,
          trigger = 102
        }
      },
      [9] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 402.0,
            [3] = 302.0,
            [4] = 203.0,
            [5] = 304.0,
            [6] = 403.0,
            [7] = 504.0
          },
          pieceType = 1
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "被动强化：普攻3的倍数跟5的倍数都触发"
    }
  },
  name = "花云觉醒2",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 2,
      id = 1501421,
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
