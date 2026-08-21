AutoTest_146 = {
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
          id = 2100213,
          name = "e1",
          pos = 107
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 2100213,
          name = "e2",
          pos = 207
        }
      },
      [5] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 402.0,
            [3] = 403.0,
            [4] = 303.0,
            [5] = 404.0,
            [6] = 304.0
          },
          pieceType = 1
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 304.0,
            [2] = 405.0,
            [3] = 505.0,
            [4] = 605.0,
            [5] = 705.0,
            [6] = 706.0,
            [7] = 606.0,
            [8] = 506.0,
            [9] = 406.0,
            [10] = 306.0,
            [11] = 305.0,
            [12] = 205.0,
            [13] = 204.0
          },
          pieceType = 1
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [9] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [10] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 10042,
          exist = true,
          name = "e2",
          trigger = 88
        }
      },
      [11] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          },
          skillIndex = 1
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [13] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [14] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 204.0,
            [2] = 105.0,
            [3] = 206.0,
            [4] = 307.0,
            [5] = 408.0,
            [6] = 508.0,
            [7] = 608.0,
            [8] = 609.0,
            [9] = 708.0,
            [10] = 607.0,
            [11] = 507.0
          },
          pieceType = 1
        }
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [16] = {
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [17] = {
        action = "CheckBuffLogic",
        args = {
          exist = true,
          logic = "ATBuffBenumb",
          logic_select_index = 25,
          name = "e1",
          trigger = 88
        }
      },
      [18] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 406.0
          },
          skillIndex = 0
        }
      },
      [19] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "拥有至少4层的敌人被减速，至少6层的被麻痹"
    }
  },
  name = "基汀突2主动技强化",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 2,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 3,
      id = 1300461,
      level = 10,
      name = "p1"
    }
  },
  setup = {
    [1] = {
      args = {levelID = 1, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
