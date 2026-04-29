AutoTest_327 = {
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
          pos = 603
        }
      },
      [4] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 0,
          layerType = 3029,
          name = "p1",
          trigger = 88
        }
      },
      [5] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0
          },
          pieceType = 1
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "1.普攻增加1层龙牙印记 2.最多4层"
    },
    [2] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 503.0,
            [2] = 604.0,
            [3] = 703.0
          },
          pieceType = 1
        }
      },
      [3] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 4,
          layerType = 3029,
          name = "e1",
          trigger = 88
        }
      },
      [4] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新增测试用例1"
    }
  },
  name = "希罗娜普攻",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 1,
      id = 1600111,
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
