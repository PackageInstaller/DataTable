AutoTest_220224_162049 = {
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
        args = {pieceType = 3}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 5,
          disableai = false,
          id = 5100111,
          name = "e1",
          pos = 509
        }
      },
      [5] = {
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
            [16] = 704.0,
            [17] = 604.0,
            [18] = 504.0,
            [19] = 404.0,
            [20] = 304.0,
            [21] = 204.0,
            [22] = 104.0,
            [23] = 105.0,
            [24] = 205.0,
            [25] = 305.0,
            [26] = 405.0,
            [27] = 505.0,
            [28] = 605.0,
            [29] = 705.0,
            [30] = 706.0,
            [31] = 606.0,
            [32] = 506.0
          },
          pieceType = 3
        }
      },
      [6] = {
        action = "CheckUIPetLayerCount",
        args = {
          expect = 31,
          name = "p1",
          trigger = 88
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "连线每经过一个森格子叠加一层印记，强化森叠加3层，最大99层；受到伤害前，将立即清空层数，每层提供希诺普防御力XXX%的护盾（没有层数则不触发）"
    }
  },
  name = "希诺普觉醒1（不好实现）",
  petList = {
    [1] = {
      awakening = 6,
      equiplv = 1,
      grade = 1,
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
