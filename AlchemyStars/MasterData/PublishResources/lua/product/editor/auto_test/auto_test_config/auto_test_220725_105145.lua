AutoTest_220725_105145 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "CheckBattleResult",
        args = {trigger = 80, victory = 1}
      },
      [3] = {
        action = "KillAllMonsters",
        args = {}
      },
      [4] = {
        action = "WaitGameOver",
        args = {}
      },
      name = "完成关卡，没有额外条件"
    }
  },
  name = "0完成关卡",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
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
