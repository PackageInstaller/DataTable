AutoTest_211212_170534 = {
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
          pos = 504
        }
      },
      [4] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 14,
          name = "j1",
          pos = 503
        }
      },
      [5] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [6] = {
        action = "CheckUIPetLayerCount",
        args = {
          expect = 1,
          name = "p1",
          trigger = 3
        }
      },
      [7] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 400115,
          exist = true,
          name = "p1",
          trigger = 88
        }
      },
      [8] = {
        action = "CheckAttributeChange",
        args = {
          attr = "AttackPercentage",
          attr_select_index = 15,
          cmp = "<",
          name = "p1",
          trigger = 14
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
      name = "每当经过强化格子后，累加层数，每层提高自身XXX%的攻击力，层数每回合减半"
    }
  },
  name = "纳努赛尔觉醒1",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 1,
      id = 1601151,
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
