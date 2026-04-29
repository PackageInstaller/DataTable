AutoTest_230518_170802 = {
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
          pos = 505
        }
      },
      [4] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [5] = {
        action = "FakeCastSkill",
        args = {
          name = "p2",
          pickUpPos = {
            [1] = 504.0
          },
          skillIndex = 1
        }
      },
      [6] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 2,
          layerType = 400064,
          name = "p1",
          trigger = 88
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "被动强化：其他雷属性或火属性光灵施放主动技时额外获得1颗弹药"
    }
  },
  name = "雷霆觉醒Ⅲ",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 3,
      id = 1600641,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 1,
      id = 1300581,
      level = 1,
      name = "p2"
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
