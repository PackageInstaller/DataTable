AutoTest_221110_184308 = {
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
        args = {hp = 999999, name = "team"}
      },
      [4] = {
        action = "SetEntityAttack",
        args = {attack = 111111, name = "p1"}
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 2903401,
          name = "e1",
          pos = 308
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 2903402,
          name = "e2",
          pos = 706
        }
      },
      [7] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 507,
          trapIds = {
            [1] = 78.0
          },
          trigger = 88
        }
      },
      [8] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 508,
          trapIds = {
            [1] = 78.0
          },
          trigger = 88
        }
      },
      [9] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 509,
          trapIds = {
            [1] = 78.0
          },
          trigger = 88
        }
      },
      [10] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 605,
          trapIds = {
            [1] = 78.0
          },
          trigger = 88
        }
      },
      [11] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 606,
          trapIds = {
            [1] = 78.0
          },
          trigger = 88
        }
      },
      [12] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 607,
          trapIds = {
            [1] = 78.0
          },
          trigger = 88
        }
      },
      [13] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 29034011,
          exist = true,
          name = "e1",
          trigger = 102
        }
      },
      [14] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 103.0,
            [2] = 104.0,
            [3] = 105.0,
            [4] = 106.0,
            [5] = 107.0,
            [6] = 202.0,
            [7] = 203.0,
            [8] = 204.0,
            [9] = 205.0,
            [10] = 206.0,
            [11] = 207.0,
            [12] = 208.0,
            [13] = 301.0,
            [14] = 302.0,
            [15] = 303.0,
            [16] = 304.0,
            [17] = 305.0,
            [18] = 306.0,
            [19] = 307.0,
            [20] = 308.0,
            [21] = 309.0,
            [22] = 401.0,
            [23] = 402.0,
            [24] = 403.0,
            [25] = 404.0,
            [26] = 405.0,
            [27] = 406.0,
            [28] = 407.0,
            [29] = 408.0,
            [30] = 409.0,
            [31] = 501.0,
            [32] = 502.0,
            [33] = 503.0,
            [34] = 504.0,
            [35] = 505.0,
            [36] = 506.0,
            [37] = 507.0,
            [38] = 508.0,
            [39] = 509.0,
            [40] = 601.0,
            [41] = 602.0,
            [42] = 603.0,
            [43] = 604.0,
            [44] = 605.0,
            [45] = 606.0,
            [46] = 607.0,
            [47] = 608.0,
            [48] = 609.0,
            [49] = 701.0,
            [50] = 702.0,
            [51] = 703.0,
            [52] = 704.0,
            [53] = 705.0,
            [54] = 706.0,
            [55] = 707.0,
            [56] = 708.0,
            [57] = 709.0,
            [58] = 802.0,
            [59] = 803.0,
            [60] = 804.0,
            [61] = 805.0,
            [62] = 806.0,
            [63] = 807.0,
            [64] = 808.0,
            [65] = 903.0,
            [66] = 904.0,
            [67] = 905.0,
            [68] = 906.0,
            [69] = 907.0
          },
          skillid = 290340201,
          trigger = 102
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
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 402.0,
            [2] = 501.0,
            [3] = 503.0,
            [4] = 602.0
          },
          skillid = 290340101,
          trigger = 102
        }
      },
      [18] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [19] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [20] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "team",
          trigger = 88
        }
      },
      [21] = {
        action = "SetOnePieceType",
        args = {pieceType = 1, pos = 502}
      },
      [22] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [23] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e2",
          trigger = 88
        }
      },
      [24] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 501.0
          },
          pieceType = 1
        }
      },
      [25] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "被动技能1-共生链接  1.两个boss间的共生链子效果，伤害与血量回复传导的逻辑 2.怪物回合结束后，两个boss间的连线上生成黑格子机关的技能范围"
    }
  },
  name = "14-14梦底斯",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 0,
      id = 1500761,
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
