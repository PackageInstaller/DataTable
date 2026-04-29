AutoTest_230508_201209 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [3] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "team"}
      },
      [4] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 502}
      },
      [5] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "team",
          trigger = 88
        }
      },
      [6] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "team",
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
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "team",
          trigger = 88
        }
      },
      [12] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 702.0,
            [4] = 802.0,
            [5] = 701.0,
            [6] = 601.0,
            [7] = 501.0,
            [8] = 401.0,
            [9] = 301.0,
            [10] = 402.0,
            [11] = 302.0,
            [12] = 202.0,
            [13] = 203.0,
            [14] = 103.0,
            [15] = 104.0,
            [16] = 105.0,
            [17] = 204.0,
            [18] = 303.0,
            [19] = 403.0,
            [20] = 503.0,
            [21] = 603.0,
            [22] = 703.0,
            [23] = 803.0,
            [24] = 903.0,
            [25] = 904.0,
            [26] = 804.0,
            [27] = 704.0
          },
          pieceType = 1
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "怪物技能伤害"
    }
  },
  name = "斐桀洛",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 3,
      id = 1600061,
      level = 1,
      name = "p1"
    }
  },
  remotePet = {},
  setup = {
    [1] = {
      args = {levelID = 101614, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
