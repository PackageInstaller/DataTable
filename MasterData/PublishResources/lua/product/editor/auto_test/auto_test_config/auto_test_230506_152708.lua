AutoTest_230506_152708 = {
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
          id = 2051313,
          name = "e1",
          pos = 506
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 2051313,
          name = "e2",
          pos = 204
        }
      },
      [5] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "skillFinalParam",
          damageIndex = 1,
          defname = "e2",
          key = "CalcDamage_4",
          skillid = 2201992,
          trigger = 102,
          varname = "v1"
        }
      },
      [6] = {
        action = "CheckLocalValue",
        args = {
          target = 1.0599999427795,
          trigger = 88,
          varname = "v1"
        }
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 404.0,
            [4] = 505.0,
            [5] = 405.0,
            [6] = 406.0,
            [7] = 407.0,
            [8] = 508.0,
            [9] = 509.0
          },
          pieceType = 1
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [9] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [10] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "noDefence",
          damageIndex = 1,
          defname = "e1",
          key = "BaseDamage",
          skillid = 2201992,
          trigger = 102,
          varname = "v1"
        }
      },
      [11] = {
        action = "CheckLocalValue",
        args = {
          target = 0.15000000596046,
          trigger = 102,
          varname = "v1"
        }
      },
      [12] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 509.0,
            [2] = 508.0,
            [3] = 608.0,
            [4] = 707.0,
            [5] = 706.0,
            [6] = 605.0,
            [7] = 505.0,
            [8] = 406.0,
            [9] = 407.0
          },
          pieceType = 1
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "莺歌造成伤害时,目标身上每有一层标记就无视其3%的防御力（最高60%）"
    }
  },
  name = "莺歌觉醒Ⅲ",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1601991,
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
