AutoTest_230518_181713 = {
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
        action = "CheckEntityBuff",
        args = {
          buffId = 4001751,
          exist = true,
          name = "p1",
          trigger = 0
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "初始额外获得2能量"
    }
  },
  name = "阿克西娅突破Ⅲ",
  petList = {
    [1] = {
      awakening = 3,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 3,
      id = 1601751,
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
