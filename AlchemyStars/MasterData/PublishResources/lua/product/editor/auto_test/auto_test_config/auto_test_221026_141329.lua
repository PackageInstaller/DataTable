AutoTest_221026_141329 = {
  cases = {
    [1] = {
      [1] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 502}
      },
      [2] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 10110512,
          name = "e1",
          pos = 605
        }
      },
      [3] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [4] = {
        action = "CheckMonsterCount",
        args = {
          count = 1,
          monsterid = 2000312,
          trigger = 88
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [6] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [7] = {
        action = "CheckMonsterCount",
        args = {
          count = 2,
          monsterid = 2000312,
          trigger = 88
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "母巢会召唤更加强力的双刀进入战场。"
    }
  },
  name = "106009强力呼唤II",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1600061,
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
