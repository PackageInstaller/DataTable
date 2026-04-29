AutoTest_220928_142646 = {
  cases = {
    [1] = {
      [1] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 5100111,
          name = "e1",
          pos = 507
        }
      },
      [2] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 507,
          trapIds = {
            [1] = 1.501681E7
          },
          trigger = 88
        }
      },
      [3] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 505.0,
            [5] = 506.0,
            [6] = 405.0,
            [7] = 304.0
          },
          pieceType = 1
        }
      },
      [4] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "光灵连线经过印记格子时获得护盾，等于红霞防御力XX%"
    },
    [2] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "e1"}
      },
      [3] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 4001681,
          exist = true,
          name = "p1",
          trigger = 88
        }
      },
      [4] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 304.0,
            [2] = 305.0,
            [3] = 306.0,
            [4] = 307.0,
            [5] = 407.0,
            [6] = 507.0,
            [7] = 607.0,
            [8] = 606.0
          },
          pieceType = 1
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新测试用例"
    }
  },
  name = "虹霞觉醒1",
  petList = {
    [1] = {
      awakening = 1,
      equiplv = 1,
      grade = 1,
      id = 1501681,
      level = 40,
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
