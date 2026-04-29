AutoTest_211208_170457 = {
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
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [5] = {
        action = "KillAllMonsters",
        args = {}
      },
      [6] = {
        action = "WaitGameOver",
        args = {}
      },
      name = "杀死夏尔斯叶特等无聊出现杀死无聊胜利"
    }
  },
  name = "118双子boss变无聊",
  petList = {
    [1] = {
      awakening = 3,
      equiplv = 1,
      grade = 3,
      id = 1400451,
      level = 30,
      name = "p1"
    }
  },
  remotePet = {},
  setup = {
    [1] = {
      args = {levelID = 118, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
