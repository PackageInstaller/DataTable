AutoTest_211214_232919 = {
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
        action = "CheckEntityBuffLayer",
        args = {
          layer = 4,
          layerType = 4105511,
          name = "p1",
          trigger = 4
        }
      },
      [8] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [9] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e2",
          trigger = 88
        }
      },
      [10] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e3",
          trigger = 88
        }
      },
      [11] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e4",
          trigger = 88
        }
      },
      [12] = {
        action = "CheckUIPetLayerCount",
        args = {
          expect = 2,
          name = "p1",
          trigger = 88
        }
      },
      [13] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "AttackPercentage",
          attr_select_index = 15,
          expect = 0.048000000417233,
          name = "p1",
          trigger = 4
        }
      },
      [14] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "AttackPercentage",
          attr_select_index = 15,
          expect = 0.024000000208616,
          name = "p1",
          trigger = 88
        }
      },
      [15] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [16] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "每当受到来自于敌人攻击造成的伤害后，获得1层战痕标记"
    }
  },
  name = "彼亚塔曼觉醒1 ",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 1,
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
