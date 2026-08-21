AutoTest_221103_150233 = {
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
          pos = 507
        }
      },
      [4] = {
        action = "AddBuffToEntity",
        args = {buffID = 88841031, name = "e1"}
      },
      [5] = {
        action = "AddBuffToEntity",
        args = {buffID = 88842031, name = "e1"}
      },
      [6] = {
        action = "AddBuffToEntity",
        args = {buffID = 88843031, name = "e1"}
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
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e1",
          trigger = 88
        }
      },
      [10] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "AttackPercentage",
          expect = 0.050000000745058,
          name = "e1",
          trigger = 88
        }
      },
      [11] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 88841031,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [12] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Mobility",
          expect = 3.0,
          name = "e1",
          trigger = 88
        }
      },
      [13] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [14] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [16] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 88841031,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [17] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "AttackPercentage",
          expect = 0.10000000149012,
          name = "e1",
          trigger = 88
        }
      },
      [18] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e1",
          trigger = 88
        }
      },
      [19] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Mobility",
          expect = 4.0,
          name = "e1",
          trigger = 88
        }
      },
      [20] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 505.0,
            [5] = 606.0
          },
          pieceType = 1
        }
      },
      [21] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [22] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "怪物免疫连锁技和主动技伤害，每回合提升5%攻击和1点行动力（可叠加）。"
    }
  },
  name = "40031灭法叱喝",
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
