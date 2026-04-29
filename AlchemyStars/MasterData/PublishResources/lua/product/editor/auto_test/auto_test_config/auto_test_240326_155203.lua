AutoTest_240326_155203 = {
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
        action = "CheckPetActiveSkillCanCast",
        args = {
          expect = true,
          name = "p1",
          skillID = 3001871,
          trigger = 0
        }
      },
      [4] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "先制攻击"
    }
  },
  name = "李天闲突破2",
  petList = {
    [1] = {
      awakening = 2,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 0,
      id = 1501871,
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
