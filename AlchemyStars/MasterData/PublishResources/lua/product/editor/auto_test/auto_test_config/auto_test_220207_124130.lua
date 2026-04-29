AutoTest_220207_124130 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetEntityHPPercent",
        args = {name = "team", percent = 0.5}
      },
      [3] = {
        action = "SetEntityHPPercent",
        args = {name = "enemy", percent = 0.5}
      },
      [4] = {
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [5] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 403.0
          }
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "<",
          name = "team",
          trigger = 88
        }
      },
      [8] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "enemy",
          trigger = 88
        }
      },
      [9] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [11] = {
        action = "SetTeamPowerFull",
        args = {name = "enemy", name_select_index = 1}
      },
      [12] = {
        action = "BlackFistCastSkill",
        args = {
          name = "r1",
          pickUpPos = {
            [1] = 604.0
          }
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [14] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "<",
          name = "enemy",
          trigger = 88
        }
      },
      [15] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "team",
          trigger = 88
        }
      },
      [16] = {
        action = "BlackFistFakeChainPath",
        args = {
          chainPath = {
            [1] = 505.0
          },
          pieceType = 0
        }
      },
      [17] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "艾米回血，敌方旗子未消失"
    }
  },
  name = "黑拳赛-艾米回血",
  petList = {
    [1] = {
      awakening = 3,
      equiplv = 10,
      grade = 2,
      id = 1300581,
      level = 1,
      name = "p1"
    }
  },
  remotePet = {
    [1] = {
      awakening = 3,
      equiplv = 10,
      grade = 2,
      id = 1300581,
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
