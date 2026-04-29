AutoTest_220207_104617 = {
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
        action = "SetTeamPosition",
        args = {name = "team", pos = 503}
      },
      [4] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "enemy"}
      },
      [5] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 503.0
          }
        }
      },
      [6] = {
        action = "CheckEntityPos",
        args = {
          name = "r1",
          pos = 509,
          trigger = 88
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [11] = {
        action = "BlackFistFakeChainPath",
        args = {
          chainPath = {
            [1] = 509.0,
            [2] = 508.0,
            [3] = 507.0,
            [4] = 506.0,
            [5] = 505.0
          },
          pieceType = 1
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [13] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [15] = {
        action = "SetTeamPowerFull",
        args = {name = "enemy", name_select_index = 1}
      },
      [16] = {
        action = "CheckEntityPos",
        args = {
          name = "team",
          pos = 501,
          trigger = 88
        }
      },
      [17] = {
        action = "BlackFistCastSkill",
        args = {
          name = "r1",
          pickUpPos = {
            [1] = 505.0
          }
        }
      },
      [18] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "恐尔贡击退"
    }
  },
  name = "黑拳赛-恐尔贡击退",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 2,
      id = 1200501,
      level = 1,
      name = "p1"
    }
  },
  remotePet = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 2,
      id = 1200501,
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
