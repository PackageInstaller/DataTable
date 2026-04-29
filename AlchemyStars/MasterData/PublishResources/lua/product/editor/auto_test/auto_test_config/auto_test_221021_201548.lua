AutoTest_221021_201548 = {
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
        action = "SetEntityHP",
        args = {hp = 10000, name = "e1"}
      },
      [5] = {
        action = "AddBuffToEntity",
        args = {buffID = 10300102, name = "e1"}
      },
      [6] = {
        action = "AddBuffToEntity",
        args = {buffID = 30131, name = "e1"}
      },
      [7] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 10300102,
          exist = true,
          name = "e1",
          trigger = 0
        }
      },
      [8] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 30131,
          exist = true,
          name = "e1",
          trigger = 0
        }
      },
      [9] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 403.0,
            [3] = 504.0,
            [4] = 603.0,
            [5] = 602.0
          },
          pieceType = 1
        }
      },
      [10] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e1",
          trigger = 88
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新测试用例"
    }
  },
  name = "103001 硬皮I",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600061,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1500331,
      level = 1,
      name = "p1"
    },
    [3] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1400791,
      level = 1,
      name = "p1"
    },
    [4] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1400411,
      level = 1,
      name = "p1"
    },
    [5] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1500761,
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
