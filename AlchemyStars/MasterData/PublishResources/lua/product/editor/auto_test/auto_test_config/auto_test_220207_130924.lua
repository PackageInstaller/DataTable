AutoTest_220207_130924 = {
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
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [4] = {
        action = "CheckEntityPos",
        args = {
          name = "enemy",
          pos = 503,
          trigger = 88
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [6] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 501.0
          },
          pieceType = 1
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "SetTeamPowerFull",
        args = {name = "enemy", name_select_index = 1}
      },
      [9] = {
        action = "BlackFistCastSkill",
        args = {
          name = "r1",
          pickUpPos = {
            [1] = 503.0
          }
        }
      },
      [10] = {
        action = "CheckEntityPos",
        args = {
          name = "team",
          pos = 502,
          trigger = 88
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "白矮星牵引"
    }
  },
  name = "黑拳赛-黑潮牵引",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 2,
      id = 1400811,
      level = 1,
      name = "p1"
    }
  },
  remotePet = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 2,
      id = 1400811,
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
