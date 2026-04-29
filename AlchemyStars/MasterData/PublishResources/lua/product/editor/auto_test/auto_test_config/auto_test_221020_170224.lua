AutoTest_221020_170224 = {
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
          pos = 505
        }
      },
      [4] = {
        action = "SetEntityHP",
        args = {hp = 10, name = "e1"}
      },
      [5] = {
        action = "AddBuffToEntity",
        args = {buffID = 101901, name = "e1"}
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 305
        }
      },
      [7] = {
        action = "CheckEntityHP",
        args = {
          compare = "==",
          hp = 5263,
          name = "e2",
          trigger = 88
        }
      },
      [8] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 403.0,
            [3] = 304.0,
            [4] = 404.0,
            [5] = 504.0
          },
          pieceType = 1
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "死亡后，剩余敌人血量回满"
    },
    [2] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 505
        }
      },
      [4] = {
        action = "AddBuffToAllMonsters",
        args = {buffID = 101901}
      },
      [5] = {
        action = "CheckEntityHP",
        args = {
          compare = ">",
          hp = 5263,
          name = "e2",
          trigger = 88
        }
      },
      [6] = {
        action = "CheckEntityHP",
        args = {
          compare = ">",
          hp = 5263,
          name = "e3",
          trigger = 88
        }
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 504.0,
            [2] = 404.0,
            [3] = 304.0
          },
          pieceType = 1
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "未死亡，剩余敌人血量不回满"
    }
  },
  name = "101901败者之祭",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
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
