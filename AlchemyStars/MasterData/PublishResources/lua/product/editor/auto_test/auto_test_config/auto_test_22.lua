AutoTest_22 = {
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
          pos = 304
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
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [6] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0
          },
          pieceType = 0
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 403.0
          },
          pieceType = 1
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [12] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [14] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 30
        }
      },
      [15] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e2",
          trigger = 30
        }
      },
      [16] = {
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 106,
          trigger = 30
        }
      },
      [17] = {
        action = "CheckEntityPos",
        args = {
          name = "e2",
          pos = 409,
          trigger = 30
        }
      },
      [18] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 403.0
          }
        }
      },
      [19] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "主动技cd-1，变为2"
    }
  },
  name = "锯里克主动技cd-1",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 3,
      equiplv = 1,
      grade = 2,
      id = 1300221,
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
