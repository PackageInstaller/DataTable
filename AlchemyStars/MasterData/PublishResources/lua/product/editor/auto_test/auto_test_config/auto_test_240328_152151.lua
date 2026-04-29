AutoTest_240328_152151 = {
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
        action = "SetPieceType",
        args = {pieceType = 3}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 504
        }
      },
      [5] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 2803501,
          name = "g1",
          pos = 605
        }
      },
      [6] = {
        action = "SetAllMonstersHP",
        args = {value = 99999}
      },
      [7] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 1,
          layerType = 20022,
          name = "e1",
          trigger = 88
        }
      },
      [8] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0,
            [2] = 505.0
          },
          skillIndex = 1
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "damagePercent",
          damageIndex = 1,
          defname = "e1",
          key = "CalcDamage_149",
          skillid = 4262151,
          trigger = 102,
          varname = "v1"
        }
      },
      [11] = {
        action = "CheckLocalValue",
        args = {
          target = 1.5,
          trigger = 102,
          varname = "v1"
        }
      },
      [12] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 605.0
          },
          pieceType = 3
        }
      },
      [13] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 4,
          layerType = 20022,
          name = "e1",
          trigger = 88
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "精炼2：如果队伍里有丽蓓卡（至少觉1），每次装备技（觉2）额外伤害可以挂丽蓓卡的层"
    }
  },
  name = "伊莎精炼2",
  petList = {
    [1] = {
      awakening = 5,
      equipRefineLv = 2,
      equiplv = 10,
      grade = 3,
      id = 1502151,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 1,
      id = 1602141,
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
