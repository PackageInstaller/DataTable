AutoTest_373 = {
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
        action = "FakeInputDoubleClick",
        args = {}
      },
      [4] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [5] = {
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 505
        }
      },
      [7] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "LegendPower",
          attr_select_index = 4,
          expect = 10.0,
          name = "p1",
          trigger = 0
        }
      },
      [8] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 30
        }
      },
      [9] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "LegendPower",
          attr_select_index = 4,
          expect = 0.0,
          name = "p1",
          trigger = 88
        }
      },
      [10] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 503.0
          }
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "1.全屏任选1格 2.消耗10点威能，并清空剩余威能 3.每回合开始获得5次威能（1觉）"
    }
  },
  name = "童谣座主动技",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 1,
      id = 1701091,
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
