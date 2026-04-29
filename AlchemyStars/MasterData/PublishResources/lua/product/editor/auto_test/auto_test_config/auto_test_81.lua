AutoTest_81 = {
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
        action = "SetOnePieceType",
        args = {pieceType = 3, pos = 206}
      },
      [5] = {
        action = "SetOnePieceType",
        args = {pieceType = 4, pos = 708}
      },
      [6] = {
        action = "CheckPieceType",
        args = {
          pieceType = 3,
          pos = 708,
          trigger = 30
        }
      },
      [7] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 708,
          trapId = 14,
          trapIds = {
            [1] = 14.0
          },
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
          }
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "主动技强化：交换后，若这两个格子有森属性，变为强化森格子"
    }
  },
  name = "奥斐娜主动技强化",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
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
