AutoTest_220225_154744 = {
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
          pos = 508
        }
      },
      [6] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "e1"}
      },
      [7] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [9] = {
        action = "CheckDoubleChain",
        args = {
          invert = 0.0,
          name = "p1",
          trigger = 89
        }
      },
      [10] = {
        action = "CheckDoubleChain",
        args = {
          invert = 0.0,
          name = "p2",
          trigger = 89
        }
      },
      [11] = {
        action = "CheckFormulaAttr",
        args = {
          attr = "attack",
          attr_select_index = 4,
          defname = "e1",
          expect = 2182.1499023438,
          key = "FinalAtk",
          key_select_index = 3,
          skillid = 2001401,
          trigger = 102
        }
      },
      [12] = {
        action = "CheckFormulaAttr",
        args = {
          attr = "attack",
          attr_select_index = 4,
          defname = "e1",
          expect = 2182.1499023438,
          key = "FinalAtk",
          key_select_index = 3,
          skillid = 2001341,
          trigger = 102
        }
      },
      [13] = {
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
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "主动技强化：以芙罗琳攻击力95%计算。"
    }
  },
  name = "芙罗琳觉醒3",
  petList = {
    [1] = {
      affinity = 0,
      awakening = 0,
      equiplv = 0,
      grade = 3,
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
