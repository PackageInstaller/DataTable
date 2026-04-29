AutoTest_220222_142338 = {
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
          pos = 509
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
        action = "CheckFormulaAttr",
        args = {
          attr = "damagePercent",
          attr_select_index = 9,
          defname = "e1",
          expect = 0.64999997615814,
          key = "CalcDamage_4",
          key_select_index = 8,
          skillid = 2001331,
          trigger = 102
        }
      },
      [6] = {
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
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "造成2次{1}%的伤害。随机分配到自身周围3圈内的敌人身上。对同一目标造成多次伤害时，从第2次起每次伤害减半。"
    }
  },
  name = "托尔连锁技",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1601331,
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
