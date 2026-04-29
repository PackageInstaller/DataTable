AutoTest_221020_150735 = {
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
          disableai = false,
          id = 5100111,
          name = "e1",
          pos = 302
        }
      },
      [4] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "e1"}
      },
      [5] = {
        action = "AddBuffToEntity",
        args = {buffID = 10430201, name = "e1"}
      },
      [6] = {
        action = "AddBuffToEntity",
        args = {buffID = 10430202, name = "e1"}
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 505.0,
            [5] = 506.0,
            [6] = 507.0,
            [7] = 508.0,
            [8] = 509.0,
            [9] = 409.0,
            [10] = 408.0,
            [11] = 407.0,
            [12] = 406.0,
            [13] = 405.0,
            [14] = 404.0,
            [15] = 403.0,
            [16] = 402.0
          },
          pieceType = 1
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [9] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 8,
          layerType = 3001,
          name = "e1",
          trigger = 0
        }
      },
      [10] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 402.0,
            [2] = 303.0,
            [3] = 202.0,
            [4] = 301.0
          },
          pieceType = 1
        }
      },
      [11] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 4,
          layerType = 3001,
          name = "e1",
          trigger = 0
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [13] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 30019,
          exist = false,
          name = "e1",
          trigger = 88
        }
      },
      [14] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "进入极光时刻后立即获得8层次数护盾，极光时刻结束后消失"
    }
  },
  name = "暗盾Ⅱ",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 2,
      id = 1400571,
      level = 30,
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
