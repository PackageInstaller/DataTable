AutoTest_364 = {
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
        action = "SetPieceType",
        args = {pieceType = 4}
      },
      [4] = {
        action = "SetOnePieceType",
        args = {pieceType = 3, pos = 401}
      },
      [5] = {
        action = "SetOnePieceType",
        args = {pieceType = 2, pos = 501}
      },
      [6] = {
        action = "SetOnePieceType",
        args = {pieceType = 2, pos = 504}
      },
      [7] = {
        action = "SetOnePieceType",
        args = {pieceType = 3, pos = 601}
      },
      [8] = {
        action = "SetOnePieceType",
        args = {pieceType = 3, pos = 702}
      },
      [9] = {
        action = "SetOnePieceType",
        args = {pieceType = 2, pos = 802}
      },
      [10] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 3,
          layerType = 4100961,
          name = "p1",
          trigger = 25
        }
      },
      [11] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0
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
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 401,
          trigger = 30
        }
      },
      [15] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 501,
          trigger = 30
        }
      },
      [16] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 504,
          trigger = 30
        }
      },
      [17] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 601,
          trigger = 30
        }
      },
      [18] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 702,
          trigger = 30
        }
      },
      [19] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 802,
          trigger = 30
        }
      },
      [20] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 802,
          trapIds = {
            [1] = 14.0
          },
          trigger = 30
        }
      },
      [21] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 503.0
          }
        }
      },
      [22] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "1.觉醒1：获得沙利叶印记，最大8层 2.突3：主动技上回合处于就绪状态，本回合转色数量+1 3.改变5个格子"
    }
  },
  name = "沙利叶主动技2",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 6,
      equiplv = 1,
      grade = 3,
      id = 1600961,
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
