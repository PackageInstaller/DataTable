AutoTest_220225_142251 = {
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
          dir = 5,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 306
        }
      },
      [4] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [5] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 2,
          layerType = 4101411,
          name = "e1",
          trigger = 88
        }
      },
      [6] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 402.0,
            [3] = 302.0,
            [4] = 303.0,
            [5] = 304.0
          },
          pieceType = 1
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "CheckFormulaAttr",
        args = {
          attr = "damagePercent",
          attr_select_index = 9,
          defname = "e1",
          expect = 0.014999999664724,
          key = "CalcDamage_11",
          key_select_index = 15,
          skillid = 41014111,
          trigger = 102
        }
      },
      [9] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 304.0,
            [2] = 404.0,
            [3] = 504.0,
            [4] = 604.0,
            [5] = 505.0
          },
          pieceType = 1
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "（一只造成2次伤害）连锁技每造成1次伤害，给目标叠加1层印记；印记到达3后立即清空，并造成一次怪物当前生命值XXX%的伤害"
    }
  },
  name = "露比觉醒1",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 1,
      id = 1601411,
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
