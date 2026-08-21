AutoTest_221020_175436 = {
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
        args = {buffID = 10340301, name = "e1"}
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
          buffId = 10340301,
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
          buffId = 10340301,
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
          buffId = 10340301,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [17] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [18] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 606}
      },
      [19] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 10340301,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [20] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [21] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [22] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 10340301,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [23] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [24] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [25] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 10340301,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [26] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [27] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [28] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 10340301,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [29] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [30] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [31] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 10340301,
          exist = false,
          name = "e1",
          trigger = 88
        }
      },
      [32] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [33] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "出生携带5层减伤效果，受到任何伤害均对最终伤害减免，每回合减少1层减伤效果（每层减伤0.07）"
    }
  },
  name = "103403 护佑II",
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
