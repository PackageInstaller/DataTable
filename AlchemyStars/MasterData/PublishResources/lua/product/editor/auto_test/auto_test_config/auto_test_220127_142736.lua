AutoTest_220127_142736 = {
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
        action = "SetEntityHPPercent",
        args = {name = "team", percent = 0.89999997615814}
      },
      [4] = {
        action = "SetEntityHPPercent",
        args = {name = "enemy", percent = 0.89999997615814}
      },
      [5] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "<",
          name = "team",
          trigger = 88
        }
      },
      [6] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "enemy",
          trigger = 88
        }
      },
      [7] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 503.0
          }
        }
      },
      [8] = {
        action = "CheckUIHPShieldExist",
        args = {
          exist = true,
          name = "team",
          trigger = 88
        }
      },
      [9] = {
        action = "CheckUIHPShieldExist",
        args = {
          exist = false,
          name = "enemy",
          trigger = 88
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [11] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [13] = {
        action = "SetTeamPowerFull",
        args = {name = "enemy", name_select_index = 1}
      },
      [14] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "team",
          trigger = 88
        }
      },
      [15] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "<",
          name = "enemy",
          trigger = 88
        }
      },
      [16] = {
        action = "BlackFistCastSkill",
        args = {
          name = "r1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [17] = {
        action = "CheckUIHPShieldExist",
        args = {
          exist = true,
          name = "enemy",
          trigger = 88
        }
      },
      [18] = {
        action = "CheckUIHPShieldExist",
        args = {
          exist = true,
          name = "team",
          trigger = 88
        }
      },
      [19] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "菲莉诗"
    }
  },
  name = "黑拳赛-菲莉诗治疗效果",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 2,
      id = 1400571,
      level = 1,
      name = "p1"
    }
  },
  remotePet = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 2,
      id = 1400571,
      level = 1,
      name = "r1"
    }
  },
  setup = {
    [1] = {
      args = {levelID = 1, matchType = 12},
      setup = "LevelBasic"
    }
  }
}
