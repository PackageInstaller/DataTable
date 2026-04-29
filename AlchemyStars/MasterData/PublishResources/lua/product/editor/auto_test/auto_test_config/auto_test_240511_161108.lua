AutoTest_240511_161108 = {
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
        args = {hp = 100000, name = "team"}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 2909701,
          name = "e1",
          pos = 305
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
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 601.0,
            [4] = 501.0,
            [5] = 401.0,
            [6] = 402.0,
            [7] = 301.0,
            [8] = 302.0,
            [9] = 303.0,
            [10] = 304.0,
            [11] = 204.0
          },
          pieceType = 1
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "每回合开始时随机标定n个（暂定2*2）区域，光灵每连线经过10（暂定）个格子后，区域内会有地火喷发，对范围内光灵造成伤害（只取队长位置）"
    },
    [2] = {
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
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 305,
          trigger = 88
        }
      },
      [4] = {
        action = "CheckTrapExist",
        args = {
          exist = true,
          trapIds = {
            [1] = 2909701.0
          },
          trigger = 88
        },
        exist = true
      },
      [5] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 204.0,
            [2] = 104.0,
            [3] = 105.0
          },
          pieceType = 1
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "朝光灵所在方向造成扇形大范围伤害并生成碎石。"
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
        action = "CheckEntityPos",
        args = {
          name = "p1",
          pos = 301,
          trigger = 88
        }
      },
      [4] = {
        action = "CheckUIHPShieldExist",
        args = {
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [5] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 105.0,
            [2] = 204.0,
            [3] = 304.0
          },
          pieceType = 1
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "对全屏范围造成3次伤害，每次击退1格，若无法被击退则受到更高伤害。 boss为自身添加相当于生命上限10%的血条护盾 "
    },
    [4] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetEntityPosition",
        args = {name = "p1", pos = 304}
      },
      [3] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "team",
          key = "CalcDamage_19",
          skillid = 29097012,
          trigger = 102,
          varname = "v1"
        }
      },
      [4] = {
        action = "CheckLocalValue",
        args = {
          target = 0.029999999329448,
          trigger = 88,
          varname = "v1"
        }
      },
      [5] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新测试用例"
    }
  },
  name = "无厌·岩浆",
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
      args = {levelID = 1, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
