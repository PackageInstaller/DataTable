AutoTest_221025_131824 = {
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
        action = "SetEntityHP",
        args = {hp = 999999, name = "team"}
      },
      [4] = {
        action = "SetEntityAttack",
        args = {attack = 999999, name = "p1"}
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 406
        }
      },
      [6] = {
        action = "AddBuffToEntity",
        args = {buffID = 10520101, name = "e1"}
      },
      [7] = {
        action = "CheckTrapExist",
        args = {
          exist = true,
          trapIds = {
            [1] = 2001.0
          },
          trigger = 102
        },
        exist = true
      },
      [8] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 5,
          pos = 406,
          trigger = 88
        }
      },
      [9] = {
        action = "CheckPieceType",
        args = {
          pieceType = 5,
          pos = 406,
          trigger = 88
        }
      },
      [10] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 505.0,
            [5] = 506.0
          },
          pieceType = 1
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "死亡后，在原地随机一格上生成一个治疗箱，同时转为万色格子"
    }
  },
  name = "身怀至宝",
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
