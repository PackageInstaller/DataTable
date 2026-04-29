AutoTest_221103_150209 = {
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
          pos = 504
        }
      },
      [4] = {
        action = "AddBuffToEntity",
        args = {buffID = 88841032, name = "e1"}
      },
      [5] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 88841032,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [6] = {
        action = "CheckBuffLogic",
        args = {
          exist = true,
          logic = "ATBuffLayerShield",
          name = "e1",
          trigger = 88
        }
      },
      [7] = {
        action = "CheckUILayerShieldCount",
        args = {
          expect = 5,
          name = "e1",
          trigger = 88
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
      name = "所有怪物开局获得五层护盾。"
    }
  },
  name = "40032黑光庇护",
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
