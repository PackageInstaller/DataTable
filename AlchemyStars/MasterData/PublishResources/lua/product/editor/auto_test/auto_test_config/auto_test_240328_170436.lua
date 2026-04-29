AutoTest_240328_170436 = {
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
          pos = 609
        }
      },
      [5] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 1,
          pos = 609,
          trigger = 0
        }
      },
      [6] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 2,
          pos = 609,
          trigger = 88
        }
      },
      [7] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 609.0
          },
          skillIndex = 0
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [9] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 2,
          pos = 608,
          trigger = 88
        }
      },
      [10] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 2,
          pos = 607,
          trigger = 88
        }
      },
      [11] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 2,
          pos = 606,
          trigger = 88
        }
      },
      [12] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 2,
          pos = 605,
          trigger = 88
        }
      },
      [13] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 1,
          pos = 602,
          trigger = 88
        }
      },
      [14] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 1,
          pos = 601,
          trigger = 88
        }
      },
      [15] = {
        action = "FakeCastSkill",
        args = {
          name = "p2",
          pickUpPos = {
            [1] = 502.0
          },
          skillIndex = 0
        }
      },
      [16] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "任选1格转火属性并在该位置留下机关；若点选格上有敌人，则机关附身在怪身上并仍保留其格子的所在位置：连线阶段前，机关途经的格子均转为火属性，回合结束消失。"
    },
    [2] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新测试用例"
    }
  },
  name = "仲胥主动技",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 0,
      id = 1601811,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 0,
      id = 1400811,
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
