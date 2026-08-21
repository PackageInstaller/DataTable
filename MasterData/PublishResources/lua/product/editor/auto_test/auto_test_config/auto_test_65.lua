AutoTest_65 = {
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
          pieceType = 4,
          pos = 709,
          trigger = 30
        }
      },
      [4] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 709,
          trapId = 0,
          trapIds = {
            [1] = 800001.0,
            [2] = 800002.0,
            [3] = 800003.0,
            [4] = 800004.0,
            [5] = 800005.0
          },
          trigger = 30
        }
      },
      [5] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 709.0
          }
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新增测试用例1"
    }
  },
  name = "尤尼梅特先制攻击",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 3,
      equiplv = 1,
      grade = 2,
      id = 1300801,
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
