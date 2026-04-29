AutoTest_211215_112949 = {
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
          disableai = false,
          id = 2010313,
          name = "e1",
          pos = 402
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 2010313,
          name = "e2",
          pos = 501
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 2010313,
          name = "e3",
          pos = 602
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 2010313,
          name = "e4",
          pos = 503
        }
      },
      [7] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Defense",
          attr_select_index = 7,
          expect = 568.0,
          name = "p1",
          trigger = 88
        }
      },
      [8] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "被动强化：获得等比例的防御提高"
    }
  },
  name = "彼亚塔曼觉醒2",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 2,
      id = 1500551,
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
