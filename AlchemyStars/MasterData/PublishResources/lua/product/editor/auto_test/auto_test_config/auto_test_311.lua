AutoTest_311 = {
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
          pos = 508
        }
      },
      [3] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "e1"}
      },
      [4] = {
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [5] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 1,
          layerType = 4100302,
          name = "e1",
          trigger = 88
        }
      },
      [6] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 503.0
          }
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "附加1层崩裂效果"
    },
    [2] = {
      [1] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 2,
          layerType = 4100302,
          name = "e1",
          trigger = 28
        }
      },
      [2] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 505.0,
            [5] = 506.0,
            [6] = 507.0
          },
          pieceType = 1
        }
      },
      [3] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "连锁技增加一层崩裂效果"
    }
  },
  name = "醒山主动技和连锁技",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1600301,
      level = 1,
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
