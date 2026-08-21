AutoTest_240328_163206 = {
  cases = {
    [1] = {
      [1] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 4,
          pos = 505,
          trigger = 88
        }
      },
      [2] = {
        action = "CheckPieceType",
        args = {
          pieceType = 4,
          pos = 505,
          trigger = 88
        }
      },
      [3] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 505.0
          },
          skillIndex = 1
        }
      },
      [4] = {
        action = "WaitGameFsm",
        args = {id = 5}
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
        action = "FakeInputDoubleClick",
        args = {}
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
        action = "CheckRenderPieceType",
        args = {
          pieceType = 4,
          pos = 504,
          trigger = 88
        }
      },
      [18] = {
        action = "CheckPieceType",
        args = {
          pieceType = 4,
          pos = 504,
          trigger = 88
        }
      },
      [19] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          },
          skillIndex = 1
        }
      },
      [20] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "第7回合开始，增加一次使用机会"
    }
  },
  name = "三十三号突破5",
  petList = {
    [1] = {
      awakening = 5,
      equipRefineLv = 0,
      equiplv = 0,
      grade = 0,
      id = 1502131,
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
