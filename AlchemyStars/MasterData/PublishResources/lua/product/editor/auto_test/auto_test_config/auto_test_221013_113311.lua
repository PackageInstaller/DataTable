AutoTest_221013_113311 = {
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
          pos = 304
        }
      },
      [4] = {
        action = "AddBuffToEntity",
        args = {buffID = 101201, name = "e1"}
      },
      [5] = {
        action = "AddBuffToEntity",
        args = {buffID = 101202, name = "e1"}
      },
      [6] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e1",
          trigger = 88
        }
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 403.0,
            [4] = 303.0,
            [5] = 203.0,
            [6] = 204.0,
            [7] = 205.0,
            [8] = 305.0,
            [9] = 405.0,
            [10] = 505.0,
            [11] = 605.0,
            [12] = 705.0,
            [13] = 805.0,
            [14] = 905.0,
            [15] = 904.0,
            [16] = 804.0
          },
          pieceType = 1
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [9] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 101201,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [10] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 101202,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [11] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "若进入极光时刻，敌人的血量恢复到回合开始状态"
    }
  },
  name = "1012极光回溯",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600061,
      level = 30,
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
