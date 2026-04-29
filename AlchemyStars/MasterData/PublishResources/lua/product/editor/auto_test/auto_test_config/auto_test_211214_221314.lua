AutoTest_211214_221314 = {
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
          pos = 809
        }
      },
      [4] = {
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [5] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 402.0
          }
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Ready",
          attr_select_index = 9,
          expect = 1,
          name = "p1",
          trigger = 88
        }
      },
      [8] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 402.0,
            [2] = 302.0,
            [3] = 202.0,
            [4] = 103.0,
            [5] = 104.0,
            [6] = 105.0,
            [7] = 106.0,
            [8] = 107.0,
            [9] = 207.0,
            [10] = 307.0,
            [11] = 407.0,
            [12] = 507.0,
            [13] = 607.0,
            [14] = 707.0,
            [15] = 807.0,
            [16] = 808.0
          },
          pieceType = 1
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "CheckEntityPos",
        args = {
          name = "p1",
          pos = 305,
          trigger = 88
        }
      },
      [11] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 305.0
          }
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "主动技强化：极光时刻时，有额外一次施放机会"
    }
  },
  name = "塔塔觉醒3",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1300651,
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
