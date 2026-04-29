AutoTest_240510_173127 = {
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
        args = {hp = 10000, name = "team"}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 290920101,
          name = "e1",
          pos = 503
        }
      },
      [5] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "team",
          trigger = 88
        }
      },
      [6] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 29092006,
          exist = true,
          name = "team",
          trigger = 88
        }
      },
      [7] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "-若玩家位于怪的相邻一圈内,施放回旋斩 -造成两段伤害,受到4层流血"
    },
    [2] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 702.0,
            [4] = 703.0,
            [5] = 704.0,
            [6] = 705.0,
            [7] = 706.0,
            [8] = 707.0,
            [9] = 708.0
          },
          pieceType = 1
        }
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
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "- 不移动，尾部发射激光，必中 - 造成固定+百分比伤害"
    },
    [3] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [3] = {
        action = "CheckEntityPos",
        args = {
          name = "team",
          pos = 708,
          trigger = 88
        }
      },
      [4] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 29092006,
          exist = true,
          name = "team",
          trigger = 88
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "-选择十字方向上玩家所在的一个方向，直线冲刺至版边，若玩家在怪物冲刺路径上则会被击退。 -横展双臂，伤害沿途两列，附加2层流血"
    },
    [4] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [3] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 708.0,
            [2] = 707.0,
            [3] = 706.0,
            [4] = 606.0
          },
          pieceType = 1
        }
      },
      [4] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [5] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "CheckEntityPos",
        args = {
          name = "team",
          pos = 601,
          trigger = 88
        }
      },
      [8] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "-选择十字方向上玩家所在的一个方向，直线冲刺至版边，若玩家在怪物冲刺路径上则会被击退。 -横展双臂，伤害沿途两列，附加2层流血"
    }
  },
  name = "机关兽",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 0,
      id = 1601161,
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
