AutoTest_221102_192314 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetPieceType",
        args = {pieceType = 2}
      },
      [3] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [4] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 502}
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 305
        }
      },
      [6] = {
        action = "AddBuffToAllMonsters",
        args = {buffID = 101001}
      },
      [7] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 101001,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [8] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "CheckBuffLogic",
        args = {
          exist = true,
          logic = "ATBuffStun",
          name = "e1",
          trigger = 88
        }
      },
      [11] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [13] = {
        action = "CheckBuffLogic",
        args = {
          exist = true,
          logic = "ATBuffStun",
          name = "e1",
          trigger = 88
        }
      },
      [14] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [16] = {
        action = "CheckBuffLogic",
        args = {
          exist = true,
          logic = "ATBuffStun",
          name = "e1",
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
      [19] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 101001,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [20] = {
        action = "CheckBuffLogic",
        args = {
          exist = false,
          logic = "ATBuffStun",
          name = "e1",
          trigger = 88
        }
      },
      [21] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [22] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [23] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 101001,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [24] = {
        action = "CheckBuffLogic",
        args = {
          exist = false,
          logic = "ATBuffStun",
          name = "e1",
          trigger = 88
        }
      },
      [25] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [26] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "受到的控制效果持续时间增加3回合"
    }
  },
  name = "1010 强力控制",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1500901,
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
