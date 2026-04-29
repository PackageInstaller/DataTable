AutoTest_221209_151149 = {
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
        action = "SetEntityHPPercent",
        args = {name = "team", percent = 0.5}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 607
        }
      },
      [5] = {
        action = "SetAllMonstersHPPercent",
        args = {percent = 0.5}
      },
      [6] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "<",
          name = "team",
          trigger = 88
        }
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 702.0,
            [4] = 802.0,
            [5] = 701.0,
            [6] = 601.0,
            [7] = 501.0,
            [8] = 401.0,
            [9] = 301.0,
            [10] = 402.0,
            [11] = 302.0,
            [12] = 202.0,
            [13] = 203.0,
            [14] = 103.0
          },
          pieceType = 1
        }
      },
      [8] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e1",
          trigger = 88
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [11] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
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
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 20017731,
          trigger = 102,
          varname = "v1"
        }
      },
      [15] = {
        action = "CheckLocalValue",
        args = {
          target = 1.7999999523163,
          trigger = 102,
          varname = "v1"
        }
      },
      [16] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 103.0,
            [2] = 104.0,
            [3] = 204.0,
            [4] = 304.0,
            [5] = 404.0,
            [6] = 504.0,
            [7] = 604.0,
            [8] = 603.0,
            [9] = 703.0,
            [10] = 803.0,
            [11] = 903.0,
            [12] = 904.0,
            [13] = 804.0,
            [14] = 704.0,
            [15] = 805.0,
            [16] = 905.0
          },
          pieceType = 1
        }
      },
      [17] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [18] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "偶像形态：治疗 战斗形态：（chain 15）全屏单体180%伤害"
    }
  },
  name = "歌尔蒂连锁技Ⅲ",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1601771,
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
