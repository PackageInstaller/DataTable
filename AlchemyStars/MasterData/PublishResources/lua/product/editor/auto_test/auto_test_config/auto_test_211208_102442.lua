AutoTest_211208_102442 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetAllMonstersHP",
        args = {value = 1000}
      },
      [3] = {
        action = "CheckBattleResult",
        args = {trigger = 80, victory = 1}
      },
      [4] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [5] = {
        action = "WaitGameOver",
        args = {}
      },
      name = "杀死两个boss"
    }
  },
  name = "105双子boss",
  petList = {
    [1] = {
      awakening = 3,
      equiplv = 1,
      grade = 3,
      id = 1600051,
      level = 80,
      name = "p1"
    }
  },
  remotePet = {},
  setup = {
    [1] = {
      args = {levelID = 105, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
