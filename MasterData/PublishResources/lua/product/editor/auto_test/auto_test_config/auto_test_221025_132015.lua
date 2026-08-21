AutoTest_221025_132015 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100112,
          name = "e1",
          pos = 305
        }
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 705
        }
      },
      [4] = {
        action = "AddBuffToEntity",
        args = {buffID = 10490101, name = "e1"}
      },
      [5] = {
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 304,
          trigger = 88
        }
      },
      [6] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 2,
          pos = 304,
          trigger = 88
        }
      },
      [7] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 704,
          trigger = 88
        }
      },
      [8] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 1,
          pos = 704,
          trigger = 88
        }
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
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 205,
          trigger = 88
        }
      },
      [12] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 2,
          pos = 205,
          trigger = 88
        }
      },
      [13] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 605,
          trigger = 88
        }
      },
      [14] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 1,
          pos = 605,
          trigger = 88
        }
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
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 306,
          trigger = 88
        }
      },
      [18] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 2,
          pos = 306,
          trigger = 88
        }
      },
      [19] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 706,
          trigger = 88
        }
      },
      [20] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 1,
          pos = 706,
          trigger = 88
        }
      },
      [21] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [22] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [23] = {
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 405,
          trigger = 88
        }
      },
      [24] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 2,
          pos = 405,
          trigger = 88
        }
      },
      [25] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 805,
          trigger = 88
        }
      },
      [26] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 1,
          pos = 805,
          trigger = 88
        }
      },
      [27] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [28] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [29] = {
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 304,
          trigger = 88
        }
      },
      [30] = {
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 205,
          trigger = 88
        }
      },
      [31] = {
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 306,
          trigger = 88
        }
      },
      [32] = {
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 405,
          trigger = 88
        }
      },
      [33] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 2,
          pos = 304,
          trigger = 88
        }
      },
      [34] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 2,
          pos = 205,
          trigger = 88
        }
      },
      [35] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 2,
          pos = 306,
          trigger = 88
        }
      },
      [36] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 2,
          pos = 405,
          trigger = 88
        }
      },
      [37] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [38] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "回合开始时，将十字相邻的随机1格转色为同属性格子（有BUFF+无BUFF）"
    }
  },
  name = "104901邻位转色",
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
