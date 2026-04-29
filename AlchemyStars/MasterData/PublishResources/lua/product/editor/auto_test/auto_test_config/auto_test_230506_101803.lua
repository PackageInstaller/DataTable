AutoTest_230506_101803 = {
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
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 140127102,
          name = "e1",
          pos = 503
        }
      },
      [4] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 1994,
          name = "e2",
          pos = 504
        }
      },
      [5] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [6] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 505.0
          },
          skillIndex = 1
        }
      },
      [7] = {
        action = "CheckTrapExist",
        args = {
          exist = true,
          trapIds = {
            [1] = 621.0
          },
          trigger = 88
        },
        exist = true
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [9] = {
        action = "FakeCastFeatureScanTrap",
        args = {chooseIndex = 2}
      },
      [10] = {
        action = "WaitTime",
        args = {timeMs = 3000}
      },
      [11] = {
        action = "FakeCastSkill",
        args = {
          name = "p2",
          pickUpPos = {
            [1] = 405.0
          },
          skillIndex = 1
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "召唤一个十字转色棱镜(可被复制,突6效果不可复制)"
    }
  },
  name = "莺歌主动技",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 0,
      id = 1601991,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 6,
      equipRefineLv = 0,
      equiplv = 10,
      grade = 3,
      id = 1601751,
      level = 80,
      name = "p2"
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
