AutoTest_10 = {
  cases = {
    [1] = {
      [1] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 805
        }
      },
      [2] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 606
        }
      },
      [3] = {
        action = "SetTeamPowerFull",
        args = {}
      },
      [4] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 704.0
          }
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [6] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [7] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e2",
          trigger = 88
        }
      },
      [8] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 505.0,
            [5] = 506.0
          },
          pieceType = 1
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "妹妹释放连锁技"
    }
  },
  name = "红与黑代理连锁技",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1500241,
      level = 10,
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
