AutoTest_144 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPosition",
        args = {pos = 502}
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 705
        }
      },
      [4] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "e1"}
      },
      [5] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 501.0,
            [3] = 401.0,
            [4] = 402.0,
            [5] = 302.0,
            [6] = 302.0,
            [7] = 203.0,
            [8] = 204.0,
            [9] = 205.0,
            [10] = 306.0,
            [11] = 406.0,
            [12] = 506.0,
            [13] = 507.0,
            [14] = 508.0
          },
          pieceType = 1
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [8] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 508.0,
            [2] = 507.0,
            [3] = 506.0,
            [4] = 406.0,
            [5] = 306.0,
            [6] = 205.0,
            [7] = 204.0,
            [8] = 203.0,
            [9] = 303.0,
            [10] = 302.0,
            [11] = 402.0,
            [12] = 401.0,
            [13] = 501.0,
            [14] = 502.0
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
        action = "CheckEntityBuffLayer",
        args = {
          layer = 8,
          layerType = 40046,
          name = "e1",
          trigger = 88
        }
      },
      [12] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 501.0,
            [3] = 401.0,
            [4] = 402.0,
            [5] = 302.0,
            [6] = 302.0,
            [7] = 203.0,
            [8] = 204.0,
            [9] = 205.0,
            [10] = 306.0,
            [11] = 406.0,
            [12] = 506.0,
            [13] = 507.0,
            [14] = 508.0
          },
          pieceType = 1
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "印记最多叠加8层"
    }
  },
  name = "基汀印记最大层数",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1300461,
      level = 10,
      name = "p1"
    }
  },
  setup = {
    [1] = {
      args = {levelID = 1, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
