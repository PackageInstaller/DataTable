AutoTest_221019_152452 = {
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
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 405
        }
      },
      [5] = {
        action = "AddBuffToEntity",
        args = {buffID = 10030301, name = "e1"}
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
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [9] = {
        action = "SetEntityAttack",
        args = {attack = 999999, name = "p1"}
      },
      [10] = {
        action = "CheckEntityHP",
        args = {
          compare = "==",
          hp = 4842,
          name = "e1",
          trigger = 102
        }
      },
      [11] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 404.0,
            [5] = 304.0
          },
          pieceType = 1
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [13] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [14] = {
        action = "CheckMonsterCount",
        args = {
          count = 1,
          monsterid = 5100111,
          trigger = 88
        }
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "单次伤害超过自身最大血量8%的，则忽略超过部分的伤害量（怪物血量5263）"
    }
  },
  name = "免伤Ⅲ",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1600231,
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
