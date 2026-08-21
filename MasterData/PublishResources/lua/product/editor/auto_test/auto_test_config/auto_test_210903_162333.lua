AutoTest_210903_162333 = {
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
        action = "SetTeamPosition",
        args = {name = "team", pos = 708}
      },
      [4] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 19,
          name = "t1",
          pos = 808
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 2081311,
          name = "e1",
          pos = 508
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 2081313,
          name = "e2",
          pos = 803
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 708.0
          },
          pieceType = 0
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 26}
      },
      [10] = {
        action = "CheckDump",
        args = {trigger = 88}
      },
      [11] = {
        action = "FakeCancelChainSkillCast",
        args = {}
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "先被击飞小怪打到传送门上、再被钩子怪钩走、触发传送门、选点没有被传送过去"
    }
  },
  name = "25571-击退-钩子-传送",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 5,
      equiplv = 1,
      grade = 3,
      id = 1600261,
      level = 10,
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
