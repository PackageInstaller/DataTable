AutoTest_240328_152028 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetPieceType",
        args = {pieceType = 2}
      },
      [3] = {
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
      [4] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 4,
          layerType = 1001,
          name = "e1",
          trigger = 88
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "每经过1个火属性格子获得1层充能，最多叠加99层。每层充能增加连锁技XX%的最终伤害，释放后清空。。"
    }
  },
  name = "罗松觉醒1",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 0,
      grade = 1,
      id = 1602181,
      level = 40,
      name = "p1"
    }
  },
  remotePet = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1400071,
      level = 1,
      name = "r1"
    }
  },
  setup = {
    [1] = {
      args = {levelID = 1, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
