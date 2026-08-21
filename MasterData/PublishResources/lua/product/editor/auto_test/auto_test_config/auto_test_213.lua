AutoTest_213 = {
  cases = {
    [1] = {
      [1] = {
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [2] = {
        action = "CheckBuffLogic",
        args = {
          exist = true,
          logic = "ATBuffBloodShield",
          logic_select_index = 19,
          name = "team",
          trigger = 88
        }
      },
      [3] = {
        action = "CheckUIHPShieldExist",
        args = {trigger = 88}
      },
      [4] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [6] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0
          },
          pieceType = 0
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "CheckBuffLogic",
        args = {
          exist = false,
          logic = "ATBuffBloodShield",
          logic_select_index = 19,
          name = "team",
          trigger = 88
        }
      },
      [9] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0
          },
          pieceType = 0
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "每有1个水属性格子，便获得相当于诺尔8%生命的护盾（上限200%），持续1回合。"
    }
  },
  name = "诺尔主动技：护盾",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1500131,
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
