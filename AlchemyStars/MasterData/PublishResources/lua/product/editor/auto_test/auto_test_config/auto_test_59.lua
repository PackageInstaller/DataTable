AutoTest_59 = {
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
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 507
        }
      },
      [5] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 28
        }
      },
      [6] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e2",
          trigger = 28
        }
      },
      [7] = {
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 104,
          trigger = 88
        }
      },
      [8] = {
        action = "CheckEntityPos",
        args = {
          name = "e2",
          pos = 507,
          trigger = 88
        }
      },
      [9] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0
          },
          pieceType = 1
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "连锁技1：连线2格，十字形8格造成伤害并击退"
    }
  },
  name = "锯里克连锁技1",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1300221,
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
