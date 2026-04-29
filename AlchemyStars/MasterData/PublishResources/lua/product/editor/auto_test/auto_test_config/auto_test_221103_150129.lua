AutoTest_221103_150129 = {
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
          name = "e2",
          pos = 307
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 5100111,
          name = "e3",
          pos = 305
        }
      },
      [6] = {
        action = "AddBuffToEntity",
        args = {buffID = 88840024, name = "e3"}
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 403.0,
            [3] = 404.0,
            [4] = 504.0,
            [5] = 603.0
          },
          pieceType = 1
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [9] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "DefencePercentage",
          expect = -0.10000000149012,
          name = "team",
          trigger = 0
        }
      },
      [10] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 603.0,
            [2] = 604.0,
            [3] = 605.0,
            [4] = 506.0,
            [5] = 407.0,
            [6] = 308.0,
            [7] = 207.0,
            [8] = 306.0
          },
          pieceType = 1
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [12] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "DefencePercentage",
          expect = -0.20000000298023,
          name = "team",
          trigger = 0
        }
      },
      [13] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "怪物死亡后降低玩家10%防御力，可叠加，效果持续整场战斗。"
    }
  },
  name = "40024死亡羸弱",
  petList = {
    [1] = {
      awakening = 6,
      equiplv = 1,
      grade = 3,
      id = 1601481,
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
