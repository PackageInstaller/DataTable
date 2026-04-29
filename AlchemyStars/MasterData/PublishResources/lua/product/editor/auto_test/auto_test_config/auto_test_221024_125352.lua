AutoTest_221024_125352 = {
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
          pos = 505
        }
      },
      [4] = {
        action = "AddBuffToEntity",
        args = {buffID = 10460201, name = "e1"}
      },
      [5] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "FinalBehitByTeamLeaderDamageParam",
          expect = 1.0,
          name = "e1",
          trigger = 88
        }
      },
      [6] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "FinalBehitByTeamMemberDamageParam",
          expect = 0.40000000596046,
          name = "e1",
          trigger = 88
        }
      },
      [7] = {
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
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "受到来自队员位光灵的伤害降低60%(普攻+连锁)"
    },
    [2] = {
      [1] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "FinalBehitByTeamMemberDamageParam",
          expect = 0.40000000596046,
          name = "e1",
          trigger = 88
        }
      },
      [2] = {
        action = "FakeCastSkill",
        args = {
          name = "p2",
          pickUpPos = {
            [1] = 505.0
          }
        }
      },
      [3] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [4] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "FinalBehitByTeamLeaderDamageParam",
          expect = 1.0,
          name = "e1",
          trigger = 88
        }
      },
      [5] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "受到来自队员位光灵的伤害降低60%(主动技)"
    }
  },
  name = "104602畏缩II",
  petList = {
    [1] = {
      awakening = 6,
      equiplv = 0,
      grade = 0,
      id = 1600061,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 4,
      equiplv = 0,
      grade = 0,
      id = 1600041,
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
