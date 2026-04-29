AutoTest_220628_112301 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 504}
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
          name = "e2",
          pos = 403
        }
      },
      [5] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e2",
          trigger = 88
        }
      },
      [6] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 2,
          pos = 505,
          trigger = 88
        }
      },
      [7] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 2,
          pos = 602,
          trigger = 88
        }
      },
      [8] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 2,
          pos = 706,
          trigger = 88
        }
      },
      [9] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "周围两圈格子边界形成结界，施放时以及回合结束时区域内随机3个非火属性格子转为火属性，然后所有火属性格子净化，结界持续2回合"
    }
  },
  name = "凛音主动技",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1601431,
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
