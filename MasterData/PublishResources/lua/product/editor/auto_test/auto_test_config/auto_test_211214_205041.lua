AutoTest_211214_205041 = {
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
          pos = 503
        }
      },
      [4] = {
        action = "SetAllMonstersHPPercent",
        args = {percent = 0.10000000149012}
      },
      [5] = {
        action = "CheckUIPetLayerCount",
        args = {
          expect = 1,
          name = "p1",
          trigger = 88
        }
      },
      [6] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 410122,
          exist = true,
          name = "p1",
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
      [9] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 505
        }
      },
      [10] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 604
        }
      },
      [11] = {
        action = "SetAllMonstersHPPercent",
        args = {percent = 0.10000000149012}
      },
      [12] = {
        action = "CheckUIPetLayerCount",
        args = {
          expect = 3,
          name = "p1",
          trigger = 88
        }
      },
      [13] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 410122,
          exist = true,
          name = "p1",
          trigger = 88
        }
      },
      [14] = {
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
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "全队每击杀一个敌人，获得1层加成，提高主动技XXX%的伤害系数（每波次开始损失10%层数，剩余层数向下取整）"
    }
  },
  name = "艾尔戈丝觉醒1",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 1,
      id = 1601221,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equiplv = 1,
      grade = 1,
      id = 1600111,
      level = 1,
      name = "p2"
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
