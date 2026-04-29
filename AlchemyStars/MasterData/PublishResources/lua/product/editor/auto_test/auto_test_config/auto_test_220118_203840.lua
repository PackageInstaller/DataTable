AutoTest_220118_203840 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 605
        }
      },
      [3] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "e1"}
      },
      [4] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 505.0,
            [5] = 506.0,
            [6] = 606.0,
            [7] = 706.0,
            [8] = 705.0,
            [9] = 704.0,
            [10] = 604.0,
            [11] = 603.0,
            [12] = 602.0
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
  name = "库斯库塔普攻加印记",
  petList = {
    [1] = {
      awakening = 3,
      equiplv = 1,
      grade = 3,
      id = 1500981,
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
