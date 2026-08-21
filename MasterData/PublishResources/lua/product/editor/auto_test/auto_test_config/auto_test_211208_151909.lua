AutoTest_211208_151909 = {
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
        action = "FakeClickAutoFight",
        args = {}
      },
      [4] = {
        action = "WaitGameOver",
        args = {}
      },
      name = "秘境宝箱关"
    }
  },
  name = "112宝箱关",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1601291,
      level = 1,
      name = "p1"
    }
  },
  remotePet = {},
  setup = {
    [1] = {
      args = {levelID = 112, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
