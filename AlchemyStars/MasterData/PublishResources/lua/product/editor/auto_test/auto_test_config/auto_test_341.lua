AutoTest_341 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 605
        }
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 705
        }
      },
      [4] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [5] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e2",
          trigger = 88
        }
      },
      [6] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 702.0,
            [4] = 802.0,
            [5] = 803.0,
            [6] = 703.0,
            [7] = 603.0,
            [8] = 503.0,
            [9] = 504.0,
            [10] = 505.0
          },
          pieceType = 1
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "1.周围1圈（2）、米字形16格（9）、周围2圈（12）"
    }
  },
  name = "卡戎连锁技",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600251,
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
