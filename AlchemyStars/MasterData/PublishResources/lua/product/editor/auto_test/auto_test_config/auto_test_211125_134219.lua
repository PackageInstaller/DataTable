AutoTest_211125_134219 = {
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
        args = {name = "team", name_select_index = 0}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
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
        action = "CaptureDamageValue",
        args = {
          key = "v1",
          name = "e1",
          trigger = 18
        }
      },
      [11] = {
        action = "CaptureDoubleChainDamageValue",
        args = {
          key = "v2",
          name = "e1",
          trigger = 18
        }
      },
      [12] = {
        action = "CompareLocalValue",
        args = {
          cmp = ">",
          key1 = "v1",
          key2 = "v2",
          trigger = 71
        }
      },
      [13] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 603.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 604.0,
            [5] = 605.0,
            [6] = 505.0,
            [7] = 506.0,
            [8] = 606.0,
            [9] = 607.0
          },
          pieceType = 3
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "使用后本回合森系光灵的连锁技会释放2次，第2次释放时所有森系光灵攻击力为露易丝攻击力的70%"
    }
  },
  name = "童话书二次连锁伤害数值",
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
