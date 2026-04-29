AutoTest_240416_163933 = {
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
        action = "SetEntityHP",
        args = {hp = 100000, name = "team"}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 102004103,
          name = "e1",
          pos = 606
        }
      },
      [5] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "team",
          trigger = 88
        }
      },
      [6] = {
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 604,
          trigger = 88
        }
      },
      [7] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 402.0,
            [2] = 403.0,
            [3] = 404.0,
            [4] = 405.0,
            [5] = 406.0,
            [6] = 502.0,
            [7] = 503.0,
            [8] = 504.0,
            [9] = 505.0,
            [10] = 506.0,
            [11] = 602.0,
            [12] = 603.0,
            [13] = 605.0,
            [14] = 606.0,
            [15] = 702.0,
            [16] = 703.0,
            [17] = 704.0,
            [18] = 705.0,
            [19] = 706.0,
            [20] = 802.0,
            [21] = 803.0,
            [22] = 804.0,
            [23] = 805.0,
            [24] = 806.0
          },
          skillid = 200460103,
          trigger = 102
        }
      },
      [8] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "武装突袭 十字移动2格，然后攻击2圈内的目标"
    },
    [2] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [3] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 506.0
          },
          skillIndex = 1
        }
      },
      [4] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [5] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "team",
          trigger = 88
        }
      },
      [6] = {
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
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "被动1受到普攻伤害时反击"
    },
    [3] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 102003102,
          name = "e2",
          pos = 509
        }
      },
      [3] = {
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 503,
          trigger = 88
        }
      },
      [4] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "team",
          trigger = 88
        }
      },
      [5] = {
        action = "CheckUILayerShieldCount",
        args = {
          expect = 2,
          name = "e2",
          trigger = 88
        }
      },
      [6] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 503.0,
            [2] = 504.0,
            [3] = 505.0,
            [4] = 506.0,
            [5] = 507.0,
            [6] = 508.0,
            [7] = 509.0
          },
          skillid = 200460104,
          trigger = 102
        }
      },
      [7] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "全灭打击 远离队伍移动，然后攻击一条直线上敌我双方目标"
    },
    [4] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [3] = {
        action = "SetEntityAttack",
        args = {attack = 1000, name = "p1"}
      },
      [4] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
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
          },
          skillIndex = 1
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "被动2每回合开始时恢复血量"
    }
  },
  name = "超级兵·梅奥姆",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 0,
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
