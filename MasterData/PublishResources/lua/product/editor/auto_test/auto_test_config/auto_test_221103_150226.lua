AutoTest_221103_150226 = {
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
          id = 5107911,
          name = "e1",
          pos = 305
        }
      },
      [4] = {
        action = "AddBuffToEntity",
        args = {buffID = 88841033, name = "e1"}
      },
      [5] = {
        action = "AddBuffToEntity",
        args = {buffID = 88842033, name = "e1"}
      },
      [6] = {
        action = "SetEntityHPPercent",
        args = {name = "e1", percent = 0.5}
      },
      [7] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "<",
          name = "e1",
          trigger = 88
        }
      },
      [8] = {
        action = "CheckEntityHP",
        args = {
          compare = "==",
          hp = 267264,
          name = "e1",
          trigger = 88
        }
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
        action = "FakeInputDoubleClick",
        args = {}
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [12] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "<",
          name = "e1",
          trigger = 88
        }
      },
      [13] = {
        action = "CheckEntityHP",
        args = {
          compare = "==",
          hp = 311808,
          name = "e1",
          trigger = 88
        }
      },
      [14] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "AttackPercentage",
          expect = 0.10000000149012,
          name = "e1",
          trigger = 88
        }
      },
      [15] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [16] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [17] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Mobility",
          expect = 4.0,
          name = "e1",
          trigger = 88
        }
      },
      [18] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [19] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [20] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [21] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Mobility",
          expect = 6.0,
          name = "e1",
          trigger = 88
        }
      },
      [22] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [23] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [24] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "战狂每回合恢复10%生命值及提高5%攻击力。主动技反制：本回合速度+2（可叠加）。"
    }
  },
  name = "40033战狂嗜血",
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
