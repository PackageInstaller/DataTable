AutoTest_230710_132840 = {
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
        args = {pieceType = 2}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 505
        }
      },
      [5] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [6] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 503,
          trapIds = {
            [1] = 5.32400209E8
          },
          trigger = 88
        }
      },
      [7] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 1,
          pos = 504,
          trigger = 88
        }
      },
      [8] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 1,
          pos = 403,
          trigger = 88
        }
      },
      [9] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 1,
          pos = 603,
          trigger = 88
        }
      },
      [10] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 503.0
          },
          skillIndex = 1
        }
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
        action = "FakeInputDoubleClick",
        args = {}
      },
      [19] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [20] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [21] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [22] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [23] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [24] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [25] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [26] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [27] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [28] = {
        action = "CheckGridTrap",
        args = {
          exist = false,
          pos = 503,
          trapIds = {
            [1] = 5.32400209E8
          },
          trigger = 88
        }
      },
      [29] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [30] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "任选一个空格子，周围四格转为水，中间格子变成cd9的坏格子"
    }
  },
  name = "sp白兰主动技",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 0,
      id = 1502051,
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
