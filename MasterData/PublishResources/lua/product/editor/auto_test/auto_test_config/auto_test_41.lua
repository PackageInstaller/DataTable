AutoTest_41 = {
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
          pos = 305
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 405
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 505
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e4",
          pos = 605
        }
      },
      [7] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e5",
          pos = 705
        }
      },
      [8] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e6",
          pos = 805
        }
      },
      [9] = {
        action = "SetEntityHPPercent",
        args = {name = "e1", percent = 0.5}
      },
      [10] = {
        action = "SetEntityHPPercent",
        args = {name = "e2", percent = 0.5}
      },
      [11] = {
        action = "SetEntityHPPercent",
        args = {name = "e3", percent = 0.5}
      },
      [12] = {
        action = "SetEntityHPPercent",
        args = {name = "e4", percent = 0.5}
      },
      [13] = {
        action = "SetEntityHPPercent",
        args = {name = "e5", percent = 0.5}
      },
      [14] = {
        action = "SetEntityHPPercent",
        args = {name = "e6", percent = 0.5}
      },
      [15] = {
        action = "CheckEntityBuffValue",
        args = {
          key = "SoulCount",
          name = "p1",
          trigger = 88,
          value = 5.0
        }
      },
      [16] = {
        action = "CheckUIPetLayerCount",
        args = {
          expect = 5,
          name = "p1",
          trigger = 88
        }
      },
      [17] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          },
          skillIndex = 0
        }
      },
      [18] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "米娅主动技击杀敌人后获得1层灵魂，最大5层。每层灵魂对单个敌人释放1次{1}攻击力的冲击。"
    }
  },
  name = "米娅被动技：收割灵魂",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 5,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 1,
      id = 1600051,
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
