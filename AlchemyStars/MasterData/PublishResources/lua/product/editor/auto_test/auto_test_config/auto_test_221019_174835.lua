AutoTest_221019_174835 = {
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
          pos = 305
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 504
        }
      },
      [5] = {
        action = "AddBuffToEntity",
        args = {buffID = 10170301, name = "e1"}
      },
      [6] = {
        action = "AddBuffToEntity",
        args = {buffID = 10170302, name = "e1"}
      },
      [7] = {
        action = "AddBuffToEntity",
        args = {buffID = 10170301, name = "e2"}
      },
      [8] = {
        action = "AddBuffToEntity",
        args = {buffID = 10170302, name = "e2"}
      },
      [9] = {
        action = "SetAllMonstersHPPercent",
        args = {percent = 0.5}
      },
      [10] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [12] = {
        action = "CheckUILayerShieldCount",
        args = {
          expect = 5,
          name = "e1",
          trigger = 88
        }
      },
      [13] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "<",
          name = "e1",
          trigger = 88
        }
      },
      [14] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 10170301,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [15] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 10170302,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [16] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e2",
          trigger = 88
        }
      },
      [17] = {
        action = "CheckEntityHP",
        args = {
          compare = "==",
          hp = 2894,
          name = "e1",
          trigger = 88
        }
      },
      [18] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 501.0,
            [3] = 602.0,
            [4] = 603.0,
            [5] = 604.0,
            [6] = 505.0,
            [7] = 404.0
          },
          pieceType = 1
        }
      },
      [19] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [20] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "每回合获得5层次数护盾，如果没有打破护盾则恢复5%血量"
    }
  },
  name = "101703调息III",
  petList = {
    [1] = {
      awakening = 0,
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
