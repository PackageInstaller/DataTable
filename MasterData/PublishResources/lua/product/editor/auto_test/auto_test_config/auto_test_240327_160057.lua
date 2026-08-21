AutoTest_240327_160057 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetEntityPosition",
        args = {name = "p1", pos = 502}
      },
      [3] = {
        action = "SetPieceType",
        args = {pieceType = 4}
      },
      [4] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [6] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 602,
          trigger = 88
        }
      },
      [7] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 503,
          trigger = 88
        }
      },
      [8] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 501,
          trigger = 88
        }
      },
      [9] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 602,
          trapIds = {
            [1] = 2803501.0
          },
          trigger = 88
        }
      },
      [10] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 503,
          trapIds = {
            [1] = 2803501.0
          },
          trigger = 88
        }
      },
      [11] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 501,
          trapIds = {
            [1] = 2803501.0
          },
          trigger = 88
        }
      },
      [12] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          },
          skillIndex = 1
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "主动技上回合处于就绪状态，本回合转色数量+1"
    }
  },
  name = "维吉尔突破2",
  petList = {
    [1] = {
      awakening = 2,
      equipRefineLv = 0,
      equiplv = 0,
      grade = 0,
      id = 1502201,
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
