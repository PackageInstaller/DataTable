AutoTest_240415_144102 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 701}
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 2001901,
          name = "e1",
          pos = 703
        }
      },
      [4] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "team"}
      },
      [5] = {
        action = "SetEntityAttack",
        args = {attack = 1000, name = "p1"}
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
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 702,
          trigger = 0
        }
      },
      [9] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Mobility",
          expect = 4.0,
          name = "e1",
          trigger = 0
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "提灯怪物穿墙未通过时行动力加1"
    }
  },
  name = "提灯小怪",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 0,
      id = 1400071,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 3,
      id = 1600281,
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
