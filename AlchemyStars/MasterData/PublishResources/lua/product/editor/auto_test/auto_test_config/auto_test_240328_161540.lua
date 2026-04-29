AutoTest_240328_161540 = {
  cases = {
    [1] = {
      [1] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 4,
          pos = 505,
          trigger = 88
        }
      },
      [2] = {
        action = "CheckPieceType",
        args = {
          pieceType = 4,
          pos = 505,
          trigger = 88
        }
      },
      [3] = {
        action = "SetAllMonstersHP",
        args = {value = 1000}
      },
      [4] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 505.0
          },
          skillIndex = 1
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [6] = {
        action = "FakeCastSkill",
        args = {
          name = "p2",
          pickUpPos = {
            [1] = 504.0
          },
          skillIndex = 1
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 4,
          pos = 504,
          trigger = 88
        }
      },
      [9] = {
        action = "CheckPieceType",
        args = {
          pieceType = 4,
          pos = 504,
          trigger = 88
        }
      },
      [10] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          },
          skillIndex = 1
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "第二波次开始，增加一次使用机会"
    }
  },
  name = "三十三号突破2",
  petList = {
    [1] = {
      awakening = 2,
      equipRefineLv = 0,
      equiplv = 0,
      grade = 0,
      id = 1502131,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 5,
      equipRefineLv = 0,
      equiplv = 10,
      grade = 3,
      id = 1500331,
      level = 80,
      name = "p2"
    }
  },
  remotePet = {},
  setup = {
    [1] = {
      args = {levelID = 3, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
