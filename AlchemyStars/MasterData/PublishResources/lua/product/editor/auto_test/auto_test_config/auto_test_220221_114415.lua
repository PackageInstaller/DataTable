AutoTest_220221_114415 = {
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
        action = "SetPieceType",
        args = {pieceType = 4}
      },
      [4] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 1,
          pos = 405,
          trigger = 88
        }
      },
      [5] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 1,
          pos = 606,
          trigger = 88
        }
      },
      [6] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 1,
          pos = 903,
          trigger = 88
        }
      },
      [7] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 207,
          trigger = 88
        }
      },
      [8] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 405.0,
            [2] = 606.0,
            [3] = 903.0,
            [4] = 207.0
          }
        }
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
        action = "FakeInputDoubleClick",
        args = {}
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
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
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [19] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "突3：先制攻击 突6：CD-1"
    }
  },
  name = "伯利恒突3突6",
  petList = {
    [1] = {
      awakening = 6,
      equiplv = 1,
      grade = 3,
      id = 1600771,
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
