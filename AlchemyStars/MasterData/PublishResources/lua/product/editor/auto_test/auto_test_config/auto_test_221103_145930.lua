AutoTest_221103_145930 = {
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
          disableai = false,
          id = 5100111,
          name = "e1",
          pos = 305
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 5100111,
          name = "e2",
          pos = 503
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 5100111,
          name = "e3",
          pos = 403
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 5100111,
          name = "e4",
          pos = 806
        }
      },
      [7] = {
        action = "AddBuffToEntity",
        args = {buffID = 88840004, name = "e2"}
      },
      [8] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "attackPercentage",
          damageIndex = 1,
          defname = "e1",
          key = "FinalAtk",
          skillid = 2201482,
          trigger = 102,
          varname = "v1"
        }
      },
      [9] = {
        action = "CheckLocalValue",
        args = {
          target = -0.20000000298023,
          trigger = 102,
          varname = "v1"
        }
      },
      [10] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 603.0,
            [3] = 602.0,
            [4] = 601.0,
            [5] = 501.0,
            [6] = 401.0,
            [7] = 402.0,
            [8] = 302.0,
            [9] = 303.0,
            [10] = 404.0,
            [11] = 504.0,
            [12] = 405.0
          },
          pieceType = 1
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "怪物死亡后降低玩家10%攻击力，可叠加，持续本回合。"
    }
  },
  name = "40004鬼泣颤声",
  petList = {
    [1] = {
      awakening = 6,
      equiplv = 10,
      grade = 3,
      id = 1601481,
      level = 80,
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
