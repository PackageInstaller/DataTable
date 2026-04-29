AutoTest_230619_154518 = {
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
          disableai = false,
          id = 2905401,
          name = "e1",
          pos = 505
        }
      },
      [4] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [5] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 502.0,
            [2] = 503.0
          },
          skillid = 290540101,
          trigger = 102
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "向光灵移动后，对前方2格范围内目标造成大量伤害"
    }
  },
  name = "约书亚boss",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 0,
      id = 1400071,
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
