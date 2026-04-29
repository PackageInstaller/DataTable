AutoTest_220802_170025 = {
  cases = {
    [1] = {
      [1] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 101311,
          name = "e1",
          pos = 604
        }
      },
      [2] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 101312,
          name = "e2",
          pos = 703
        }
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 101312,
          name = "e3",
          pos = 802
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 101312,
          name = "e4",
          pos = 605
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 101312,
          name = "e5",
          pos = 805
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 101312,
          name = "e6",
          pos = 405
        }
      },
      [7] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 502}
      },
      [8] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 6,
          layerType = 4001580,
          name = "e1",
          trigger = 88
        }
      },
      [9] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 3,
          layerType = 4001580,
          name = "e2",
          trigger = 88
        }
      },
      [10] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [11] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e2",
          trigger = 88
        }
      },
      [12] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e3",
          trigger = 88
        }
      },
      [13] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e4",
          trigger = 88
        }
      },
      [14] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e5",
          trigger = 88
        }
      },
      [15] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e6",
          trigger = 88
        }
      },
      [16] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 501.0,
            [3] = 401.0,
            [4] = 301.0,
            [5] = 202.0,
            [6] = 302.0,
            [7] = 402.0,
            [8] = 403.0,
            [9] = 503.0,
            [10] = 603.0
          },
          pieceType = 1
        }
      },
      [17] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [18] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "连锁技对米字形16格内造成伤害，水属性怪物增加6层buff其他属性增加3层"
    }
  },
  name = "新岛真连锁技2",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1601591,
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
