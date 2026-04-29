AutoTest_295 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [3] = {
        action = "SetPieceType",
        args = {pieceType = 2}
      },
      [4] = {
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 505,
          trigger = 30
        }
      },
      [5] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 503,
          trigger = 30
        }
      },
      [6] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 402,
          trigger = 30
        }
      },
      [7] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 602,
          trigger = 30
        }
      },
      [8] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 505.0
          },
          skillIndex = 0
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新增测试用例1"
    }
  },
  name = "Miss.白兰主动技",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 0,
      id = 1400411,
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
