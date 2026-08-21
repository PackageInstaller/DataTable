AutoTest_240328_170503 = {
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
          pos = 609
        }
      },
      [5] = {
        action = "CheckUIPetLayerCount",
        args = {
          expect = 6,
          name = "p1",
          trigger = 88
        }
      },
      [6] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 402.0,
            [3] = 302.0,
            [4] = 203.0,
            [5] = 303.0,
            [6] = 403.0,
            [7] = 503.0
          },
          pieceType = 2
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 2,
          pos = 608,
          trigger = 88
        }
      },
      [9] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 2,
          pos = 607,
          trigger = 88
        }
      },
      [10] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 2,
          pos = 606,
          trigger = 88
        }
      },
      [11] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 2,
          pos = 605,
          trigger = 88
        }
      },
      [12] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 2,
          pos = 602,
          trigger = 88
        }
      },
      [13] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 2,
          pos = 601,
          trigger = 88
        }
      },
      [14] = {
        action = "CheckUIPetLayerCount",
        args = {
          expect = 8,
          name = "p1",
          trigger = 88
        }
      },
      [15] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 503.0,
            [2] = 504.0,
            [3] = 505.0
          },
          pieceType = 2
        }
      },
      [16] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [17] = {
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 608,
          trigger = 88
        }
      },
      [18] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 609.0,
            [2] = 608.0
          },
          skillIndex = 2
        }
      },
      [19] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "每次经过火格子时获得1层，消耗X  8层可以强制位移场上一个单位，每回合限1次。"
    }
  },
  name = "仲胥觉醒1",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 1,
      id = 1601811,
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
