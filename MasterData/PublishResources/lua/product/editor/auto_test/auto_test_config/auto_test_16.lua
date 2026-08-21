AutoTest_16 = {
  cases = {
    [1] = {
      [1] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 502}
      },
      [2] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 4,
          layerType = 40059,
          name = "p1",
          trigger = 29
        }
      },
      [3] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 0,
          layerType = 40059,
          name = "p1",
          trigger = 30
        }
      },
      [4] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 503.0
          }
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "初始每有一名火属性光灵就获得1层印记，最大不超过5"
    }
  },
  name = "匹皮被动强化",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 10,
      grade = 2,
      id = 1300591,
      level = 1,
      name = "p1"
    },
    [2] = {
      affinity = 0,
      awakening = 0,
      equiplv = 0,
      grade = 0,
      id = 1600271,
      level = 1,
      name = "p2"
    },
    [3] = {
      affinity = 0,
      awakening = 0,
      equiplv = 0,
      grade = 0,
      id = 1600251,
      level = 1,
      name = "p3"
    },
    [4] = {
      affinity = 0,
      awakening = 0,
      equiplv = 0,
      grade = 0,
      id = 1601031,
      level = 1,
      name = "p4"
    }
  },
  setup = {
    [1] = {
      args = {levelID = 1, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
