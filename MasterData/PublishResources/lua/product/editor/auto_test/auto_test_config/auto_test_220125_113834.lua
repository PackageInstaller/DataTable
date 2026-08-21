AutoTest_220125_113834 = {
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
        action = "SetEntityHP",
        args = {hp = 999999, name = "team"}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 5,
          disableai = false,
          id = 2071352,
          name = "e1",
          pos = 505
        }
      },
      [5] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 106.0,
            [2] = 107.0,
            [3] = 202.0,
            [4] = 203.0,
            [5] = 206.0,
            [6] = 207.0,
            [7] = 302.0,
            [8] = 303.0,
            [9] = 508.0,
            [10] = 509.0,
            [11] = 602.0,
            [12] = 603.0,
            [13] = 608.0,
            [14] = 609.0,
            [15] = 702.0,
            [16] = 703.0,
            [17] = 704.0,
            [18] = 705.0,
            [19] = 804.0,
            [20] = 805.0
          },
          skillid = 501001,
          trigger = 102
        }
      },
      [6] = {
        action = "CheckBuffLogic",
        args = {
          exist = true,
          logic = "ATBuffBenumb",
          logic_select_index = 18,
          name = "team",
          trigger = 88
        }
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0
          },
          pieceType = 1
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新测试用例"
    }
  },
  name = "鸣灼",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1400071,
      level = 1,
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
