AutoTest_330 = {
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
          pos = 301,
          trigger = 30
        }
      },
      [5] = {
        action = "CheckPieceType",
        args = {
          pieceType = 4,
          pos = 302,
          trigger = 30
        }
      },
      [6] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 303,
          trigger = 30
        }
      },
      [7] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 301,
          trapIds = {
            [1] = 62.0
          },
          trigger = 30
        }
      },
      [8] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 302,
          trapIds = {
            [1] = 62.0
          },
          trigger = 30
        }
      },
      [9] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 301.0,
            [2] = 302.0
          },
          skillIndex = 0
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "1.全屏任选2个格子转雷的棱镜格子"
    }
  },
  name = "伊伦汀主动技",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 0,
      id = 1600891,
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
