AutoTest_221103_145846 = {
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
          disableai = false,
          id = 5100111,
          name = "e2",
          pos = 504
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 703
        }
      },
      [6] = {
        action = "AddBuffToEntity",
        args = {buffID = 88841002, name = "e2"}
      },
      [7] = {
        action = "AddBuffToEntity",
        args = {buffID = 88842002, name = "e2"}
      },
      [8] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 603.0
          },
          pieceType = 1
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "AttackPercentage",
          expect = 0.10000000149012,
          name = "e2",
          trigger = 102
        }
      },
      [11] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "DefencePercentage",
          expect = 0.10000000149012,
          name = "e2",
          trigger = 102
        }
      },
      [12] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [14] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "AttackPercentage",
          expect = 0.20000000298023,
          name = "e2",
          trigger = 0
        }
      },
      [15] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "DefencePercentage",
          expect = 0.20000000298023,
          name = "e2",
          trigger = 0
        }
      },
      name = "当场上有怪死亡、增加其他怪的攻和防10%，可叠加"
    }
  },
  name = "40002复仇遗愿",
  petList = {
    [1] = {
      awakening = 6,
      equiplv = 10,
      grade = 3,
      id = 1601481,
      level = 80,
      name = "p1"
    }
  },
  remotePet = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1400071,
      level = 1,
      name = "r1"
    }
  },
  setup = {
    [1] = {
      args = {levelID = 1, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
