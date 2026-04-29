AutoTest_116 = {
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
        action = "SetTeamPowerFull",
        args = {}
      },
      [4] = {
        action = "SetPieceType",
        args = {pieceType = 2}
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 605
        }
      },
      [6] = {
        action = "FakeCastSkill",
        args = {
          name = "p2",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "CheckDoubleChain",
        args = {name = "p2", trigger = 89}
      },
      [9] = {
        action = "CheckDoubleChain",
        args = {name = "p3", trigger = 89}
      },
      [10] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 402.0,
            [3] = 403.0,
            [4] = 404.0,
            [5] = 504.0
          },
          pieceType = 2
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "使用后本回合火系光灵的连锁技会释放2次，第2次释放时所有火系光灵攻击力为伊斯塔万攻击力的70%。"
    }
  },
  name = "伊斯塔万主动技二次连锁",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600271,
      level = 1,
      name = "p1"
    },
    [2] = {
      affinity = 0,
      awakening = 0,
      equiplv = 0,
      grade = 0,
      id = 1500841,
      level = 1,
      name = "p2"
    },
    [3] = {
      affinity = 0,
      awakening = 0,
      equiplv = 0,
      grade = 0,
      id = 1500901,
      level = 1,
      name = "p3"
    }
  },
  setup = {
    [1] = {
      args = {levelID = 1, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
