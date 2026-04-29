AutoTest_220127_170138 = {
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
            [1] = 506.0,
            [2] = 507.0
          }
        }
      },
      [4] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [5] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 506,
          trapIds = {
            [1] = 14.0
          },
          trigger = 88
        }
      },
      [6] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 507,
          trapIds = {
            [1] = 14.0
          },
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
      [9] = {
        action = "SetOnePieceType",
        args = {pieceType = 3, pos = 508}
      },
      [10] = {
        action = "CheckGridTrap",
        args = {
          exist = false,
          pos = 506,
          trapIds = {
            [1] = 14.0
          },
          trigger = 88
        }
      },
      [11] = {
        action = "CheckGridTrap",
        args = {
          exist = false,
          pos = 507,
          trapIds = {
            [1] = 14.0
          },
          trigger = 88
        }
      },
      [12] = {
        action = "BlackFistFakeChainPath",
        args = {
          chainPath = {
            [1] = 505.0,
            [2] = 506.0,
            [3] = 507.0,
            [4] = 508.0
          },
          pieceType = 3
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "敌方踩我方召唤的强化格子不消失"
    }
  },
  name = "黑拳赛-敌方踩我方强化格子",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1600021,
      level = 1,
      name = "p1"
    }
  },
  remotePet = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1600021,
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
