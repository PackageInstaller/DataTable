AutoTest_230512_134412 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 505}
      },
      [3] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Power",
          expect = 2.0,
          name = "p1",
          trigger = 0
        }
      },
      [4] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "进场时cd-2(一次性)"
    }
  },
  name = "基汀精炼Ⅱ",
  petList = {
    [1] = {
      awakening = 5,
      equipRefineLv = 2,
      equiplv = 10,
      grade = 3,
      id = 1300461,
      level = 80,
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
