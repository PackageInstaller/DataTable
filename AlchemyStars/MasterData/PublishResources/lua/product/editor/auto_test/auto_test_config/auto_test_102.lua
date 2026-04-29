AutoTest_102 = {
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
          pos = 409
        }
      },
      [4] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 28
        }
      },
      [5] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 402.0,
            [3] = 302.0,
            [4] = 303.0,
            [5] = 403.0,
            [6] = 404.0,
            [7] = 504.0,
            [8] = 505.0,
            [9] = 506.0,
            [10] = 606.0,
            [11] = 605.0,
            [12] = 604.0,
            [13] = 603.0,
            [14] = 503.0
          },
          pieceType = 1
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "3阶段连锁：连线13格，对纵向5排造成伤害"
    }
  },
  name = "雷吉娜连锁技3触发需求-1",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 2,
      equiplv = 1,
      grade = 3,
      id = 1500181,
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
