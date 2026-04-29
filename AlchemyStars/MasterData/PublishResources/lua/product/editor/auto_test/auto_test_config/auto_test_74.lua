AutoTest_74 = {
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
          pos = 404
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 405
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 406
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e4",
          pos = 603
        }
      },
      [7] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e5",
          pos = 604
        }
      },
      [8] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 1,
          layerType = 2002,
          name = "e1",
          trigger = 28
        }
      },
      [9] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 0,
          layerType = 2002,
          name = "e2",
          trigger = 28
        }
      },
      [10] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 1,
          layerType = 2002,
          name = "e3",
          trigger = 28
        }
      },
      [11] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 2,
          layerType = 2002,
          name = "e4",
          trigger = 28
        }
      },
      [12] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 0,
          layerType = 2002,
          name = "e5",
          trigger = 28
        }
      },
      [13] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 402.0,
            [3] = 302.0,
            [4] = 303.0,
            [5] = 403.0
          },
          pieceType = 1
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [15] = {
        action = "CheckBuffLogic",
        args = {
          exist = false,
          logic = "ATBuffPoision",
          logic_select_index = 0,
          name = "e1",
          trigger = 88
        }
      },
      [16] = {
        action = "CheckBuffLogic",
        args = {
          exist = false,
          logic = "ATBuffPoision",
          logic_select_index = 0,
          name = "e3",
          trigger = 88
        }
      },
      [17] = {
        action = "CheckBuffLogic",
        args = {
          exist = false,
          logic = "ATBuffPoision",
          logic_select_index = 0,
          name = "e4",
          trigger = 88
        }
      },
      [18] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 403.0
          },
          pieceType = 0
        }
      },
      [19] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "连锁技对往返攻击首个敌人附加1层中毒效果，持续两回合"
    }
  },
  name = "四叶草被动技",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 1,
      id = 1400071,
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
