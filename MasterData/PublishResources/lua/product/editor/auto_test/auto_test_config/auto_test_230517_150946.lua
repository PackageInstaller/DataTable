AutoTest_230517_150946 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 2000521,
          name = "e1",
          pos = 505
        }
      },
      [3] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 502}
      },
      [4] = {
        action = "SetAllMonstersHP",
        args = {value = 1000000}
      },
      [5] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 604.0,
            [5] = 705.0,
            [6] = 706.0,
            [7] = 607.0,
            [8] = 507.0,
            [9] = 406.0,
            [10] = 405.0,
            [11] = 305.0
          },
          pieceType = 1
        }
      },
      [6] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 7,
          layerType = 3029,
          name = "e1",
          trigger = 0
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "觉3强化：最大7层"
    }
  },
  name = "希罗娜精炼Ⅰ",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 1,
      equiplv = 10,
      grade = 3,
      id = 1600111,
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
