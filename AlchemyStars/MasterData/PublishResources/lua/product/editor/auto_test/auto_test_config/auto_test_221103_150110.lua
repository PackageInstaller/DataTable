AutoTest_221103_150110 = {
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
          disableai = false,
          id = 5100111,
          name = "e1",
          pos = 506
        }
      },
      [4] = {
        action = "AddBuffToEntity",
        args = {buffID = 88840025, name = "team"}
      },
      [5] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Mobility",
          expect = 3.0,
          name = "e1",
          trigger = 88
        }
      },
      [6] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "AttackPercentage",
          expect = 0.050000000745058,
          name = "e1",
          trigger = 88
        }
      },
      [7] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [9] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Mobility",
          expect = 3.0,
          name = "e1",
          trigger = 88
        }
      },
      [10] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "AttackPercentage",
          expect = 0.10000000149012,
          name = "e1",
          trigger = 88
        }
      },
      [11] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 402.0,
            [3] = 302.0,
            [4] = 202.0,
            [5] = 103.0
          },
          pieceType = 1
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "怪物提高1点行动力并且每回合攻击力+5%"
    }
  },
  name = "40025迅捷猎杀",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1601431,
      level = 50,
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
