AutoTest_230518_173417 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 502}
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 305
        }
      },
      [4] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Power",
          expect = 2.0,
          name = "p1",
          trigger = 0
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "进场时cd-2(一次性)"
    }
  },
  name = "雷霆精炼Ⅰ",
  petList = {
    [1] = {
      awakening = 6,
      equipRefineLv = 1,
      equiplv = 10,
      grade = 3,
      id = 1600641,
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
