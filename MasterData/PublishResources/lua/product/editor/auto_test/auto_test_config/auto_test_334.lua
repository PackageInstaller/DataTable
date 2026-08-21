AutoTest_334 = {
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
          pos = 301,
          trigger = 30
        }
      },
      [4] = {
        action = "CheckPieceType",
        args = {
          pieceType = 4,
          pos = 302,
          trigger = 30
        }
      },
      [5] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 301,
          trapIds = {
            [1] = 14.0
          },
          trigger = 30
        }
      },
      [6] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 302,
          trapIds = {
            [1] = 14.0
          },
          trigger = 30
        }
      },
      [7] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 301.0,
            [2] = 302.0
          }
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "1.先制攻击 2.格子同时变为强化格子"
    }
  },
  name = "伊伦汀主动技-先制攻击",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 6,
      equiplv = 1,
      grade = 3,
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
