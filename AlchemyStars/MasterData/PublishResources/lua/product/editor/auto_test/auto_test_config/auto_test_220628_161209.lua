AutoTest_220628_161209 = {
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
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 401.0
          }
        }
      },
      [4] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [5] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 505.0,
            [5] = 506.0,
            [6] = 507.0,
            [7] = 508.0,
            [8] = 509.0
          },
          pieceType = 1
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Power",
          expect = 1.0,
          name = "p1",
          trigger = 0
        }
      },
      [8] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 4,
          pos = 401,
          trigger = 88
        }
      },
      [9] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 401.0
          }
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "主动技新增切换效果：1能量，将已有的一个机关脚下格子转色"
    }
  },
  name = "罗伊觉醒3",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1501491,
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
