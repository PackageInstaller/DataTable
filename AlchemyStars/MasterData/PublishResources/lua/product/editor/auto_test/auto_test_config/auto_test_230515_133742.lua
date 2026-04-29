AutoTest_230515_133742 = {
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
          expect = 4.0,
          name = "p1",
          trigger = 0
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "主动技cd-1"
    }
  },
  name = "克娜莉突破Ⅲ",
  petList = {
    [1] = {
      awakening = 3,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 1,
      id = 1600231,
      level = 20,
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
