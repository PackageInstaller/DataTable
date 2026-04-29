AutoTest_80 = {
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
        args = {name = "team"}
      },
      [4] = {
        action = "SetOnePieceType",
        args = {pieceType = 2, pos = 206}
      },
      [5] = {
        action = "SetOnePieceType",
        args = {pieceType = 4, pos = 708}
      },
      [6] = {
        action = "CheckPieceType",
        args = {
          pieceType = 4,
          pos = 206,
          trigger = 30
        }
      },
      [7] = {
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 708,
          trigger = 30
        }
      },
      [8] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 206.0,
            [2] = 708.0
          },
          skillIndex = 0
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "任选2个格子，交换其格子的元素属性"
    }
  },
  name = "奥斐娜主动技",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 0,
      id = 1300821,
      level = 1,
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
