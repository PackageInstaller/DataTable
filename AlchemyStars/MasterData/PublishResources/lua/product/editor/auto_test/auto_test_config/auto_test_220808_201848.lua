AutoTest_220808_201848 = {
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
          pos = 607
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 303
        }
      },
      [5] = {
        action = "SetOnePieceType",
        args = {pieceType = 3, pos = 403}
      },
      [6] = {
        action = "SetOnePieceType",
        args = {pieceType = 3, pos = 606}
      },
      [7] = {
        action = "SetOnePieceType",
        args = {pieceType = 3, pos = 706}
      },
      [8] = {
        action = "SetOnePieceType",
        args = {pieceType = 3, pos = 804}
      },
      [9] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e1",
          trigger = 88
        }
      },
      [10] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e2",
          trigger = 88
        }
      },
      [11] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
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
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e2",
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
      name = "被动强化：机关在回合结束爆炸"
    }
  },
  name = "琪尔觉醒3",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1501651,
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
