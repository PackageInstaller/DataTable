AutoTest_211215_134529 = {
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
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 805,
          trapIds = {
            [1] = 1.6012611E7
          },
          trigger = 88
        }
      },
      [4] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 805.0
          }
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 2100213,
          name = "e1",
          pos = 803
        }
      },
      [7] = {
        action = "CheckFormulaAttr",
        args = {
          attr = "damagePercent",
          attr_select_index = 8,
          defname = "e1",
          expect = 1.0499999523163,
          key = "CalcDamage_5",
          key_select_index = 8,
          skillid = 42012601,
          trigger = 102
        }
      },
      [8] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [9] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 604.0,
            [5] = 704.0
          },
          pieceType = 1
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "连锁技强化：范围内的狗会位移到能接触到敌人的最近位置，并立即攻击一次"
    }
  },
  name = "贝菲尔觉醒3",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1601261,
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
