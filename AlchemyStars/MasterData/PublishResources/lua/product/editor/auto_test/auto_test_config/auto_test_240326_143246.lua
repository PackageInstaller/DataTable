AutoTest_240326_143246 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetEntityPosition",
        args = {name = "p1", pos = 502}
      },
      [3] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 505.0,
            [2] = 202.0
          },
          skillIndex = 1
        }
      },
      [4] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新测试用例"
    }
  },
  name = "安顿突破6",
  petList = {
    [1] = {
      awakening = 6,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 0,
      id = 1602121,
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
