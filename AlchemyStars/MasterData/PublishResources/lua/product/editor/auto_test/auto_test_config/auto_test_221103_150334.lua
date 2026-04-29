AutoTest_221103_150334 = {
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
        action = "AddBuffToEntity",
        args = {buffID = 30011, name = "team"}
      },
      [5] = {
        action = "CheckUILayerShieldCount",
        args = {
          expect = 2,
          name = "team",
          trigger = 88
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
      name = "怪物每回合可以普攻2次。（没buff普攻一次）"
    },
    [2] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "AddBuffToEntity",
        args = {buffID = 88840001, name = "e1"}
      },
      [3] = {
        action = "AddBuffToEntity",
        args = {buffID = 30011, name = "team"}
      },
      [4] = {
        action = "CheckUILayerShieldCount",
        args = {
          expect = 3,
          name = "team",
          trigger = 0
        }
      },
      [5] = {
        action = "CheckUILayerShieldCount",
        args = {
          expect = 1,
          name = "team",
          trigger = 88
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
      name = "怪物每回合可以普攻2次。"
    }
  },
  name = "40001贪婪之徒",
  petList = {
    [1] = {
      awakening = 6,
      equiplv = 10,
      grade = 3,
      id = 1601481,
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
