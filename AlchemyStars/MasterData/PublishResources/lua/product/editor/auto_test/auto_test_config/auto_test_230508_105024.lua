AutoTest_230508_105024 = {
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
          pos = 508
        }
      },
      [4] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 508.0
          },
          skillIndex = 1
        }
      },
      [5] = {
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 505,
          trigger = 0
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "先制攻击"
    }
  },
  name = "阿纳托利突破Ⅱ",
  petList = {
    [1] = {
      awakening = 3,
      equiplv = 1,
      grade = 3,
      id = 1502001,
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
