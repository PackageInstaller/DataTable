AutoTest_220127_142705 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "CheckBuffLogic",
        args = {
          exist = false,
          logic = "ATBuffBenumb",
          logic_select_index = 18,
          name = "team",
          trigger = 88
        }
      },
      [3] = {
        action = "CheckBuffLogic",
        args = {
          exist = true,
          logic = "ATBuffBenumb",
          logic_select_index = 18,
          name = "enemy",
          trigger = 88
        }
      },
      [4] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 402.0,
            [3] = 302.0,
            [4] = 303.0,
            [5] = 403.0,
            [6] = 503.0
          },
          pieceType = 1
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [6] = {
        action = "BlackFistFakeChainPath",
        args = {
          chainPath = {
            [1] = 505.0,
            [2] = 506.0,
            [3] = 507.0,
            [4] = 508.0
          },
          pieceType = 1
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "贡露"
    }
  },
  name = "黑拳赛-麻痹加到自己身上了（不对敌方）",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1600381,
      level = 1,
      name = "p1"
    }
  },
  remotePet = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 2,
      id = 1600381,
      level = 1,
      name = "r1"
    }
  },
  setup = {
    [1] = {
      args = {levelID = 1, matchType = 12},
      setup = "LevelBasic"
    }
  }
}
