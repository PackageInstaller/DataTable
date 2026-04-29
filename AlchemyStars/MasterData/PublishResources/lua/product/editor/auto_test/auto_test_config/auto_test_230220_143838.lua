AutoTest_230220_143838 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 702}
      },
      [3] = {
        action = "SetEntityAttack",
        args = {attack = 999999, name = "p1"}
      },
      [4] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [6] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 704.0
          },
          skillIndex = 1
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "CastTrapSkill",
        args = {
          pickUpPos = {
            [1] = 504.0,
            [2] = 505.0
          },
          pos = 501,
          skillID = 280061101,
          trapID = 2800611
        }
      },
      [9] = {
        action = "CheckTrapExist",
        args = {
          exist = true,
          trapIds = {
            [1] = 2.8006111E7
          },
          trigger = 88
        },
        exist = true
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [11] = {
        action = "CastTrapSkill",
        args = {
          pickUpPos = {
            [1] = 404.0,
            [2] = 405.0
          },
          pos = 501,
          skillID = 280061103,
          trapID = 2800611
        }
      },
      [12] = {
        action = "CheckTrapExist",
        args = {
          exist = true,
          trapIds = {
            [1] = 2.8006113E7
          },
          trigger = 88
        },
        exist = true
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [14] = {
        action = "CastTrapSkill",
        args = {
          pickUpPos = {
            [1] = 504.0
          },
          pos = 501,
          skillID = 280061104,
          trapID = 2800611
        }
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [16] = {
        action = "CastTrapSkill",
        args = {
          pickUpPos = {
            [1] = 404.0
          },
          pos = 501,
          skillID = 280061104,
          trapID = 2800611
        }
      },
      [17] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [18] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [19] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [20] = {
        action = "CheckTrapExist",
        args = {
          exist = false,
          trapIds = {
            [1] = 2.8006111E7
          },
          trigger = 0
        },
        exist = true
      },
      [21] = {
        action = "CheckTrapExist",
        args = {
          exist = false,
          trapIds = {
            [1] = 2.8006113E7
          },
          trigger = 0
        },
        exist = true
      },
      name = "赛车关"
    }
  },
  name = "赛车机关（待补齐）",
  petList = {
    [1] = {
      awakening = 3,
      equiplv = 3,
      grade = 3,
      id = 1600301,
      level = 1,
      name = "p1"
    }
  },
  remotePet = {},
  setup = {
    [1] = {
      args = {levelID = 5272001, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
