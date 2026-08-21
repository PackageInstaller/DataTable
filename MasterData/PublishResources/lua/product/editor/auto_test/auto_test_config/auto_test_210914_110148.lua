AutoTest_210914_110148 = {
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
          disableai = false,
          id = 2101014,
          name = "e1",
          pos = 503
        }
      },
      [3] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0
          },
          pieceType = 0
        }
      },
      [4] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [5] = {
        action = "SetPieceType",
        args = {pieceType = 2}
      },
      [6] = {
        action = "CheckBuffLogic",
        args = {
          exist = true,
          logic = "ATBuffSealed",
          logic_select_index = 15,
          name = "p4",
          trigger = 88
        }
      },
      [7] = {
        action = "CheckBuffLogic",
        args = {
          exist = false,
          logic = "ATBuffSealed",
          logic_select_index = 15,
          name = "p1",
          trigger = 88
        }
      },
      [8] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 402.0,
            [3] = 302.0,
            [4] = 202.0,
            [5] = 203.0
          },
          pieceType = 2
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新测试用例"
    }
  },
  name = "26395-维多利亚诅咒怪 第10章",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 6,
      equiplv = 1,
      grade = 3,
      id = 1600191,
      level = 1,
      name = "p1"
    },
    [2] = {
      affinity = 1,
      awakening = 6,
      equiplv = 1,
      grade = 3,
      id = 1600021,
      level = 1,
      name = "p2"
    },
    [3] = {
      affinity = 1,
      awakening = 6,
      equiplv = 1,
      grade = 3,
      id = 1600061,
      level = 1,
      name = "p3"
    },
    [4] = {
      affinity = 1,
      awakening = 6,
      equiplv = 1,
      grade = 3,
      id = 1600251,
      level = 1,
      name = "p4"
    },
    [5] = {
      affinity = 1,
      awakening = 6,
      equiplv = 1,
      grade = 3,
      id = 1600111,
      level = 1,
      name = "p5"
    }
  },
  setup = {
    [1] = {
      args = {levelID = 1, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
