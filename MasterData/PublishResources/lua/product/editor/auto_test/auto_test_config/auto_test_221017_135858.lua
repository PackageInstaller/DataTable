AutoTest_221017_135858 = {
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
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 304
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 604
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 606
        }
      },
      [6] = {
        action = "AddBuffToEntity",
        args = {buffID = 100001, name = "e1"}
      },
      [7] = {
        action = "AddBuffToEntity",
        args = {buffID = 100201, name = "e1"}
      },
      [8] = {
        action = "AddBuffToEntity",
        args = {buffID = 100203, name = "e1"}
      },
      [9] = {
        action = "SetEntityAttack",
        args = {attack = 999999, name = "p1"}
      },
      [10] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "清醒状态下，其他敌人不会被击杀(换回和生效)"
    },
    [2] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "CheckMonsterCount",
        args = {
          count = 3,
          monsterid = 5100111,
          trigger = 88
        }
      },
      [3] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0
          },
          pieceType = 1
        }
      },
      [4] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "buff检查敌人不会死亡"
    },
    [3] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "AddBuffToEntity",
        args = {buffID = 10011, name = "e1"}
      },
      [3] = {
        action = "CheckMonsterCount",
        args = {
          count = 3,
          monsterid = 5100111,
          trigger = 88
        }
      },
      [4] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 504.0,
            [2] = 505.0,
            [3] = 506.0
          },
          pieceType = 1
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "非清醒状态下，其他敌人会被击杀(调整回合生效)"
    },
    [4] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "CheckMonsterCount",
        args = {
          count = 2,
          monsterid = 5100111,
          trigger = 88
        }
      },
      [3] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [4] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "非清醒状态下，其他敌人会被击杀"
    }
  },
  name = "不倒之躯",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1400071,
      level = 1,
      name = "p1"
    }
  },
  remotePet = {},
  setup = {
    [1] = {
      args = {levelID = 1, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
