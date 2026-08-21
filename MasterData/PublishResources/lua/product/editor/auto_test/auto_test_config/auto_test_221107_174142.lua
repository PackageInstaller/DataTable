AutoTest_221107_174142 = {
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
          id = 2010913,
          name = "e1",
          pos = 504
        }
      },
      [4] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 0,
          layerType = 400176,
          name = "e1",
          trigger = 102
        }
      },
      [5] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 403.0,
            [4] = 404.0
          },
          pieceType = 1
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 1,
          layerType = 400176,
          name = "e1",
          trigger = 102
        }
      },
      [8] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 404.0,
            [2] = 405.0,
            [3] = 406.0,
            [4] = 407.0,
            [5] = 507.0,
            [6] = 607.0,
            [7] = 707.0,
            [8] = 806.0,
            [9] = 805.0,
            [10] = 804.0,
            [11] = 803.0,
            [12] = 802.0,
            [13] = 701.0,
            [14] = 601.0,
            [15] = 501.0,
            [16] = 401.0,
            [17] = 301.0,
            [18] = 202.0,
            [19] = 103.0
          },
          pieceType = 1
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "每8次普攻插一根矛，目标身上的矛最大不超过5"
    }
  },
  name = "贝尔塔觉醒Ⅰ",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 1,
      id = 1501761,
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
