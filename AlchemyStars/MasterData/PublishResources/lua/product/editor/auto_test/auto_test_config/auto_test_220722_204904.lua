AutoTest_220722_204904 = {
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
          pos = 504
        }
      },
      [4] = {
        action = "CheckTeamOrder",
        args = {
          index = 2,
          name = "p1",
          trigger = 88
        }
      },
      [5] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "attackConstantFix",
          damageIndex = 1,
          defname = "e1",
          key = "FinalAtk",
          skillid = 100144,
          trigger = 102,
          varname = "v1"
        }
      },
      [6] = {
        action = "CheckLocalValue",
        args = {
          target = 7.7300000190735,
          trigger = 88,
          varname = "v1"
        }
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0
          },
          pieceType = 1
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "任何时候赫柏不在队尾，强制退到队尾（其余光灵进一个身位）;玩家回合,如果队伍中的光灵本回合身位后退过，提高等同于赫伯XXX%的攻击力（效果不叠加）"
    }
  },
  name = "柏乃觉醒1",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 1,
      id = 1501441,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equiplv = 0,
      grade = 0,
      id = 1600061,
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
