AutoTest_15 = {
  cases = {
    [1] = {
      [1] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 502}
      },
      [2] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 805
        }
      },
      [3] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0
          },
          pieceType = 0
        }
      },
      [4] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [5] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0
          },
          pieceType = 0
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
            [1] = 502.0
          },
          pieceType = 0
        }
      },
      [8] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 3,
          layerType = 40059,
          name = "p1",
          trigger = 9
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 0,
          layerType = 40059,
          name = "p1",
          trigger = 30
        }
      },
      [11] = {
        action = "CheckEntityPos",
        args = {
          name = "p1",
          pos = 205,
          trigger = 30
        }
      },
      [12] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 205.0
          }
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "每回合开始获得1层，最大不超过3，主动技圈数范围与印记一致，使用后清空"
    }
  },
  name = "匹皮被动技（装备5级）",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 3,
      grade = 1,
      id = 1300591,
      level = 1,
      name = "p1"
    }
  },
  setup = {
    [1] = {
      args = {levelID = 1, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
