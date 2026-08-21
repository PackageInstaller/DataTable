AutoTest_374 = {
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
          pos = 503
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 408
        }
      },
      [5] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "LegendPower",
          attr_select_index = 4,
          expect = 1.0,
          name = "p1",
          trigger = 88
        }
      },
      [6] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 402.0,
            [3] = 302.0,
            [4] = 202.0
          },
          pieceType = 1
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "LegendPower",
          attr_select_index = 4,
          expect = 3.0,
          name = "p1",
          trigger = 88
        }
      },
      [9] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 202.0,
            [2] = 103.0,
            [3] = 104.0,
            [4] = 204.0,
            [5] = 304.0,
            [6] = 404.0,
            [7] = 504.0,
            [8] = 604.0
          },
          pieceType = 1
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [11] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "LegendPower",
          attr_select_index = 4,
          expect = 6.0,
          name = "p1",
          trigger = 88
        }
      },
      [12] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 604.0,
            [2] = 704.0,
            [3] = 804.0,
            [4] = 904.0,
            [5] = 905.0,
            [6] = 805.0,
            [7] = 705.0,
            [8] = 605.0,
            [9] = 505.0,
            [10] = 405.0,
            [11] = 406.0
          },
          pieceType = 1
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "1.对最近1个敌人，获得1点威能（3） 2.对最近1个敌人，获得2点威能（7） 3.对最近1个敌人，获得3点威能（10）"
    }
  },
  name = "童谣座连锁技",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1701091,
      level = 11,
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
