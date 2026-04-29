AutoTest_220928_180315 = {
  cases = {
    [1] = {
      [1] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 509
        }
      },
      [2] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 808
        }
      },
      [3] = {
        action = "CheckTrapCount",
        args = {
          expect = 1,
          trapIDs = {
            [1] = 1.501681E7
          },
          trigger = 0
        }
      },
      [4] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 502}
      },
      [5] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "被动强化：每回合开始时场上随机1个水格子生成印记"
    }
  },
  name = "虹霞突破5",
  petList = {
    [1] = {
      awakening = 5,
      equiplv = 1,
      grade = 1,
      id = 1501681,
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
