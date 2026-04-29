AutoTest_240416_145528 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetEntityPosition",
        args = {name = "team", pos = 502}
      },
      [3] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "team"}
      },
      [4] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 102012101,
          name = "e1",
          pos = 305
        }
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
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 601,
          trigger = 88
        }
      },
      [8] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 303.0,
            [2] = 304.0,
            [3] = 305.0,
            [4] = 402.0,
            [5] = 403.0,
            [6] = 404.0,
            [7] = 405.0,
            [8] = 501.0,
            [9] = 502.0,
            [10] = 503.0,
            [11] = 504.0,
            [12] = 601.0,
            [13] = 602.0,
            [14] = 701.0
          },
          skillid = 29063011,
          trigger = 102
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      name = "瞄准光灵所在位置，冲刺至版边。并对沿途3列宽度范围内的敌人造成伤害"
    },
    [2] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 505,
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
      [5] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "向光灵移动后，对前方两格方范围内目标造成伤害。进入场景无法选择技能，暂时不能写用例"
    },
    [3] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "尤利西斯操控守护者·原型对处于任意位置的光灵造成伤害。进入场景无法选择技能，暂时不能写用例"
    }
  },
  name = "20-14生化尤利西斯",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
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
      args = {levelID = 102012, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
