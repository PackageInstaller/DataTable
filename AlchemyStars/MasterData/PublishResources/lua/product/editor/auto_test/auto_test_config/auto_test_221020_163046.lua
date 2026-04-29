AutoTest_221020_163046 = {
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
        action = "AddBuffToEntity",
        args = {buffID = 10340101, name = "e1"}
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [6] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 301.0,
            [2] = 302.0
          },
          pieceType = 1
        }
      },
      [7] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 10340101,
          exist = true,
          name = "e1",
          trigger = 0
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [9] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [10] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 503.0
          }
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [12] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 302.0,
            [2] = 303.0,
            [3] = 304.0,
            [4] = 405.0,
            [5] = 505.0
          },
          pieceType = 1
        }
      },
      [13] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 10340101,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [15] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 505.0,
            [2] = 504.0
          },
          pieceType = 1
        }
      },
      [16] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 10340101,
          exist = false,
          name = "e1",
          trigger = 88
        }
      },
      [17] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "出生携带3层减伤效果，受到任何伤害均对最终伤害减免，每回合减少1层减伤效果（每层减伤0.1）"
    }
  },
  name = "103401 护佑I",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1500331,
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
