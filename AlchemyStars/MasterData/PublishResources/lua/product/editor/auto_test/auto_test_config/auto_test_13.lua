AutoTest_13 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPowerFull",
        args = {}
      },
      [3] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 502}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 504
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 604
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 704
        }
      },
      [7] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 0,
          layerType = 2001,
          name = "e1",
          trigger = 30
        }
      },
      [8] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 1,
          layerType = 2001,
          name = "e2",
          trigger = 30
        }
      },
      [9] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 2,
          layerType = 2001,
          name = "e3",
          trigger = 30
        }
      },
      [10] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 603.0
          }
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "八方向任选一方向，首个命中的敌人2层及其周围一圈的敌人1层灼烧"
    }
  },
  name = "鳄鱼主动技附加灼烧",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 2,
      id = 1300511,
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
