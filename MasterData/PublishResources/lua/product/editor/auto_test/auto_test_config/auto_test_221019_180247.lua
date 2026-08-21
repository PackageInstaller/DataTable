AutoTest_221019_180247 = {
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
        action = "AddBuffToEntity",
        args = {buffID = 10150401, name = "e1"}
      },
      [5] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [6] = {
        action = "CheckAttributeChange",
        args = {
          attr = "DefenceConstantFix",
          cmp = "<",
          name = "e1",
          trigger = 14
        }
      },
      [7] = {
        action = "CheckAttributeChange",
        args = {
          attr = "DefenceConstantFix",
          cmp = "<",
          name = "e1",
          trigger = 18
        }
      },
      [8] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 403.0,
            [3] = 303.0,
            [4] = 304.0,
            [5] = 205.0,
            [6] = 306.0
          },
          pieceType = 1
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [11] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 10150401,
          exist = true,
          name = "e1",
          trigger = 0
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "随着血量的降低，自身的防御力越来越高，防御力最高为之前3倍)"
    },
    [2] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "CheckAttributeChange",
        args = {
          attr = "DefenceConstantFix",
          cmp = "<",
          name = "e1",
          trigger = 30
        }
      },
      [3] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 307.0
          }
        }
      },
      [4] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "随着血量的降低，自身的防御力越来越高，防御力最高为之前1.5倍(主动技)"
    }
  },
  name = "101504刚烈IV",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600061,
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
