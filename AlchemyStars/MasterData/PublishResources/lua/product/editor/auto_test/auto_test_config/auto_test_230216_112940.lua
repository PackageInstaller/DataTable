AutoTest_230216_112940 = {
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
          id = 527303102,
          name = "e1",
          pos = 505
        }
      },
      [4] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [6] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 30024,
          exist = true,
          name = "e1",
          trigger = 0
        }
      },
      [7] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 2802102,
          name = "e2",
          pos = 504
        }
      },
      [8] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 702.0,
            [4] = 802.0,
            [5] = 903.0,
            [6] = 803.0,
            [7] = 904.0,
            [8] = 905.0,
            [9] = 804.0,
            [10] = 704.0,
            [11] = 604.0,
            [12] = 504.0,
            [13] = 403.0,
            [14] = 303.0,
            [15] = 203.0,
            [16] = 103.0
          },
          pieceType = 1
        }
      },
      [9] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 10011,
          exist = true,
          name = "e1",
          trigger = 0
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "踩到机关后，清除暗鬼本回合带的护盾次数，同时眩晕一回合"
    }
  },
  name = "卷轴机关Ⅰ",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1400071,
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
