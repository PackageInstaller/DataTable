AutoTest_57 = {
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
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 709,
          trigger = 30
        }
      },
      [4] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 709.0
          }
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新增测试用例1"
    }
  },
  name = "小不点主动技先制攻击",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 3,
      equiplv = 1,
      grade = 2,
      id = 1400081,
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
