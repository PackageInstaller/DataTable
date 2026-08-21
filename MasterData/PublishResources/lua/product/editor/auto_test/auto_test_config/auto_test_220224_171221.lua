AutoTest_220224_171221 = {
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
          dir = 5,
          disableai = false,
          id = 5100111,
          name = "e1",
          pos = 707
        }
      },
      [4] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 402.0,
            [3] = 302.0,
            [4] = 202.0,
            [5] = 103.0,
            [6] = 203.0,
            [7] = 303.0,
            [8] = 403.0,
            [9] = 503.0,
            [10] = 603.0,
            [11] = 703.0,
            [12] = 803.0,
            [13] = 903.0,
            [14] = 904.0,
            [15] = 804.0,
            [16] = 704.0
          },
          pieceType = 1
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [6] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 704.0,
            [2] = 604.0,
            [3] = 504.0,
            [4] = 404.0,
            [5] = 304.0,
            [6] = 204.0,
            [7] = 104.0,
            [8] = 105.0,
            [9] = 205.0,
            [10] = 305.0,
            [11] = 405.0,
            [12] = 505.0,
            [13] = 605.0,
            [14] = 705.0,
            [15] = 805.0,
            [16] = 905.0
          },
          pieceType = 1
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Ready",
          attr_select_index = 11,
          expect = 1.0,
          name = "p1",
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
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 506.0,
            [2] = 407.0
          }
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "主动技强化：极光时刻下达成15连，主动技cd-1"
    }
  },
  name = "希诺普觉醒3",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1601381,
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
