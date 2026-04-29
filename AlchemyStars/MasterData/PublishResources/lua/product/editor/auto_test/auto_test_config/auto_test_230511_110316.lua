AutoTest_230511_110316 = {
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
          pos = 305
        }
      },
      [3] = {
        action = "SetEntityBuffLayer",
        args = {
          display = true,
          layer = 10,
          layerType = 4101920,
          name = "p1"
        }
      },
      [4] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          },
          skillIndex = 1
        }
      },
      [5] = {
        action = "CheckTrapCount",
        args = {
          expect = 2,
          trapIDs = {
            [1] = 14.0
          },
          trigger = 88
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "主动技强化：点选范围内随机生成2个强化格子"
    }
  },
  name = "列奥精炼Ⅲ",
  petList = {
    [1] = {
      awakening = 3,
      equipRefineLv = 3,
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
      args = {levelID = 1, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
