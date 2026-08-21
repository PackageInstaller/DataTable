AutoTest_220722_212503 = {
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
          index = 5,
          name = "p2",
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
          skillid = 100006,
          trigger = 102,
          varname = "v1"
        }
      },
      [6] = {
        action = "CheckLocalValue",
        args = {
          target = 41.580001831055,
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
      name = "被动强化：身位后退的越多，效果越强，最大2.5倍（从队长位换到队尾）"
    }
  },
  name = "柏乃觉醒3",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 0,
      grade = 0,
      id = 1600061,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1501441,
      level = 1,
      name = "p2"
    },
    [3] = {
      awakening = 0,
      equiplv = 0,
      grade = 0,
      id = 1300461,
      level = 1,
      name = "p3"
    },
    [4] = {
      awakening = 0,
      equiplv = 0,
      grade = 0,
      id = 1201631,
      level = 1,
      name = "p4"
    },
    [5] = {
      awakening = 0,
      equiplv = 0,
      grade = 0,
      id = 1300651,
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
