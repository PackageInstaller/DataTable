AutoTest_221021_191234 = {
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
        action = "AddBuffToEntity",
        args = {buffID = 10300502, name = "e1"}
      },
      [5] = {
        action = "AddBuffToEntity",
        args = {buffID = 30131, name = "e1"}
      },
      [6] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 10300502,
          exist = true,
          name = "e1",
          trigger = 0
        }
      },
      [7] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 30131,
          exist = true,
          name = "e1",
          trigger = 0
        }
      },
      [8] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 402.0,
            [3] = 403.0,
            [4] = 404.0,
            [5] = 504.0,
            [6] = 604.0,
            [7] = 603.0,
            [8] = 602.0
          },
          pieceType = 1
        }
      },
      [9] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e1",
          trigger = 88
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新测试用例"
    }
  },
  name = "103005 硬皮V",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600061,
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
