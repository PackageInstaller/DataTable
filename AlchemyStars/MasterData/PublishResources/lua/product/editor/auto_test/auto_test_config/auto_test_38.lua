AutoTest_38 = {
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
        args = {name = "team"}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 405
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 504
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 605
        }
      },
      [7] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e4",
          pos = 607
        }
      },
      [8] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "e1"}
      },
      [9] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "e2"}
      },
      [10] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "e3"}
      },
      [11] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "e4"}
      },
      [12] = {
        action = "SetOnePieceType",
        args = {pieceType = 3, pos = 405}
      },
      [13] = {
        action = "SetOnePieceType",
        args = {pieceType = 2, pos = 504}
      },
      [14] = {
        action = "SetOnePieceType",
        args = {pieceType = 4, pos = 607}
      },
      [15] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 10011,
          exist = true,
          name = "e2",
          trigger = 30
        }
      },
      [16] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 10011,
          exist = false,
          name = "e1",
          trigger = 30
        }
      },
      [17] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 10011,
          exist = false,
          name = "e3",
          trigger = 30
        }
      },
      [18] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 10011,
          exist = false,
          name = "e4",
          trigger = 30
        }
      },
      [19] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          },
          skillIndex = 0
        }
      },
      [20] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "对全体敌人造成伤害，必定眩晕位于火属性格子上的敌人"
    }
  },
  name = "芭芭拉主动技眩晕",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 0,
      id = 1500901,
      level = 1,
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
