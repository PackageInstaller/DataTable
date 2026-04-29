AutoTest_230518_173629 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPosition",
        args = {pos = 502}
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
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [5] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          },
          skillIndex = 1
        }
      },
      [6] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 6,
          layerType = 400064,
          name = "p1",
          trigger = 0
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "FakeCastSkill",
        args = {
          name = "p2",
          pickUpPos = {
            [1] = 504.0
          },
          skillIndex = 1
        }
      },
      [9] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 7,
          layerType = 400064,
          name = "p1",
          trigger = 0
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [11] = {
        action = "FakeCastSkill",
        args = {
          name = "p4",
          pickUpPos = {
            [1] = 504.0
          },
          skillIndex = 3
        }
      },
      [12] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 8,
          layerType = 400064,
          name = "p1",
          trigger = 0
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "子弹获得条件改为任何光灵施放主动均+1,自己施放改为+5"
    }
  },
  name = "雷霆精炼Ⅱ",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 2,
      equiplv = 10,
      grade = 3,
      id = 1600641,
      level = 80,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 1,
      id = 1300521,
      level = 1,
      name = "p2"
    },
    [3] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 1,
      id = 1200501,
      level = 1,
      name = "p3"
    },
    [4] = {
      awakening = 0,
      equipRefineLv = 3,
      equiplv = 10,
      grade = 3,
      id = 1600191,
      level = 80,
      name = "p4"
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
