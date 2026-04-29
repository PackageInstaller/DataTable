AutoTest_96 = {
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
        action = "SetTeamPowerFull",
        args = {}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 506
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 507
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 706
        }
      },
      [7] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 41007110,
          exist = true,
          name = "e1",
          trigger = 19
        }
      },
      [8] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 41007110,
          exist = false,
          name = "e2",
          trigger = 19
        }
      },
      [9] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 41007110,
          exist = true,
          name = "e3",
          trigger = 19
        }
      },
      [10] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 506.0
          }
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "造成伤害前，对目标附加被动标记"
    }
  },
  name = "泷主动技强化：附加灼印",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 2,
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
