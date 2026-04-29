AutoTest_220225_161404 = {
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
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [4] = {
        action = "SetPieceType",
        args = {pieceType = 4}
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 507
        }
      },
      [6] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "CheckDoubleChain",
        args = {
          invert = 0.0,
          name = "p1",
          trigger = 89
        }
      },
      [9] = {
        action = "CheckDoubleChain",
        args = {
          invert = 0.0,
          name = "p2",
          trigger = 89
        }
      },
      [10] = {
        action = "CheckFormulaAttr",
        args = {
          attr = "attack",
          attr_select_index = 4,
          defname = "e1",
          expect = 381.60000610352,
          key = "FinalAtk",
          key_select_index = 3,
          skillid = 2001401,
          trigger = 102
        }
      },
      [11] = {
        action = "CheckFormulaAttr",
        args = {
          attr = "attack",
          attr_select_index = 4,
          defname = "e1",
          expect = 381.60000610352,
          key = "FinalAtk",
          key_select_index = 3,
          skillid = 2001341,
          trigger = 102
        }
      },
      [12] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 505.0,
            [5] = 506.0
          },
          pieceType = 4
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "使用后本回合水系光灵的连锁技会释放2次，第2次释放时所有水系光灵攻击力为休拉德攻击力的70%。"
    }
  },
  name = "芙罗琳主动技",
  petList = {
    [1] = {
      affinity = 0,
      awakening = 0,
      equiplv = 0,
      grade = 0,
      id = 1601401,
      level = 1,
      name = "p1"
    },
    [2] = {
      affinity = 0,
      awakening = 0,
      equiplv = 0,
      grade = 0,
      id = 1601341,
      level = 1,
      name = "p2"
    }
  },
  setup = {
    [1] = {
      args = {levelID = 1, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
