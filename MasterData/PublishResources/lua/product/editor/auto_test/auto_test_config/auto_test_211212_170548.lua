AutoTest_211212_170548 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPosition",
        args = {pos = 502}
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
          pos = 304
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 307
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 504
        }
      },
      [7] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [8] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e2",
          trigger = 88
        }
      },
      [9] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e3",
          trigger = 88
        }
      },
      [10] = {
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 308,
          trigger = 88
        }
      },
      [11] = {
        action = "CheckEntityPos",
        args = {
          name = "e2",
          pos = 309,
          trigger = 88
        }
      },
      [12] = {
        action = "CheckEntityPos",
        args = {
          name = "e3",
          pos = 504,
          trigger = 88
        }
      },
      [13] = {
        action = "CheckPieceType",
        args = {
          pieceType = 3,
          pos = 302,
          trigger = 88
        }
      },
      [14] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 3,
          pos = 303,
          trigger = 88
        }
      },
      [15] = {
        action = "CheckPieceType",
        args = {
          pieceType = 3,
          pos = 304,
          trigger = 88
        }
      },
      [16] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 3,
          pos = 305,
          trigger = 88
        }
      },
      [17] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 3,
          pos = 306,
          trigger = 88
        }
      },
      [18] = {
        action = "CheckPieceType",
        args = {
          pieceType = 3,
          pos = 307,
          trigger = 88
        }
      },
      [19] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 301.0
          }
        }
      },
      [20] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "瞬移到指定位置，对纵向1列造成{1}%攻击力的伤害并击退敌人。同时将攻击范围的格子转为森属性。（主动技会被阻挡）"
    }
  },
  name = "海蒂主动技",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1601201,
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
