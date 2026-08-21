AutoTest_211209_145337 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetEntityHPPercent",
        args = {name = "team", percent = 0.40000000596046}
      },
      [3] = {
        action = "Check3StarComplete",
        args = {
          conditionParam = "50",
          conditionType = 1,
          expect = false,
          trigger = 80
        }
      },
      [4] = {
        action = "KillAllMonsters",
        args = {}
      },
      [5] = {
        action = "WaitGameOver",
        args = {}
      },
      name = "新测试用例"
    }
  },
  name = "02血量不低于50%",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600191,
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
