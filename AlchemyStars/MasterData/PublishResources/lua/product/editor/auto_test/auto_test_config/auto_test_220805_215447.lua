AutoTest_220805_215447 = {
  cases = {
    [1] = {
      [1] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 101311,
          name = "e1",
          pos = 604
        }
      },
      [2] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 101314,
          name = "e2",
          pos = 704
        }
      },
      [3] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 1,
          layerType = 4001580,
          name = "e1",
          trigger = 88
        }
      },
      [4] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 2,
          layerType = 4001580,
          name = "e2",
          trigger = 88
        }
      },
      [5] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 603.0,
            [3] = 703.0,
            [4] = 803.0
          },
          pieceType = 1
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "普攻叠加1层印记，对雷属性敌人改为2层"
    }
  },
  name = "mona觉醒3",
  petList = {
    [1] = {
      awakening = 1,
      equiplv = 1,
      grade = 3,
      id = 1501621,
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
