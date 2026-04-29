AutoTest_220207_105046 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [3] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "enemy"}
      },
      [4] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [5] = {
        action = "CheckEntityPos",
        args = {
          name = "enemy",
          pos = 509,
          trigger = 88
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [9] = {
        action = "SetTeamPowerFull",
        args = {name = "enemy", name_select_index = 1}
      },
      [10] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [11] = {
        action = "BlackFistCastSkill",
        args = {
          name = "r1",
          pickUpPos = {
            [1] = 509.0
          }
        }
      },
      [12] = {
        action = "CheckEntityPos",
        args = {
          name = "team",
          pos = 501,
          trigger = 88
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [14] = {
        action = "BlackFistFakeChainPath",
        args = {
          chainPath = {
            [1] = 509.0
          },
          pieceType = 0
        }
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "锯里克击退"
    }
  },
  name = "黑拳赛-锯里克击退",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 2,
      id = 1300221,
      level = 1,
      name = "p1"
    }
  },
  remotePet = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 2,
      id = 1300221,
      level = 1,
      name = "r1"
    }
  },
  setup = {
    [1] = {
      args = {levelID = 1, matchType = 12},
      setup = "LevelBasic"
    }
  }
}
