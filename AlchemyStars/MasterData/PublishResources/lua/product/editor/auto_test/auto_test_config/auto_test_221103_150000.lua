AutoTest_221103_150000 = {
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
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 305
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 703
        }
      },
      [6] = {
        action = "AddBuffToEntity",
        args = {buffID = 88841020, name = "team"}
      },
      [7] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "team",
          trigger = 88
        }
      },
      [8] = {
        action = "CheckEntityHP",
        args = {
          compare = "==",
          hp = 9234,
          name = "team",
          trigger = 88
        }
      },
      [9] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 603.0
          },
          pieceType = 1
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [11] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "team",
          trigger = 88
        }
      },
      [12] = {
        action = "CheckEntityHP",
        args = {
          compare = "==",
          hp = 8748,
          name = "team",
          trigger = 88
        }
      },
      [13] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "怪物死亡时，玩家损失5%最大生命值的血量。"
    }
  },
  name = "40020死亡复仇",
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
