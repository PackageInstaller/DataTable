AutoTest_309 = {
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
          id = 2090313,
          name = "e1",
          pos = 603
        }
      },
      [4] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 1,
          layerType = 4100302,
          name = "e1",
          trigger = 82
        }
      },
      [5] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 26
        }
      },
      [6] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0
          },
          pieceType = 0
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 2090313,
          name = "e2",
          pos = 303
        }
      },
      [9] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 4,
          layerType = 4100302,
          name = "e2",
          trigger = 18
        }
      },
      [10] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 402.0,
            [3] = 302.0,
            [4] = 202.0,
            [5] = 203.0,
            [6] = 204.0,
            [7] = 304.0,
            [8] = 404.0,
            [9] = 403.0
          },
          pieceType = 1
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "1.斜方向普通攻击 2.附加1层崩裂状态 3.崩裂状态最高5层"
    }
  },
  name = "醒山普攻",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 1,
      id = 1600301,
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
