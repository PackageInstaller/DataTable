AutoTest_221110_222131 = {
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
        args = {name = "team"}
      },
      [4] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "team"}
      },
      [5] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [6] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "team",
          trigger = 88
        }
      },
      [7] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 404.0,
            [2] = 503.0,
            [3] = 604.0
          },
          skillid = 290290101,
          trigger = 102
        }
      },
      [8] = {
        action = "CheckEntityPos",
        args = {
          name = "p1",
          pos = 502,
          trigger = 88
        }
      },
      [9] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0
          },
          pieceType = 1
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "主动技反制时身体不增长，身体和尾部跟随头部移动  Boss向相邻4格中距离玩家较近的位置移动1格，若该位置有光灵存在，对光灵造成高额伤害并击退到相邻4格"
    },
    [2] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 602.0,
            [5] = 604.0,
            [6] = 702.0,
            [7] = 703.0,
            [8] = 704.0
          },
          skillid = 290290104,
          trigger = 102
        }
      },
      [3] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 702.0
          },
          pieceType = 1
        }
      },
      [4] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "身体每节1*1，无敌，具有多个，怪物回合开始时生成新的身体；所有身体部位跟随头部移动"
    }
  },
  name = "13-7贪吃蛇",
  petList = {
    [1] = {
      awakening = 1,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 1,
      id = 1400071,
      level = 1,
      name = "p1"
    }
  },
  remotePet = {},
  setup = {
    [1] = {
      args = {levelID = 101307, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
