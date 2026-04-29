AutoTest_220725_191441 = {
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
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [4] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [5] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 204
        }
      },
      [8] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 304
        }
      },
      [9] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 404
        }
      },
      [10] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e4",
          pos = 504
        }
      },
      [11] = {
        action = "SetAllMonstersHP",
        args = {value = 99999}
      },
      [12] = {
        action = "CheckUIPetLayerCount",
        args = {
          expect = 10,
          name = "p1",
          trigger = 27
        }
      },
      [13] = {
        action = "CheckUIPetLayerCount",
        args = {
          expect = 10,
          name = "p1",
          trigger = 28
        }
      },
      [14] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 403.0,
            [4] = 303.0,
            [5] = 203.0,
            [6] = 104.0,
            [7] = 205.0,
            [8] = 305.0,
            [9] = 405.0,
            [10] = 505.0,
            [11] = 604.0
          },
          pieceType = 1
        }
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [16] = {
        action = "CheckUIPetLayerCount",
        args = {
          expect = 0,
          name = "p1",
          trigger = 0
        }
      },
      [17] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e5",
          pos = 206
        }
      },
      [18] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e6",
          pos = 306
        }
      },
      [19] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e7",
          pos = 406
        }
      },
      [20] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e8",
          pos = 506
        }
      },
      [21] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [22] = {
        action = "CheckUIPetLayerCount",
        args = {
          expect = 14,
          name = "p1",
          trigger = 27
        }
      },
      [23] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 604.0,
            [2] = 503.0,
            [3] = 403.0,
            [4] = 303.0,
            [5] = 203.0,
            [6] = 104.0,
            [7] = 205.0,
            [8] = 305.0,
            [9] = 405.0,
            [10] = 505.0
          },
          pieceType = 1
        }
      },
      [24] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [25] = {
        action = "CheckUIPetLayerCount",
        args = {
          expect = 4,
          name = "p1",
          trigger = 0
        }
      },
      [26] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [27] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "保持过载条件：若回合结束时能量大于10层，能量减半，至少扣除10点"
    }
  },
  name = "sp巴顿觉醒2",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 2,
      id = 1601551,
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
