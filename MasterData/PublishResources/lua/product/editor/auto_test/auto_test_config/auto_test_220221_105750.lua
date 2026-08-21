AutoTest_220221_105750 = {
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
        args = {name = "team", name_select_index = 0}
      },
      [4] = {
        action = "SetPieceType",
        args = {pieceType = 4}
      },
      [5] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 1,
          pos = 405,
          trigger = 88
        }
      },
      [6] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 1,
          pos = 606,
          trigger = 88
        }
      },
      [7] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 1,
          pos = 903,
          trigger = 88
        }
      },
      [8] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 207,
          trigger = 88
        }
      },
      [9] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 405.0,
            [2] = 606.0,
            [3] = 903.0,
            [4] = 207.0
          }
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "任选4个格子，转为水属性格子"
    }
  },
  name = "伯利恒主动技",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600771,
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
