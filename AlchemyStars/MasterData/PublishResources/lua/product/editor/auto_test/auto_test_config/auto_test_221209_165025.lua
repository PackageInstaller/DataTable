AutoTest_221209_165025 = {
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
          id = 10131015,
          name = "e1",
          pos = 507
        }
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
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 702.0,
            [4] = 701.0,
            [5] = 601.0,
            [6] = 501.0,
            [7] = 401.0,
            [8] = 402.0,
            [9] = 403.0,
            [10] = 503.0,
            [11] = 504.0,
            [12] = 505.0,
            [13] = 506.0,
            [14] = 507.0,
            [15] = 508.0,
            [16] = 509.0,
            [17] = 409.0,
            [18] = 309.0,
            [19] = 208.0
          },
          pieceType = 1
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [11] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 208.0,
            [2] = 308.0,
            [3] = 408.0,
            [4] = 407.0,
            [5] = 507.0,
            [6] = 607.0
          },
          pieceType = 1
        }
      },
      [12] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Power",
          expect = 1.0,
          name = "p1",
          trigger = 0
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "主动技cd-1；若上回合未施放，施放后本回合的极光时刻也可以穿怪"
    }
  },
  name = "歌尔蒂突破Ⅵ",
  petList = {
    [1] = {
      awakening = 6,
      equiplv = 1,
      grade = 3,
      id = 1601771,
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
