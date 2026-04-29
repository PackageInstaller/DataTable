AutoTest_221209_152413 = {
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
          id = 5100111,
          name = "e1",
          pos = 607
        }
      },
      [4] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 14,
          name = "g1",
          pos = 702
        }
      },
      [5] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 14,
          name = "g2",
          pos = 602
        }
      },
      [6] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 14,
          name = "g3",
          pos = 802
        }
      },
      [7] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 14,
          name = "g4",
          pos = 701
        }
      },
      [8] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 14,
          name = "g5",
          pos = 601
        }
      },
      [9] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 14,
          name = "g6",
          pos = 501
        }
      },
      [10] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 14,
          name = "g7",
          pos = 402
        }
      },
      [11] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 14,
          name = "g8",
          pos = 403
        }
      },
      [12] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 702.0,
            [4] = 802.0,
            [5] = 701.0,
            [6] = 601.0,
            [7] = 501.0,
            [8] = 402.0,
            [9] = 403.0
          },
          pieceType = 1
        }
      },
      [13] = {
        action = "CheckTrapExist",
        args = {
          exist = true,
          trapIds = {
            [1] = 14.0
          },
          trigger = 0
        },
        exist = true
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "每吸收8个强化格子，将周围最近的一个非森格子转为强化格"
    }
  },
  name = "歌尔蒂觉醒Ⅰ",
  petList = {
    [1] = {
      awakening = 2,
      equiplv = 2,
      grade = 1,
      id = 1601771,
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
