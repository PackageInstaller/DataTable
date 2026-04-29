AutoTest_221103_161323 = {
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
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [9] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [11] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 4,
          pos = 501,
          trigger = 0
        }
      },
      [12] = {
        action = "CheckPieceType",
        args = {
          pieceType = 4,
          pos = 501,
          trigger = 0
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
      [15] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [16] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [17] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [18] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [19] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 3,
          pos = 501,
          trigger = 0
        }
      },
      [20] = {
        action = "CheckPieceType",
        args = {
          pieceType = 3,
          pos = 501,
          trigger = 0
        }
      },
      name = "每三回合房间地形会自动重置一次。"
    }
  },
  name = "40015紊流漩涡",
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
