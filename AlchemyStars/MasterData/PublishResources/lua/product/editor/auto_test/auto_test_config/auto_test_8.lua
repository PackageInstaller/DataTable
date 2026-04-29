AutoTest_8 = {
  cases = {
    [1] = {
      [1] = {
        action = "SetPieceType",
        args = {pieceType = 3}
      },
      [2] = {
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [3] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [4] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 506
        }
      },
      [6] = {
        action = "CheckDoubleChain",
        args = {name = "p1", trigger = 89}
      },
      [7] = {
        action = "CheckDoubleChain",
        args = {name = "p2", trigger = 89}
      },
      [8] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 505.0
          },
          pieceType = 3
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "二次连锁测试"
    }
  },
  name = "露易丝大招二次连锁",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600101,
      level = 10,
      name = "p1"
    },
    [2] = {
      affinity = 0,
      awakening = 0,
      equiplv = 0,
      grade = 0,
      id = 1500211,
      level = 10,
      name = "p2"
    }
  },
  setup = {
    [1] = {
      args = {levelID = 1, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
