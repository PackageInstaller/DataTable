AutoTest_240328_132407 = {
  cases = {
    [1] = {
      [1] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 305
        }
      },
      [2] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [3] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [4] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [5] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 507.0
          },
          skillIndex = 1
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0
          },
          pieceType = 1
        }
      },
      [8] = {
        action = "CaptureDamageValue",
        args = {
          key = "v1",
          name = "e1",
          trigger = 18
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "WaitGameOver",
        args = {}
      },
      name = "指定一个格子作为下次施放的连锁技目标位置，本回合下次连锁技释放条件-3。"
    }
  },
  name = "罗松主动技",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 0,
      id = 1502241,
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
