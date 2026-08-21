AutoTest_140 = {
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
          pos = 107
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 408
        }
      },
      [6] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 501.0,
            [3] = 401.0,
            [4] = 402.0,
            [5] = 302.0,
            [6] = 303.0,
            [7] = 203.0,
            [8] = 204.0,
            [9] = 205.0,
            [10] = 306.0
          },
          pieceType = 1
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 306.0,
            [2] = 406.0,
            [3] = 506.0,
            [4] = 507.0,
            [5] = 508.0,
            [6] = 509.0,
            [7] = 609.0,
            [8] = 608.0,
            [9] = 607.0,
            [10] = 606.0,
            [11] = 605.0,
            [12] = 604.0,
            [13] = 605.0,
            [14] = 705.0
          },
          pieceType = 1
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 10042,
          exist = false,
          name = "e1",
          trigger = 30
        }
      },
      [11] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 10042,
          exist = true,
          name = "e2",
          trigger = 30
        }
      },
      [12] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 405.0
          }
        }
      },
      [13] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 705.0
          },
          pieceType = 0
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [15] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 705.0
          },
          pieceType = 0
        }
      },
      [16] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [17] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 705.0
          },
          pieceType = 0
        }
      },
      [18] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [19] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 10042,
          exist = false,
          name = "e2",
          trigger = 88
        }
      },
      [20] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [21] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "对拥有5层印记的敌人附加减速，持续2回合"
    }
  },
  name = "基汀主动技：减速",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1300461,
      level = 10,
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
