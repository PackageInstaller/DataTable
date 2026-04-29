AutoTest_240415_153910 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 2905201,
          name = "e1",
          pos = 505
        }
      },
      [4] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "team"}
      },
      [5] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "team",
          trigger = 88
        }
      },
      [6] = {
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 506,
          trigger = 88
        }
      },
      [7] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "向光灵移动，并造成大量伤害，随后移动至远离目标的位置"
    },
    [2] = {
      [1] = {
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 506,
          trigger = 88
        }
      },
      [2] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [3] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [4] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "team",
          trigger = 88
        }
      },
      [5] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "移动后，对范围内的光灵造成伤害"
    }
  },
  name = "16-14暗黑天使斐桀洛",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 0,
      id = 1400071,
      level = 1,
      name = "p1"
    }
  },
  remotePet = {},
  setup = {
    [1] = {
      args = {levelID = 101614, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
