AutoTest_210903_143559 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetPieceType",
        args = {pieceType = 3}
      },
      [3] = {
        action = "SetTeamPowerFull",
        args = {}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 5100111,
          name = "e1",
          pos = 508
        }
      },
      [5] = {
        action = "FakeCastSkill",
        args = {
          name = "p2",
          pickUpPos = {
            [1] = 504.0
          }
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
            [2] = 402.0,
            [3] = 302.0,
            [4] = 202.0,
            [5] = 203.0,
            [6] = 103.0,
            [7] = 104.0,
            [8] = 105.0,
            [9] = 106.0,
            [10] = 206.0,
            [11] = 205.0,
            [12] = 204.0,
            [13] = 303.0,
            [14] = 403.0,
            [15] = 503.0,
            [16] = 602.0,
            [17] = 603.0
          },
          pieceType = 3
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [9] = {
        action = "SetPieceType",
        args = {pieceType = 3}
      },
      [10] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 0,
          layerType = 3029,
          name = "p1",
          trigger = 88
        }
      },
      [11] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 603.0
          },
          pieceType = 3
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "同一回合内释放完路易斯的主动技能后使用普攻将最后一只怪物击杀（当前波次不释放连锁技能）。 其他星灵身上的这个85%攻击力的buff没有卸载"
    }
  },
  name = "26357-童话书主动技后没有还原其他人攻击",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600021,
      level = 10,
      name = "p1"
    },
    [2] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600101,
      level = 10,
      name = "p2"
    }
  },
  setup = {
    [1] = {
      args = {levelID = 1, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
