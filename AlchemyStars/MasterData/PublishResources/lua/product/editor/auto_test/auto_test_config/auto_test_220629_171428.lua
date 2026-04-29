AutoTest_220629_171428 = {
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
        action = "ChangeTeamLeader",
        args = {index = 2}
      },
      [5] = {
        action = "CheckTeamOrder",
        args = {
          index = 1,
          name = "p2",
          trigger = 88
        }
      },
      [6] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 2,
          pos = 503,
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
      name = "被动强化：若生命值已满，将最近的1个水属性格子转为火属性格子"
    }
  },
  name = "凛音觉醒2",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 0,
      grade = 0,
      id = 1500711,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equiplv = 1,
      grade = 2,
      id = 1601431,
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
