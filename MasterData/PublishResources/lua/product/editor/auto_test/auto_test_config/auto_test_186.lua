AutoTest_186 = {
  cases = {
    [1] = {
      [1] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 502}
      },
      [2] = {
        action = "SetEntityHPPercent",
        args = {name = "team", percent = 0.5}
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 805
        }
      },
      [4] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 404.0,
            [5] = 405.0,
            [6] = 406.0,
            [7] = 407.0,
            [8] = 408.0,
            [9] = 409.0,
            [10] = 509.0,
            [11] = 508.0,
            [12] = 507.0,
            [13] = 607.0,
            [14] = 608.0,
            [15] = 708.0,
            [16] = 807.0,
            [17] = 806.0
          },
          pieceType = 1
        }
      },
      [5] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "<",
          name = "team",
          trigger = 88
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "触发极光时刻时，立刻为队伍恢复相当于露易丝{1}生命上限的血量。"
    }
  },
  name = "露易丝被动技",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 1,
      id = 1600101,
      level = 10,
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
