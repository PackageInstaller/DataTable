AutoTest_240416_164520 = {
  cases = {
    [1] = {
      [1] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "team"}
      },
      [2] = {
        action = "AddMonster",
        args = {
          dir = 5,
          disableai = false,
          id = 536203111,
          name = "e1",
          pos = 407
        }
      },
      [3] = {
        action = "CheckEntityBodyAreaCount",
        args = {
          expect = 6,
          name = "e1",
          trigger = 88
        }
      },
      [4] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 702.0,
            [4] = 802.0,
            [5] = 701.0,
            [6] = 601.0,
            [7] = 501.0,
            [8] = 401.0,
            [9] = 301.0,
            [10] = 402.0,
            [11] = 302.0,
            [12] = 202.0,
            [13] = 103.0,
            [14] = 203.0,
            [15] = 303.0,
            [16] = 403.0,
            [17] = 503.0,
            [18] = 603.0,
            [19] = 703.0,
            [20] = 803.0,
            [21] = 903.0,
            [22] = 804.0,
            [23] = 704.0,
            [24] = 604.0,
            [25] = 504.0,
            [26] = 404.0,
            [27] = 304.0,
            [28] = 204.0,
            [29] = 305.0,
            [30] = 405.0,
            [31] = 505.0,
            [32] = 605.0,
            [33] = 705.0,
            [34] = 606.0,
            [35] = 506.0,
            [36] = 406.0
          },
          skillid = 290580101,
          trigger = 102
        }
      },
      [5] = {
        action = "CheckEntityPos",
        args = {
          name = "p1",
          pos = 501,
          trigger = 88
        }
      },
      [6] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "Boss对前方扇形范围内的目标进行攻击并造成伤害，同时将目标击退到最远。"
    },
    [2] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 505.0
          },
          skillIndex = 1
        }
      },
      [3] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [4] = {
        action = "CheckFormulaAttr",
        args = {
          attr = "damagePercent",
          defname = "team",
          expect = 1.0,
          key = "CalcDamage_2",
          skillid = 290580102,
          trigger = 102
        }
      },
      [5] = {
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 206,
          trigger = 88
        }
      },
      [6] = {
        action = "CheckEntityPos",
        args = {
          name = "p1",
          pos = 703,
          trigger = 88
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
      name = "Boss传送至关卡内固定位置，之后对玩家造成必中伤害，同时击退2格。"
    },
    [3] = {
      [1] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [2] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 505.0
          },
          skillIndex = 1
        }
      },
      [3] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [4] = {
        action = "CheckFormulaAttr",
        args = {
          attr = "skillIncreaseParam",
          defname = "team",
          expect = 1.0,
          key = "CalcDamage_2",
          skillid = 290580103,
          trigger = 102
        }
      },
      [5] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 501.0,
            [2] = 502.0,
            [3] = 503.0,
            [4] = 504.0,
            [5] = 505.0,
            [6] = 601.0,
            [7] = 602.0,
            [8] = 603.0,
            [9] = 604.0,
            [10] = 605.0,
            [11] = 701.0,
            [12] = 702.0,
            [13] = 703.0,
            [14] = 704.0,
            [15] = 704.0,
            [16] = 705.0,
            [17] = 705.0,
            [18] = 802.0,
            [19] = 803.0,
            [20] = 803.0,
            [21] = 804.0,
            [22] = 804.0,
            [23] = 805.0,
            [24] = 805.0,
            [25] = 903.0,
            [26] = 904.0,
            [27] = 905.0
          },
          skillid = 290580103,
          trigger = 102
        }
      },
      [6] = {
        action = "CheckEntityPos",
        args = {
          name = "p1",
          pos = 802,
          trigger = 88
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
      name = "￭ Boss对场上区域的5*5范围造成伤害，范围中心会尽量靠近玩家回合开始时所在位置。（同世界boss麦格芬地火技能逻辑） ￭ 将玩家击退3格。"
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
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 507.0
          },
          skillIndex = 1
        }
      },
      [4] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [5] = {
        action = "CheckFormulaAttr",
        args = {
          attr = "damagePercent",
          defname = "team",
          expect = 2.0,
          key = "CalcDamage_2",
          skillid = 290580104,
          trigger = 102
        }
      },
      [6] = {
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 407,
          trigger = 88
        }
      },
      [7] = {
        action = "CheckEntityPos",
        args = {
          name = "p1",
          pos = 504,
          trigger = 88
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
      name = "￭ 玩家回合开始时在原地进行蓄力准备，玩家使用位移或击退可以打断其施法，打断后本回合空过，否则对玩家造成必中的高额伤害。 ￭ 无论是否成功施放技能，回合结束时瞬移到(5,7)位置。"
    },
    [5] = {
      [1] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 702.0,
            [4] = 802.0,
            [5] = 701.0,
            [6] = 601.0,
            [7] = 501.0,
            [8] = 401.0,
            [9] = 301.0,
            [10] = 402.0,
            [11] = 302.0,
            [12] = 202.0,
            [13] = 103.0,
            [14] = 203.0,
            [15] = 303.0,
            [16] = 403.0,
            [17] = 503.0,
            [18] = 603.0,
            [19] = 703.0,
            [20] = 803.0,
            [21] = 903.0,
            [22] = 804.0,
            [23] = 704.0,
            [24] = 604.0,
            [25] = 504.0,
            [26] = 404.0,
            [27] = 304.0,
            [28] = 204.0,
            [29] = 305.0,
            [30] = 405.0,
            [31] = 505.0,
            [32] = 605.0,
            [33] = 705.0,
            [34] = 606.0,
            [35] = 506.0,
            [36] = 406.0
          },
          skillid = 290580101,
          trigger = 102
        }
      },
      [2] = {
        action = "CheckEntityPos",
        args = {
          name = "p1",
          pos = 501,
          trigger = 88
        }
      },
      [3] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [4] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "技能循环检查，释放技能1"
    }
  },
  name = "终焉帝",
  petList = {
    [1] = {
      awakening = 6,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 3,
      id = 1600061,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 5,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 3,
      id = 1500331,
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
