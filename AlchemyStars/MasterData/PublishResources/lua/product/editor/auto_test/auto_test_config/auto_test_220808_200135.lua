AutoTest_220808_200135 = {
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
          disableai = false,
          id = 5100111,
          name = "e1",
          pos = 607
        }
      },
      [4] = {
        action = "SetOnePieceType",
        args = {pieceType = 3, pos = 403}
      },
      [5] = {
        action = "SetOnePieceType",
        args = {pieceType = 3, pos = 308}
      },
      [6] = {
        action = "SetOnePieceType",
        args = {pieceType = 3, pos = 804}
      },
      [7] = {
        action = "SetOnePieceType",
        args = {pieceType = 3, pos = 606}
      },
      [8] = {
        action = "SetOnePieceType",
        args = {pieceType = 3, pos = 706}
      },
      [9] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 706,
          trapIds = {
            [1] = 8001651.0
          },
          trigger = 30
        }
      },
      [10] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 606,
          trapIds = {
            [1] = 8001651.0
          },
          trigger = 30
        }
      },
      [11] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 804,
          trapIds = {
            [1] = 8001651.0
          },
          trigger = 88
        }
      },
      [12] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 403,
          trapIds = {
            [1] = 8001651.0
          },
          trigger = 88
        }
      },
      [13] = {
        action = "CheckGridTrap",
        args = {
          exist = false,
          pos = 308,
          trapIds = {
            [1] = 8001651.0
          },
          trigger = 88
        }
      },
      [14] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [16] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_108",
          skillid = 5001651,
          trigger = 102,
          varname = "v1"
        }
      },
      [17] = {
        action = "CheckLocalValue",
        args = {
          target = 0.15000000596046,
          trigger = 88,
          varname = "v1"
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
      name = "主动技强化：在转色的格子上留下钻头机关"
    }
  },
  name = "琪尔觉醒2",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 2,
      id = 1501651,
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
