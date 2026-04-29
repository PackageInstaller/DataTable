AutoTest_220207_105132 = {
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
        args = {name = "team", percent = 0.5}
      },
      [4] = {
        action = "SetEntityHPPercent",
        args = {name = "enemy", percent = 0.5}
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
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [9] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [11] = {
        action = "SetTeamPowerFull",
        args = {name = "enemy", name_select_index = 1}
      },
      [12] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "<",
          name = "enemy",
          trigger = 88
        }
      },
      [13] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "team",
          trigger = 88
        }
      },
      [14] = {
        action = "BlackFistCastSkill",
        args = {
          name = "r1",
          pickUpPos = {
            [1] = 505.0
          }
        }
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "卓娅"
    }
  },
  name = "黑拳赛-卓娅主动技",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 2,
      id = 1300471,
      level = 1,
      name = "p1"
    }
  },
  remotePet = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 2,
      id = 1300471,
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
