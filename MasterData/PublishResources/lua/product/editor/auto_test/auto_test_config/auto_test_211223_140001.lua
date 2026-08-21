AutoTest_211223_140001 = {
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
          disableai = false,
          id = 5100111,
          name = "e1",
          pos = 305
        }
      },
      [3] = {
        action = "AddBuffToEntity",
        args = {buffID = 88841011, name = "e1"}
      },
      [4] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Mobility",
          attr_select_index = 27,
          expect = 4.0,
          name = "e1",
          trigger = 0
        }
      },
      [5] = {
        action = "AddBuffToEntity",
        args = {buffID = 10041, name = "e1"}
      },
      [6] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Mobility",
          attr_select_index = 27,
          expect = 2.0,
          name = "e1",
          trigger = 0
        }
      },
      [7] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "行动力翻倍后减半恢复原值"
    }
  },
  name = "行动力翻倍减半恢复",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600191,
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
