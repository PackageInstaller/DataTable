AutoTest_221028_132342 = {
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
          pos = 507
        }
      },
      [4] = {
        action = "AddCardByType",
        args = {
          cardTypeList = {
            [1] = 1.0,
            [2] = 2.0,
            [3] = 3.0
          }
        }
      },
      [5] = {
        action = "AddCardByType",
        args = {
          cardTypeList = {
            [1] = 1.0,
            [2] = 2.0,
            [3] = 3.0
          }
        }
      },
      [6] = {
        action = "AddCardByType",
        args = {
          cardTypeList = {
            [1] = 1.0,
            [2] = 2.0,
            [3] = 3.0
          }
        }
      },
      [7] = {
        action = "FakeCastFeatureCardSkill",
        args = {cardCompositionType = 2}
      },
      [8] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "attackConstantFix",
          damageIndex = 1,
          defname = "e1",
          key = "FinalAtk",
          skillid = 100167,
          trigger = 102,
          varname = "v1"
        }
      },
      [9] = {
        action = "CheckLocalValue",
        args = {
          target = 45.680000305176,
          trigger = 102,
          varname = "v1"
        }
      },
      [10] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 505.0,
            [5] = 506.0
          },
          pieceType = 1
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "全相同卡牌 当前队长获得杰诺攻击的8额外攻击力"
    },
    [2] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetPieceType",
        args = {pieceType = 3}
      },
      [3] = {
        action = "AddCardByType",
        args = {
          cardTypeList = {
            [1] = 1.0
          }
        }
      },
      [4] = {
        action = "FakeCastFeatureCardSkill",
        args = {cardCompositionType = 1}
      },
      [5] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "attackConstantFix",
          damageIndex = 1,
          defname = "e1",
          key = "FinalAtk",
          skillid = 100127,
          trigger = 102,
          varname = "v2"
        }
      },
      [6] = {
        action = "CheckLocalValue",
        args = {
          target = 39.970001220703,
          trigger = 102,
          varname = "v2"
        }
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 506.0,
            [2] = 607.0
          },
          pieceType = 3
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "个不相同的卡牌给当队尾的广陵增加7%攻击力"
    }
  },
  name = "杰诺特殊技能",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 0,
      id = 1601671,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 0,
      id = 1300531,
      level = 1,
      name = "p2"
    },
    [3] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 0,
      id = 1300521,
      level = 1,
      name = "p3"
    },
    [4] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 0,
      id = 1400681,
      level = 1,
      name = "p4"
    },
    [5] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 0,
      id = 1401271,
      level = 1,
      name = "p5"
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
