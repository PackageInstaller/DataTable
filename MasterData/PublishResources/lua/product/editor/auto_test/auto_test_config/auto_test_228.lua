AutoTest_228 = {
  cases = {
    [1] = {
      [1] = {
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [2] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 306
        }
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 605
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 808
        }
      },
      [5] = {
        action = "CheckBuffLogic",
        args = {
          exist = true,
          logic = "ATBuffBloodShield",
          logic_select_index = 19,
          name = "p1",
          trigger = 88
        }
      },
      [6] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "落点周围两圈内每个敌人，提供菲利诗生命上限30%的护盾"
    }
  },
  name = "菲莉诗主动技强化：护盾",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 2,
      id = 1400571,
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
