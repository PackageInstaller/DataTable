AutoTest_211213_215012 = {
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
          pos = 501
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 202
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 305
        }
      },
      [6] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 20031,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [7] = {
        action = "CheckBuffLogic",
        args = {
          exist = true,
          logic = "ATBuffBleed",
          logic_select_index = 13,
          name = "e1",
          trigger = 88
        }
      },
      [8] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 20031,
          exist = true,
          name = "e2",
          trigger = 88
        }
      },
      [9] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 20031,
          exist = false,
          name = "e3",
          trigger = 88
        }
      },
      [10] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          invert = 0.0,
          name = "e1",
          trigger = 88
        }
      },
      [11] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          invert = 0.0,
          name = "e2",
          trigger = 88
        }
      },
      [12] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          invert = 0.0,
          name = "e3",
          trigger = 88
        }
      },
      [13] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 402.0,
            [3] = 303.0
          },
          pieceType = 1
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "1阶段连锁：连线2格，对x形8格造成伤害"
    },
    [2] = {
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
          name = "e4",
          pos = 607
        }
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e5",
          pos = 807
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e6",
          pos = 806
        }
      },
      [5] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e4",
          trigger = 88
        }
      },
      [6] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e5",
          trigger = 88
        }
      },
      [7] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e6",
          trigger = 88
        }
      },
      [8] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 20031,
          exist = true,
          name = "e4",
          trigger = 88
        }
      },
      [9] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 20031,
          exist = true,
          name = "e5",
          trigger = 88
        }
      },
      [10] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 20031,
          exist = false,
          name = "e6",
          trigger = 88
        }
      },
      [11] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 303.0,
            [2] = 403.0,
            [3] = 503.0,
            [4] = 603.0,
            [5] = 703.0,
            [6] = 803.0,
            [7] = 804.0,
            [8] = 704.0,
            [9] = 604.0,
            [10] = 605.0
          },
          pieceType = 1
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "2阶段连锁：连线9格，对米字形16格造成伤害"
    }
  },
  name = "帕索洛连锁技",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1401271,
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
