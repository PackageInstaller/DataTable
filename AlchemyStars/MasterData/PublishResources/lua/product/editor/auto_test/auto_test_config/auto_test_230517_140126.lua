AutoTest_230517_140126 = {
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
          pos = 505
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
          skillIndex = 2
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "CheckTeamOrder",
        args = {
          index = 1,
          name = "p1",
          trigger = 0
        }
      },
      [8] = {
        action = "CheckEntityPos",
        args = {
          name = "team",
          pos = 503,
          trigger = 0
        }
      },
      [9] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [10] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Power",
          expect = 2.0,
          name = "p1",
          trigger = 88
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "变体1：cd+1，和队伍中前一名队员换位置，且可以朝伤害方向位移1格"
    }
  },
  name = "克里斯汀精炼Ⅰ",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 1,
      id = 1200501,
      level = 20,
      name = "p2"
    },
    [2] = {
      awakening = 0,
      equipRefineLv = 1,
      equiplv = 10,
      grade = 3,
      id = 1501931,
      level = 80,
      name = "p1"
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
