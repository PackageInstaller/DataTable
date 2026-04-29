AutoTest_221103_150153 = {
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
          pos = 503
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 602
        }
      },
      [6] = {
        action = "AddBuffToEntity",
        args = {buffID = 88841047, name = "e1"}
      },
      [7] = {
        action = "AddBuffToEntity",
        args = {buffID = 88842047, name = "p1"}
      },
      [8] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [9] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "AttackPercentage",
          expect = 0.050000000745058,
          name = "e1",
          trigger = 88
        }
      },
      [10] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "AttackPercentage",
          expect = 0.10000000149012,
          name = "p1",
          trigger = 88
        }
      },
      [11] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [13] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "AttackPercentage",
          expect = 0.10000000149012,
          name = "e1",
          trigger = 88
        }
      },
      [14] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "AttackPercentage",
          expect = 0.20000000298023,
          name = "p1",
          trigger = 88
        }
      },
      [15] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 601.0,
            [3] = 702.0,
            [4] = 603.0
          },
          pieceType = 1
        }
      },
      [16] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "每当场上有怪物死亡，其他怪物增加5%攻击力，光灵增加10%攻击力。"
    }
  },
  name = "40047绝望激斗",
  petList = {
    [1] = {
      awakening = 6,
      equiplv = 10,
      grade = 3,
      id = 1600061,
      level = 80,
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
