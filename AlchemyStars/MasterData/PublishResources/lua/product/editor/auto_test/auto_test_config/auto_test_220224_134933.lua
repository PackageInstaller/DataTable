AutoTest_220224_134933 = {
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
          dir = 5,
          disableai = true,
          id = 2071313,
          name = "e1",
          pos = 505
        }
      },
      [4] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [5] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 4001361,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [6] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 3,
          layerType = 400136,
          name = "e1",
          trigger = 88
        }
      },
      [7] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "突2：先制攻击 突5：觉2效果增强:附加3层"
    }
  },
  name = "露科亚突2突5",
  petList = {
    [1] = {
      awakening = 5,
      equiplv = 1,
      grade = 3,
      id = 1501361,
      level = 1,
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
