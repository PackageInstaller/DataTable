AutoTest_220722_182213 = {
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
        action = "SetEntityHP",
        args = {hp = 2000, name = "team"}
      },
      [4] = {
        action = "CheckEntityHP",
        args = {
          compare = "<",
          hp = 2000,
          name = "p1",
          trigger = 88
        }
      },
      [5] = {
        action = "FakeCastSkill",
        args = {
          name = "p2",
          pickUpPos = {
            [1] = 504.0,
            [2] = 604.0
          }
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "每降低1san值，回复梅XXX%攻击的血量"
    }
  },
  name = "梅觉醒1",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 1,
      id = 1501521,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equiplv = 0,
      grade = 0,
      id = 1601501,
      level = 1,
      name = "p2"
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
