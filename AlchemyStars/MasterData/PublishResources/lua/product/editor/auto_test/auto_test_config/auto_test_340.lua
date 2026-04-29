AutoTest_340 = {
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
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 505
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 607
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 304
        }
      },
      [7] = {
        action = "SetOnePieceType",
        args = {pieceType = 2, pos = 603}
      },
      [8] = {
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 603,
          trigger = 88
        }
      },
      [9] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [10] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e2",
          trigger = 88
        }
      },
      [11] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e3",
          trigger = 88
        }
      },
      [12] = {
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 509,
          trigger = 88
        }
      },
      [13] = {
        action = "SetEntityPosition",
        args = {name = "e2", pos = 609}
      },
      [14] = {
        action = "CheckEntityPos",
        args = {
          name = "e3",
          pos = 304,
          trigger = 88
        }
      },
      [15] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 503.0
          }
        }
      },
      [16] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "1.3列敌人伤害 2.击退敌人 3.重置范围内非火属性格子"
    }
  },
  name = "卡戎主动技",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600251,
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
