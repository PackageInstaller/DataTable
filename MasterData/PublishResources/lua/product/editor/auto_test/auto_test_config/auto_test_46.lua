AutoTest_46 = {
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
          pos = 504
        }
      },
      [4] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 10021,
          exist = true,
          name = "e1",
          trigger = 28
        }
      },
      [5] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 603.0,
            [4] = 604.0,
            [5] = 605.0,
            [6] = 505.0,
            [7] = 405.0,
            [8] = 404.0
          },
          pieceType = 1
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 404.0
          },
          pieceType = 0
        }
      },
      [8] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 10021,
          exist = false,
          name = "e1",
          trigger = 88
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "恐惧buff"
    }
  },
  name = "克莱肯被动技：恐惧",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 1,
      id = 1500761,
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
