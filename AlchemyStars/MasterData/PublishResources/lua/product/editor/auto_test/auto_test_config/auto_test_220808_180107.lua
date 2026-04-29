AutoTest_220808_180107 = {
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
          pos = 506
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 5100111,
          name = "e2",
          pos = 807
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 508
        }
      },
      [6] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e2",
          trigger = 88
        }
      },
      [7] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 607,
          trapIds = {
            [1] = 8001651.0
          },
          trigger = 28
        }
      },
      [8] = {
        action = "CheckFormulaAttr",
        args = {
          attr = "damagePercent",
          defname = "e2",
          expect = 0.15000000596046,
          key = "CalcDamage_108",
          skillid = 5001651,
          trigger = 102
        }
      },
      [9] = {
        action = "CheckTrapCount",
        args = {
          expect = 0,
          trapIDs = {
            [1] = 8001651.0
          },
          trigger = 88
        }
      },
      [10] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 403.0,
            [4] = 303.0,
            [5] = 304.0,
            [6] = 404.0
          },
          pieceType = 1
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "连锁技在命中单位周围的随机格子上生成钻头机关，被怪经过时爆炸，对十字5格造成无视防御的XX%伤害；回合结束未爆炸的消失"
    }
  },
  name = "琪尔觉醒1",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 1,
      id = 1501651,
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
