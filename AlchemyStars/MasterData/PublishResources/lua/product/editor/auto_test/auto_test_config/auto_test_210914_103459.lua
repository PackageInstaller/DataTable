AutoTest_210914_103459 = {
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
          disableai = false,
          id = 2090613,
          name = "e1",
          pos = 207
        }
      },
      [4] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 702.0,
            [4] = 802.0,
            [5] = 803.0,
            [6] = 804.0,
            [7] = 805.0,
            [8] = 806.0,
            [9] = 807.0,
            [10] = 808.0,
            [11] = 708.0,
            [12] = 608.0,
            [13] = 508.0,
            [14] = 408.0,
            [15] = 308.0,
            [16] = 208.0
          },
          pieceType = 1
        }
      },
      [5] = {
        action = "CheckGridTrap",
        args = {
          pos = 502,
          trapIds = {
            [1] = 430089.0
          },
          trigger = 88
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "伊伦汀满觉醒触发极光时刻，出发点棱镜格子(属性无法检验）"
    }
  },
  name = "27353-伊伦汀装备技棱镜格子",
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
