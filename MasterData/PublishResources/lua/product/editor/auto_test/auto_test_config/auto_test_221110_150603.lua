AutoTest_221110_150603 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 502}
      },
      [3] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "team"}
      },
      [4] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [5] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0
          },
          pieceType = 1
        }
      },
      [6] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 1,
          layerType = 20021,
          name = "team",
          trigger = 0
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
        action = "CheckEntityBuffLayer",
        args = {
          layer = 7,
          layerType = 20021,
          name = "team",
          trigger = 0
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "如果玩家在Boss周围一圈，对玩家造成伤害，并叠加5层毒buff"
    },
    [2] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 12,
          layerType = 20021,
          name = "team",
          trigger = 0
        }
      },
      [3] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 503.0,
            [2] = 402.0,
            [3] = 302.0,
            [4] = 202.0,
            [5] = 103.0
          },
          pieceType = 1
        }
      },
      [4] = {
        action = "CheckMonsterCount",
        args = {
          count = 3,
          monsterid = 2000609,
          trigger = 88
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "如果玩家不在Boss周围一圈，则在场边召唤3个黎晕状态1回合"
    },
    [3] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetEntityAttack",
        args = {attack = 111111, name = "p1"}
      },
      [3] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 505.0
          }
        }
      },
      [4] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "当花朵脑袋被击破后（即血量打到1格锁血），整个花体进入眩晕状态1回合"
    }
  },
  name = "13-14恶面花",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1601291,
      level = 1,
      name = "p1"
    }
  },
  remotePet = {},
  setup = {
    [1] = {
      args = {levelID = 101314, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
