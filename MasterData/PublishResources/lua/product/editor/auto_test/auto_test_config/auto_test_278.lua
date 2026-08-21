AutoTest_278 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [3] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 0,
          layerType = 4115,
          name = "p1",
          trigger = 88
        }
      },
      [4] = {
        action = "CheckEntityPos",
        args = {
          name = "p1",
          pos = 507,
          trigger = 88
        }
      },
      [5] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 507.0
          }
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "CastTrapSkill",
        args = {
          pos = 502,
          skillID = 500251,
          trapID = 2241
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [9] = {
        action = "CheckEntityPos",
        args = {
          name = "p1",
          pos = 502,
          trigger = 0
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "1.瞬移到任意位置 2.原地生成1个温蒂之羽 3.点击可返回原地"
    }
  },
  name = "温蒂主动技1",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1400681,
      level = 1,
      name = "p1"
    }
  },
  setup = {
    [1] = {
      args = {levelID = 1, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
