AutoTest_82 = {
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
        action = "SetOnePieceType",
        args = {pieceType = 2, pos = 206}
      },
      [4] = {
        action = "SetOnePieceType",
        args = {pieceType = 4, pos = 708}
      },
      [5] = {
        action = "CheckPieceType",
        args = {
          pieceType = 4,
          pos = 206,
          trigger = 30
        }
      },
      [6] = {
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 708,
          trigger = 30
        }
      },
      [7] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 206.0,
            [2] = 708.0
          }
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新增测试用例1"
    }
  },
  name = "奥斐娜先制攻击",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 3,
      equiplv = 1,
      grade = 2,
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
