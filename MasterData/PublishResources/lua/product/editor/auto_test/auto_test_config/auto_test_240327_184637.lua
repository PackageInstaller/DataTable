AutoTest_240327_184637 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetEntityPosition",
        args = {name = "p1", pos = 502}
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 504
        }
      },
      [4] = {
        action = "SetAllMonstersHP",
        args = {value = 999999}
      },
      [5] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 200221,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [6] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 2,
          layerType = 20022,
          name = "e1",
          trigger = 88
        }
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 401.0,
            [3] = 402.0,
            [4] = 403.0,
            [5] = 304.0
          },
          pieceType = 1
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "连锁多挂一层毒"
    }
  },
  name = "丽蓓卡精炼2",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 2,
      equiplv = 10,
      grade = 3,
      id = 1602141,
      level = 200,
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
