AutoTest_221021_145529 = {
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
          pos = 505
        }
      },
      [4] = {
        action = "AddBuffToEntity",
        args = {buffID = 100001, name = "e1"}
      },
      [5] = {
        action = "AddBuffToEntity",
        args = {buffID = 10260501, name = "e1"}
      },
      [6] = {
        action = "SetAllMonstersHP",
        args = {value = 5000}
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
        action = "CheckEntityHP",
        args = {
          compare = "==",
          hp = 5000,
          name = "e1",
          trigger = 88
        }
      },
      [10] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 603.0,
            [3] = 604.0
          },
          pieceType = 1
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "清醒状态下，每当受到任何伤害（连锁技），恢复10%血量（5000）"
    },
    [2] = {
      [1] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [2] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [3] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 604.0,
            [2] = 605.0
          },
          pieceType = 1
        }
      },
      [4] = {
        action = "CheckEntityHP",
        args = {
          compare = "==",
          hp = 5000,
          name = "e1",
          trigger = 88
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "清醒状态下，每当受到任何伤害（普攻），恢复10%血量（怪物血量5000）"
    },
    [3] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "CheckEntityHP",
        args = {
          compare = "==",
          hp = 4611,
          name = "e1",
          trigger = 88
        }
      },
      [3] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [4] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "清醒状态下，每当受到任何伤害（主动技），恢复10%血量（怪物血量5000）"
    },
    [4] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "AddBuffToEntity",
        args = {buffID = 10011, name = "e1"}
      },
      [3] = {
        action = "CheckEntityHP",
        args = {
          compare = "==",
          hp = 3746,
          name = "e1",
          trigger = 88
        }
      },
      [4] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 504.0,
            [2] = 505.0,
            [3] = 506.0,
            [4] = 507.0,
            [5] = 508.0
          },
          pieceType = 1
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "非清醒状态下，无回血效果"
    }
  },
  name = "102605复苏V",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 0,
      grade = 0,
      id = 1600061,
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
