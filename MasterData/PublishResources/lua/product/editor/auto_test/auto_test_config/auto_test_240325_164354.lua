AutoTest_240325_164354 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetEntityPosition",
        args = {name = "p1", pos = 502}
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 305
        }
      },
      [4] = {
        action = "SetAllMonstersHP",
        args = {value = 999999}
      },
      [5] = {
        action = "SetEntityHPPercent",
        args = {name = "team", percent = 0.5}
      },
      [6] = {
        action = "CheckAttributeChange",
        args = {
          attr = "HP",
          cmp = "<",
          name = "team",
          trigger = 88
        }
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 402.0,
            [3] = 302.0,
            [4] = 202.0,
            [5] = 103.0,
            [6] = 203.0,
            [7] = 303.0,
            [8] = 403.0,
            [9] = 503.0,
            [10] = 603.0,
            [11] = 703.0,
            [12] = 803.0,
            [13] = 903.0,
            [14] = 904.0,
            [15] = 804.0,
            [16] = 704.0
          },
          pieceType = 1
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "进入极光时刻时回复100%攻击力的血量"
    }
  },
  name = "查莉娅觉2",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 2,
      id = 1602111,
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
