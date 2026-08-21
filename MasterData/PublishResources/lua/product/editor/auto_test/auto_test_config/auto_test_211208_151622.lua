AutoTest_211208_151622 = {
  cases = {
    [1] = {
      [1] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [2] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [3] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [4] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [5] = {
        action = "CheckBattleResult",
        args = {trigger = 80, victory = 1}
      },
      [6] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [7] = {
        action = "WaitGameOver",
        args = {}
      },
      name = "3回合结束或杀死所有怪物胜利"
    }
  },
  name = "111秘境盗掘者",
  petList = {
    [1] = {
      awakening = 2,
      equiplv = 1,
      grade = 2,
      id = 1400071,
      level = 10,
      name = "p1"
    }
  },
  remotePet = {},
  setup = {
    [1] = {
      args = {levelID = 111, matchType = 6},
      setup = "LevelBasic"
    }
  }
}
