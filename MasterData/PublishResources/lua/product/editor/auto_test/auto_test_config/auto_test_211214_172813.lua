AutoTest_211214_172813 = {
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
        action = "SetEntityHPPercent",
        args = {name = "team", percent = 0.5}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 303
        }
      },
      [5] = {
        action = "CheckUIPetLayerCount",
        args = {
          expect = 11,
          name = "p1",
          trigger = 88
        }
      },
      [6] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 410117,
          exist = true,
          name = "p1",
          trigger = 88
        }
      },
      [7] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 403.0
          }
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [9] = {
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [10] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 205
        }
      },
      [11] = {
        action = "CheckUIPetLayerCount",
        args = {
          expect = 14,
          name = "p1",
          trigger = 88
        }
      },
      [12] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 404.0
          }
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [14] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "<",
          name = "team",
          trigger = 9
        }
      },
      [15] = {
        action = "CheckUIPetLayerCount",
        args = {
          expect = 20,
          name = "p1",
          trigger = 88
        }
      },
      [16] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 20,
          layerType = 410117,
          name = "p1",
          trigger = 88
        }
      },
      [17] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [18] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "被动强化：主动技每命中一个敌人获得1层临时的狂化值，外圈效果翻倍；这部分没有上限，但是波次结束会清空，且每清空1层回复等同于克5%血量上限的生命值"
    }
  },
  name = "克觉醒3",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1601171,
      level = 1,
      name = "p1"
    }
  },
  remotePet = {},
  setup = {
    [1] = {
      args = {levelID = 2, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
