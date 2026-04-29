AutoTest_145 = {
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
          name = "e2",
          pos = 208
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 707
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 207
        }
      },
      [6] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 403.0,
            [3] = 404.0,
            [4] = 304.0,
            [5] = 305.0,
            [6] = 306.0
          },
          pieceType = 1
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "CheckEntityHP",
        args = {
          compare = "==",
          hp = 0,
          name = "e1",
          trigger = 26
        }
      },
      [9] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 2,
          layerType = 40046,
          name = "e2",
          trigger = 88
        }
      },
      [10] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 2,
          layerType = 40046,
          name = "e3",
          trigger = 88
        }
      },
      [11] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 306.0,
            [2] = 206.0
          },
          pieceType = 1
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "若有有唱诗印记的敌人阵亡后，所有剩余敌人附加1层印记"
    }
  },
  name = "基汀被动强化",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 3,
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
