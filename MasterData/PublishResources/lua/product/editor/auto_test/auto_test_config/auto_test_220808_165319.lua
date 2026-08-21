AutoTest_220808_165319 = {
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
          id = 102213,
          name = "e1",
          pos = 305
        }
      },
      [4] = {
        action = "CaptureDamageValue",
        args = {
          key = "v1",
          name = "e1",
          trigger = 22
        }
      },
      [5] = {
        action = "FakeCastFeaturePersonaSkill",
        args = {}
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "AddBuffToEntity",
        args = {buffID = 4001581, name = "e1"}
      },
      [8] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [9] = {
        action = "CaptureDamageValue",
        args = {
          key = "v2",
          name = "e1",
          trigger = 22
        }
      },
      [10] = {
        action = "CompareLocalValue",
        args = {
          cmp = "<",
          key1 = "v1",
          key2 = "v2",
          trigger = 22
        }
      },
      [11] = {
        action = "FakeCastFeaturePersonaSkill",
        args = {}
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新测试用例"
    }
  },
  name = "联动技",
  petList = {
    [1] = {
      awakening = 4,
      equiplv = 6,
      grade = 3,
      id = 1501621,
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
