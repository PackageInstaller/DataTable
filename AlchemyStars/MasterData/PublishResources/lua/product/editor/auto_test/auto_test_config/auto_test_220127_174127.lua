AutoTest_220127_174127 = {
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
        action = "CheckEntityBuffLayer",
        args = {
          layer = 8,
          layerType = 4100961,
          name = "r1",
          trigger = 88
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 404.0,
            [5] = 405.0,
            [6] = 406.0,
            [7] = 506.0,
            [8] = 606.0,
            [9] = 605.0,
            [10] = 604.0
          },
          pieceType = 1
        }
      },
      [8] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 7,
          layerType = 4100961,
          name = "r1",
          trigger = 88
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "BlackFistFakeChainPath",
        args = {
          chainPath = {
            [1] = 505.0
          },
          pieceType = 1
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "薇丝攻击沙立叶被动层数没有每次攻击+1，而是直接+8"
    }
  },
  name = "黑拳赛-沙利叶被动层数",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1600961,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1500331,
      level = 1,
      name = "p1"
    }
  },
  remotePet = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1600961,
      level = 1,
      name = "r1"
    },
    [2] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1500331,
      level = 1,
      name = "r2"
    }
  },
  setup = {
    [1] = {
      args = {levelID = 1, matchType = 12},
      setup = "LevelBasic"
    }
  }
}
