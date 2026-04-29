AutoTest_230515_170514 = {
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
          id = 5100111,
          name = "e1",
          pos = 505
        }
      },
      [4] = {
        action = "SetAllMonstersHP",
        args = {value = 100000}
      },
      [5] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 601.0,
            [4] = 702.0,
            [5] = 603.0
          },
          pieceType = 1
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          },
          skillIndex = 1
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [9] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "skillFinalParam",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_1",
          skillid = 100023,
          trigger = 102,
          varname = "v1"
        }
      },
      [10] = {
        action = "CheckLocalValue",
        args = {
          target = 1.1499999761581,
          trigger = 88,
          varname = "v1"
        }
      },
      [11] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "skillFinalParam",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_4",
          skillid = 220231,
          trigger = 102,
          varname = "v2"
        }
      },
      [12] = {
        action = "CheckLocalValue",
        args = {
          target = 1.1499999761581,
          trigger = 88,
          varname = "v2"
        }
      },
      [13] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 603.0,
            [2] = 604.0,
            [3] = 605.0,
            [4] = 606.0,
            [5] = 607.0
          },
          pieceType = 1
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "被动强化：对拥有恐惧的目标造成的所有伤害提高15%"
    }
  },
  name = "克娜莉精炼Ⅱ",
  petList = {
    [1] = {
      awakening = 6,
      equipRefineLv = 2,
      equiplv = 10,
      grade = 3,
      id = 1600231,
      level = 80,
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
