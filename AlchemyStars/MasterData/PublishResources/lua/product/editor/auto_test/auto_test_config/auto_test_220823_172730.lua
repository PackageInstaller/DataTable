AutoTest_220823_172730 = {
  cases = {
    [1] = {
      [1] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 101311,
          name = "e1",
          pos = 604
        }
      },
      [2] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 101312,
          name = "e2",
          pos = 703
        }
      },
      [3] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 502}
      },
      [4] = {
        action = "ChangeTeamLeader",
        args = {index = 2}
      },
      [5] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "skillIncreaseParam",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_1",
          skillid = 100160,
          trigger = 102,
          varname = "v1"
        }
      },
      [6] = {
        action = "CheckLocalValue",
        args = {
          target = 3.1500000953674,
          trigger = 88,
          varname = "v1"
        }
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 603.0
          },
          pieceType = 1
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "FOX从队员换到队长位后，本回合普攻伤害率提高15%"
    }
  },
  name = "喜多川突破6",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 0,
      grade = 2,
      id = 1300471,
      level = 1,
      name = "p2"
    },
    [2] = {
      awakening = 5,
      equiplv = 10,
      grade = 1,
      id = 1501601,
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
