AutoTest_221026_115557 = {
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
        args = {hp = 999999, name = "team"}
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
        action = "AddBuffToEntity",
        args = {buffID = 10600701, name = "e1"}
      },
      [6] = {
        action = "AddBuffToEntity",
        args = {buffID = 10600702, name = "e1"}
      },
      [7] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [8] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e1",
          trigger = 88
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
      name = "攻击未命中玩家，累积的瘀伤值不转化为生命值。"
    },
    [2] = {
      [1] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "<",
          name = "e1",
          trigger = 88
        }
      },
      [2] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [3] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "攻击命中玩家，可将累积的瘀伤值转化为生命值。"
    }
  },
  name = "106007命中恢复",
  petList = {
    [1] = {
      awakening = 6,
      equiplv = 1,
      grade = 1,
      id = 1600061,
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
