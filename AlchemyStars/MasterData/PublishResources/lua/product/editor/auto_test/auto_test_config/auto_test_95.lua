AutoTest_95 = {
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
          pos = 103
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 304
        }
      },
      [5] = {
        action = "SetEntityHPPercent",
        args = {name = "e1", percent = 0.5}
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 307
        }
      },
      [7] = {
        action = "SetEntityHPPercent",
        args = {name = "e2", percent = 0.69999998807907}
      },
      [8] = {
        action = "SetEntityHPPercent",
        args = {name = "e3", percent = 1.0}
      },
      [9] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 41007110,
          exist = false,
          name = "e1",
          trigger = 9
        }
      },
      [10] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 41007110,
          exist = false,
          name = "e2",
          trigger = 9
        }
      },
      [11] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 41007110,
          exist = true,
          name = "e3",
          trigger = 9
        }
      },
      [12] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0
          },
          pieceType = 0
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "每回合开始时，为生命百分比最高的敌人附加灼印"
    }
  },
  name = "泷被动技：灼印",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 1,
      id = 1500711,
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
