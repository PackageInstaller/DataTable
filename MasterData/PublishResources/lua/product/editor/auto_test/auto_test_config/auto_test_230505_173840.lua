AutoTest_230505_173840 = {
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
        action = "CheckEntityBuffLayer",
        args = {
          layer = 5,
          layerType = 4101920,
          name = "p1",
          trigger = 0
        }
      },
      [4] = {
        action = "KillAllMonsters",
        args = {}
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [6] = {
        action = "KillAllMonsters",
        args = {}
      },
      [7] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 15,
          layerType = 4101920,
          name = "p1",
          trigger = 88
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [9] = {
        action = "KillAllMonsters",
        args = {}
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [11] = {
        action = "KillAllMonsters",
        args = {}
      },
      [12] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [13] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 25,
          layerType = 4101920,
          name = "p1",
          trigger = 88
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "觉1强化：每波次开始时获得5层被动"
    }
  },
  name = "列奥突破Ⅵ",
  petList = {
    [1] = {
      awakening = 6,
      equiplv = 1,
      grade = 2,
      id = 1601921,
      level = 1,
      name = "p1"
    }
  },
  remotePet = {},
  setup = {
    [1] = {
      args = {levelID = 4001088, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
