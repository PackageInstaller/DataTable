AutoTest_221103_150103 = {
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
          id = 5105711,
          name = "e1",
          pos = 305
        }
      },
      [4] = {
        action = "AddBuffToEntity",
        args = {buffID = 88840035, name = "e1"}
      },
      [5] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [6] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "MaxHP",
          expect = 161098.0,
          name = "e1",
          trigger = 88
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [12] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 4,
          pos = 501,
          trigger = 0
        }
      },
      [13] = {
        action = "CheckPieceType",
        args = {
          pieceType = 4,
          pos = 501,
          trigger = 0
        }
      },
      [14] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [16] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [17] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [18] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [19] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [20] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 3,
          pos = 501,
          trigger = 0
        }
      },
      [21] = {
        action = "CheckPieceType",
        args = {
          pieceType = 3,
          pos = 501,
          trigger = 0
        }
      },
      name = "先蛇的血量获得大幅度提升，并且每三回合重置一次房间地形。"
    }
  },
  name = "40035先蛇之境",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1400071,
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
