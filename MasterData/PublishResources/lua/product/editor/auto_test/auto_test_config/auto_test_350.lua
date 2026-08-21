AutoTest_350 = {
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
          pos = 503
        }
      },
      [4] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 1,
          layerType = 4100271,
          name = "p1",
          trigger = 25
        }
      },
      [5] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 0,
          layerType = 4100271,
          name = "p1",
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
      name = "1.每回合开始获得1层静雷印记 2.普攻消耗1层印记造成伤害"
    }
  },
  name = "米迦勒普攻",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 1,
      id = 1600271,
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
