AutoTest_211206_180439 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "CheckBattleResult",
        args = {trigger = 80, victory = 1}
      },
      [3] = {
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [4] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
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
            [1] = 506.0
          },
          pieceType = 0
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [9] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [11] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 506.0
          },
          pieceType = 0
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [13] = {
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [14] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [16] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 506.0
          },
          pieceType = 0
        }
      },
      [17] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [18] = {
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [19] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [20] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [21] = {
        action = "WaitGameOver",
        args = {}
      },
      name = "杀死7波怪物"
    }
  },
  name = "104守护风船胜利",
  petList = {
    [1] = {
      awakening = 3,
      equiplv = 1,
      grade = 3,
      id = 1600051,
      level = 3,
      name = "p1"
    }
  },
  remotePet = {},
  setup = {
    [1] = {
      args = {levelID = 110, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
