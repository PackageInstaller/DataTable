AutoTest_210914_110111 = {
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
        action = "CheckEntityBuff",
        args = {
          buffId = 410113,
          exist = true,
          name = "p1",
          trigger = 0
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 5100111,
          name = "e1",
          pos = 504
        }
      },
      [5] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 410113,
          exist = false,
          name = "p1",
          trigger = 88
        }
      },
      [6] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0
          },
          pieceType = 0
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新测试用例"
    }
  },
  name = "27273-波娜瑟印记消失",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 5,
      equiplv = 10,
      grade = 3,
      id = 1501131,
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
