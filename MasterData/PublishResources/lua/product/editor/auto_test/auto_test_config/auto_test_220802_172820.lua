AutoTest_220802_172820 = {
  cases = {
    [1] = {
      [1] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 101311,
          name = "e1",
          pos = 203
        }
      },
      [2] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 101312,
          name = "e2",
          pos = 305
        }
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 101312,
          name = "e3",
          pos = 604
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 101312,
          name = "e4",
          pos = 804
        }
      },
      [5] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 502}
      },
      [6] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 8,
          layerType = 4001580,
          name = "e1",
          trigger = 88
        }
      },
      [7] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 4,
          layerType = 4001580,
          name = "e2",
          trigger = 88
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
          compare = "==",
          name = "e4",
          trigger = 88
        }
      },
      [12] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 603.0,
            [4] = 503.0,
            [5] = 504.0,
            [6] = 505.0,
            [7] = 605.0,
            [8] = 606.0,
            [9] = 506.0,
            [10] = 406.0,
            [11] = 405.0,
            [12] = 404.0,
            [13] = 403.0
          },
          pieceType = 1
        }
      },
      [13] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "连锁技对周围两圈圈造成伤害，水属性怪物增加8层buff其他属性增加4层"
    }
  },
  name = "新岛真连锁技3",
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
