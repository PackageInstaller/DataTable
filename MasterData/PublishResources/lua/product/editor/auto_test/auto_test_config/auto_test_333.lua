AutoTest_333 = {
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
          id = 5100111,
          name = "e1",
          pos = 507
        }
      },
      [4] = {
        action = "SetPieceType",
        args = {pieceType = 2}
      },
      [5] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 502,
          trapIds = {
            [1] = 62.0
          },
          trigger = 88
        }
      },
      [6] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 702.0,
            [4] = 802.0,
            [5] = 803.0,
            [6] = 703.0,
            [7] = 603.0,
            [8] = 503.0,
            [9] = 403.0,
            [10] = 303.0,
            [11] = 203.0,
            [12] = 103.0,
            [13] = 104.0,
            [14] = 204.0,
            [15] = 304.0,
            [16] = 404.0
          },
          pieceType = 2
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
      name = "1.若触发极光时刻，将出发点的格子变成棱镜格子（不改变其属性）"
    }
  },
  name = "伊伦汀连锁技3",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1600891,
      level = 1,
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
