AutoTest_193 = {
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
          id = 2090313,
          name = "e1",
          pos = 103
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 408
        }
      },
      [5] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 501.0,
            [3] = 401.0,
            [4] = 301.0,
            [5] = 302.0,
            [6] = 202.0
          },
          pieceType = 1
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 202.0,
            [2] = 302.0,
            [3] = 402.0,
            [4] = 403.0,
            [5] = 303.0,
            [6] = 203.0
          },
          pieceType = 1
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [9] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 203.0,
            [2] = 204.0,
            [3] = 104.0,
            [4] = 105.0,
            [5] = 205.0,
            [6] = 305.0
          },
          pieceType = 1
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [11] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [12] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 305.0,
            [2] = 304.0,
            [3] = 303.0,
            [4] = 302.0,
            [5] = 202.0,
            [6] = 203.0
          },
          pieceType = 1
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [14] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 203.0,
            [2] = 204.0,
            [3] = 205.0,
            [4] = 206.0,
            [5] = 105.0,
            [6] = 104.0
          },
          pieceType = 1
        }
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [16] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [17] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 104.0,
            [2] = 105.0,
            [3] = 205.0,
            [4] = 204.0,
            [5] = 203.0,
            [6] = 202.0
          },
          pieceType = 1
        }
      },
      [18] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 5,
          layerType = 410098,
          name = "e1",
          trigger = 28
        }
      },
      [19] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 1,
          layerType = 410098,
          name = "e2",
          trigger = 28
        }
      },
      [20] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "连锁技命中敌人为其附加1层割裂印记，最大5层。每层印记使库斯库塔的伤害提高"
    }
  },
  name = "库斯库塔被动技",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 1,
      id = 1500981,
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
