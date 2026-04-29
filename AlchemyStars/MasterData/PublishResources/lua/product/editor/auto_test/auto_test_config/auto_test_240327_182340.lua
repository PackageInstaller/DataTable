AutoTest_240327_182340 = {
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
          pos = 303
        }
      },
      [3] = {
        action = "SetEntityPosition",
        args = {name = "p1", pos = 502}
      },
      [4] = {
        action = "CheckUIPetLayerCount",
        args = {
          expect = 1,
          name = "p1",
          trigger = 102
        }
      },
      [5] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 505.0
          },
          skillIndex = 1
        }
      },
      [6] = {
        action = "CheckTrapExist",
        args = {
          exist = true,
          trapIds = {
            [1] = 1.6021612E7
          },
          trigger = 88
        },
        exist = true
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e1",
          trigger = 88
        }
      },
      [9] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 402.0
          },
          pieceType = 1
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [11] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [12] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 402.0,
            [2] = 503.0,
            [3] = 404.0
          },
          pieceType = 1
        }
      },
      [13] = {
        action = "CheckTrapExist",
        args = {
          exist = true,
          trapIds = {
            [1] = 1.6021612E7
          },
          trigger = 88
        },
        exist = true
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [15] = {
        action = "CheckTrapExist",
        args = {
          exist = false,
          trapIds = {
            [1] = 1.6021612E7
          },
          trigger = 88
        },
        exist = true
      },
      [16] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [17] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "范围变为5*5，结界持续3回合"
    }
  },
  name = "璇极突破3",
  petList = {
    [1] = {
      awakening = 3,
      equipRefineLv = 0,
      equiplv = 0,
      grade = 0,
      id = 1602161,
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
