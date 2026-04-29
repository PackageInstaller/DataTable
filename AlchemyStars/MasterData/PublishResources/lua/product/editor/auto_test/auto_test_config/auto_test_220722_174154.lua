AutoTest_220722_174154 = {
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
        action = "ModifySanValue",
        args = {modifyValue = -90}
      },
      [4] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [6] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "team",
          trigger = 88
        }
      },
      [7] = {
        action = "CheckSanValue",
        args = {
          compare = ">",
          expect = 10,
          trigger = 88
        }
      },
      [8] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "流失20%的当前生命值，回复25%已损失san值"
    }
  },
  name = "梅主动技",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1501521,
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
