AutoTest_222 = {
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
        args = {name = "team", name_select_index = 0}
      },
      [4] = {
        action = "SetPieceType",
        args = {pieceType = 3}
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 605
        }
      },
      [6] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "e1"}
      },
      [7] = {
        action = "SetOnePieceType",
        args = {pieceType = 1, pos = 403}
      },
      [8] = {
        action = "SetOnePieceType",
        args = {pieceType = 1, pos = 601}
      },
      [9] = {
        action = "CheckFormulaAttr",
        args = {
          attr = "skillIncreaseParam",
          attr_select_index = 9,
          defname = "e1",
          expect = 1.1200000047684,
          key = "CalcDamage_5",
          key_select_index = 8,
          skillid = 300033,
          trigger = 102
        }
      },
      [10] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          },
          skillIndex = 0
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [12] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 0,
          layerType = 4022,
          name = "p1",
          trigger = 9
        }
      },
      [13] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0
          },
          pieceType = 0
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "薇丝每次造成伤害都会获得1层瞄定印记，每层印记增加2%的伤害，回合结束后印记清空。攻击7下，最终提升1.12 。"
    }
  },
  name = "薇丝被动技：瞄定印记",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 10,
      grade = 1,
      id = 1500331,
      level = 10,
      name = "p1"
    }
  },
  setup = {
    [1] = {
      args = {levelID = 1, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
