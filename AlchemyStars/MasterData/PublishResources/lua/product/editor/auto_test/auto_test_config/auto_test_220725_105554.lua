AutoTest_220725_105554 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetEntityHPPercent",
        args = {name = "team", percent = 0.5}
      },
      [3] = {
        action = "CheckBattleResult",
        args = {trigger = 80, victory = 1}
      },
      [4] = {
        action = "KillAllMonsters",
        args = {}
      },
      [5] = {
        action = "WaitGameOver",
        args = {}
      },
      name = "血量检测"
    }
  },
  name = "1血量检查胜利",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1601171,
      level = 1,
      name = "p1"
    }
  },
  remotePet = {},
  setup = {
    [1] = {
      args = {levelID = 101, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
