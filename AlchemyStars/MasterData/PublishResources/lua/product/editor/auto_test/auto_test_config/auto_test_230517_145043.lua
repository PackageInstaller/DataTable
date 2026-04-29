AutoTest_230517_145043 = {
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
        action = "ChangeTeamLeader",
        args = {index = 2}
      },
      [5] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "ChangeTeamLeaderCount",
          expect = 3.0,
          name = "team",
          trigger = 0
        }
      },
      [6] = {
        action = "ChangeTeamLeader",
        args = {index = 3}
      },
      [7] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "ChangeTeamLeaderCount",
          expect = 2.0,
          name = "team",
          trigger = 0
        }
      },
      [8] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "ChangeTeamLeader",
        args = {index = 3}
      },
      [11] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "ChangeTeamLeaderCount",
          expect = 2.0,
          name = "team",
          trigger = 0
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "被动新效果：每回合限一次，本卡位置改变时，提供1次换队长次数"
    }
  },
  name = "克里斯汀精炼Ⅲ",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 0,
      id = 1300221,
      level = 1,
      name = "p2"
    },
    [2] = {
      awakening = 0,
      equipRefineLv = 3,
      equiplv = 10,
      grade = 3,
      id = 1501931,
      level = 80,
      name = "p1"
    },
    [3] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 0,
      id = 1400071,
      level = 1,
      name = "p3"
    },
    [4] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 0,
      id = 1600061,
      level = 1,
      name = "p4"
    }
  },
  remotePet = {},
  setup = {
    [1] = {
      args = {levelID = 1000903, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
