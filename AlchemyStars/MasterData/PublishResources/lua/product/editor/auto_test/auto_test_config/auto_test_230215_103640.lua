AutoTest_230215_103640 = {
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
          pos = 705
        }
      },
      [4] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 704.0
          },
          skillIndex = 1
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [6] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 704.0,
            [2] = 703.0,
            [3] = 603.0,
            [4] = 503.0,
            [5] = 403.0,
            [6] = 303.0,
            [7] = 203.0,
            [8] = 103.0,
            [9] = 104.0,
            [10] = 204.0,
            [11] = 304.0,
            [12] = 305.0,
            [13] = 306.0,
            [14] = 406.0,
            [15] = 407.0,
            [16] = 508.0,
            [17] = 509.0
          },
          pieceType = 1
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 14,
          name = "e2",
          pos = 608
        }
      },
      [9] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 608.0,
            [2] = 607.0
          },
          skillIndex = 2
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [11] = {
        action = "CheckEntityPos",
        args = {
          name = "p1",
          pos = 608,
          trigger = 0
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新主动：极光时刻内可用：0cd，周围一圈位移一格"
    }
  },
  name = "耶利亚突破Ⅵ",
  petList = {
    [1] = {
      awakening = 6,
      equiplv = 1,
      grade = 3,
      id = 1601841,
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
