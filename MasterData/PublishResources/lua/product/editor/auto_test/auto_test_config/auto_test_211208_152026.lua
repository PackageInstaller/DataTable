AutoTest_211208_152026 = {
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
      name = "新测试用例"
    }
  },
  name = "114击杀任意5个怪胜利",
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
      args = {levelID = 114, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
