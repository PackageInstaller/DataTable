AutoTest_230201_145202 = {
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
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 527305204,
          name = "e1",
          pos = 303
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 527305204,
          name = "e2",
          pos = 509
        }
      },
      [5] = {
        action = "AddBuffToEntity",
        args = {buffID = 5259501, name = "p1"}
      },
      [6] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 702.0,
            [4] = 703.0,
            [5] = 603.0,
            [6] = 604.0,
            [7] = 605.0,
            [8] = 505.0,
            [9] = 506.0,
            [10] = 507.0,
            [11] = 508.0
          },
          pieceType = 1
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "月白和5259501圣遗物虚影bug"
    }
  },
  name = "月白和5259501圣遗物虚影bug",
  petList = {
    [1] = {
      awakening = 6,
      equiplv = 1,
      grade = 3,
      id = 1601821,
      level = 80,
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
