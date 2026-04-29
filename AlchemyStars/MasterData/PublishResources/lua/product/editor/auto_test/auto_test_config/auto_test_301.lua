AutoTest_301 = {
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
          pos = 405
        }
      },
      [4] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 3,
          layerType = 420911,
          name = "p1",
          trigger = 88
        }
      },
      [5] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 505.0
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
        args = {pieceType = 2}
      },
      [8] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 0,
          layerType = 420911,
          name = "p1",
          trigger = 88
        }
      },
      [9] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 505.0,
            [2] = 506.0
          },
          pieceType = 2
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "1.每经过1个水格子累计1个印记 2.走其他属性 3.释放技能将清空印记"
    }
  },
  name = "克萝伊主动技1",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 2,
      id = 1400911,
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
