AutoTest_282 = {
  cases = {
    [1] = {
      [1] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 505
        }
      },
      [2] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 28
        }
      },
      [3] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 1,
          layerType = 2002,
          name = "e1",
          trigger = 28
        }
      },
      [4] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0
          },
          pieceType = 1
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "1.十字形8格(2)、十字形最大（9） 2.附加1层中毒 3.持续2回合"
    }
  },
  name = "尤拉连锁技",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1500211,
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
