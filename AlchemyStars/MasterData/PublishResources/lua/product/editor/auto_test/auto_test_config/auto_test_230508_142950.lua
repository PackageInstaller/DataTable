AutoTest_230508_142950 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [3] = {
        action = "SetEntityHP",
        args = {hp = 1000000, name = "team"}
      },
      [4] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "team",
          trigger = 88
        }
      },
      [5] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 501.0
          },
          pieceType = 1
        }
      },
      [6] = {
        action = "CheckTrapExist",
        args = {
          exist = true,
          trapIds = {
            [1] = 2905300.0
          },
          trigger = 88
        },
        exist = true
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "Boss向玩家丢出一把匕首，对玩家造成小额伤害，并标记此时玩家脚下的格子"
    },
    [2] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [3] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "team",
          trigger = 88
        }
      },
      [4] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 501.0,
            [2] = 401.0
          },
          pieceType = 1
        }
      },
      [5] = {
        action = "CheckTrapCount",
        args = {
          expect = 2,
          trapIDs = {
            [1] = 2905300.0
          },
          trigger = 88
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "若玩家不位于boss的米字方向上，或boss技能3未能命中玩家，则boss额外释放一次主动技能1"
    },
    [3] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [3] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "team",
          trigger = 88
        }
      },
      [4] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 401.0,
            [2] = 402.0,
            [3] = 403.0,
            [4] = 404.0
          },
          pieceType = 1
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "主动技能4-连续突进"
    },
    [4] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "team",
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
      name = "主动技能2-突进"
    },
    [5] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [3] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [4] = {
        action = "CheckEntityPos",
        args = {
          name = "team",
          pos = 904,
          trigger = 88
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "若玩家位于boss的米字方向上，则boss冲到玩家身前，对玩家造成伤害，同时击退玩家"
    }
  },
  name = "夜王boss三阶段",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1600301,
      level = 1,
      name = "p1"
    }
  },
  remotePet = {},
  setup = {
    [1] = {
      args = {levelID = 101514, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
