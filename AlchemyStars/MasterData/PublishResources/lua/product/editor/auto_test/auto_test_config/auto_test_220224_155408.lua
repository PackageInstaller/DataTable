AutoTest_220224_155408 = {
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
        action = "SetPieceType",
        args = {pieceType = 4}
      },
      [4] = {
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 5,
          disableai = true,
          id = 2020311,
          name = "e2",
          pos = 705
        }
      },
      [6] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 1,
          pos = 705,
          trigger = 88
        }
      },
      [7] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 4,
          pos = 706,
          trigger = 88
        }
      },
      [8] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 1,
          pos = 805,
          trigger = 88
        }
      },
      [9] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 806,
          trigger = 88
        }
      },
      [10] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 705.0
          }
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "突4：主动技强化：至多三个格子转为水属性"
    }
  },
  name = "法夫纳突4",
  petList = {
    [1] = {
      awakening = 4,
      equiplv = 1,
      grade = 3,
      id = 1401371,
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
