AutoTest_64 = {
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
        action = "CheckPieceType",
        args = {
          pieceType = 4,
          pos = 709,
          trigger = 30
        }
      },
      [5] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 709,
          trapId = 14,
          trapIds = {
            [1] = 14.0
          },
          trigger = 30
        }
      },
      [6] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 709.0
          }
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "主动技转化雷属性格子为强化格子"
    }
  },
  name = "尤尼梅特主动技生成强化格子",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
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
