AutoTest_221021_151908 = {
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
        action = "SetEntityHP",
        args = {hp = 100000, name = "team"}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 5100111,
          name = "e1",
          pos = 505
        }
      },
      [5] = {
        action = "SetEntityHPPercent",
        args = {name = "e1", percent = 0.0099999997764826}
      },
      [6] = {
        action = "AddBuffToEntity",
        args = {buffID = 10450301, name = "e1"}
      },
      [7] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 10450301,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [8] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [9] = {
        action = "CheckEntityHP",
        args = {
          compare = "==",
          hp = 208,
          name = "e1",
          trigger = 4
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "对星灵造成伤害后回血，恢复血量为所造成伤害的400%"
    }
  },
  name = "吸血Ⅲ",
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
      id = 1601561,
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
