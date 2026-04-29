AutoTest_221109_140650 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetEntityHPPercent",
        args = {name = "team", percent = 0.5}
      },
      [3] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "<",
          name = "team",
          trigger = 88
        }
      },
      [4] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 502}
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 505
        }
      },
      [6] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 601.0,
            [4] = 501.0,
            [5] = 401.0,
            [6] = 402.0,
            [7] = 403.0,
            [8] = 503.0,
            [9] = 504.0
          },
          pieceType = 1
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "为队伍恢复相当于阿克西娅160%攻击力的血量。"
    }
  },
  name = "阿克西娅连锁技Ⅱ",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1601751,
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
