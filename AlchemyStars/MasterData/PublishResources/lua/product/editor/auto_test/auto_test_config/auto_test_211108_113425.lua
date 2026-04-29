AutoTest_211108_113425 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 107
        }
      },
      [3] = {
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [4] = {
        action = "FakeCastSkill",
        args = {
          name = "p2",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [6] = {
        action = "CheckDump",
        args = {trigger = 88}
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 403.0,
            [4] = 404.0,
            [5] = 304.0,
            [6] = 204.0,
            [7] = 104.0,
            [8] = 105.0
          },
          pieceType = 1
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "击退距离为0的时候报错，击退方向计算结果错误！"
    }
  },
  name = "鲁尼击退报错",
  petList = {
    [1] = {
      awakening = 1,
      equiplv = 1,
      grade = 1,
      id = 1300221,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 1,
      equiplv = 1,
      grade = 1,
      id = 1500841,
      level = 1,
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
