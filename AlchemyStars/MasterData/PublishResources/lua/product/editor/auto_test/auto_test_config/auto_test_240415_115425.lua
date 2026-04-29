AutoTest_240415_115425 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 301}
      },
      [3] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "team"}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 10151411,
          name = "e1",
          pos = 509
        }
      },
      [5] = {
        action = "SetEntityAttack",
        args = {attack = 10, name = "e1"}
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
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "team",
          trigger = 88
        }
      },
      [8] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 301.0,
            [2] = 401.0,
            [3] = 501.0,
            [4] = 601.0,
            [5] = 701.0,
            [6] = 802.0
          },
          pieceType = 1
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "Boss向玩家丢出一把匕首，对玩家造成小额伤害，并标记此时玩家脚下的格子"
    },
    [2] = {
      [1] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 802.0,
            [2] = 803.0,
            [3] = 804.0,
            [4] = 805.0
          },
          pieceType = 1
        }
      },
      [2] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [3] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [4] = {
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 806,
          trigger = 88
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
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      name = "Boss向玩家所在方向突进两格，对沿途及终点位置的十字四格上的目标造成伤害"
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
          pos = 906,
          trigger = 88
        }
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
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "若玩家位于boss的米字方向上，则boss冲到玩家身前，对玩家造成伤害，同时击退玩家"
    }
  },
  name = "15-14夜王三阶段",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 10,
      grade = 3,
      id = 1600111,
      level = 200,
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
