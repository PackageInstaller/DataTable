AutoTest_230511_105653 = {
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
          layer = 10,
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
          layer = 20,
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
          layer = 30,
          layerType = 4101920,
          name = "p1",
          trigger = 88
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "被动:初始获得层数5"
    }
  },
  name = "列奥精炼Ⅱ",
  petList = {
    [1] = {
      awakening = 6,
      equipRefineLv = 2,
      equiplv = 10,
      grade = 3,
      id = 1601921,
      level = 80,
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
