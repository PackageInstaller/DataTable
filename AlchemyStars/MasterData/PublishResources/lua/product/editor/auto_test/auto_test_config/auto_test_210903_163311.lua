AutoTest_210903_163311 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "AddMonster",
        args = {
          ai = 2000604,
          dir = 1,
          id = 2000604,
          name = "e1",
          pos = 505
        }
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 5100111,
          name = "e2",
          pos = 506
        }
      },
      [4] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0
          },
          pieceType = 1
        }
      },
      [5] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 1,
          layerType = 2000601,
          name = "e2",
          trigger = 88
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "附身怪附身后小怪头顶没有显示血条盾，血条buff里修改了加buff的目标，改成了施法者自己"
    }
  },
  name = "23220-附身怪加buff的目标",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1600191,
      level = 20,
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
