AutoTest_220225_113124 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Ready",
          attr_select_index = 11,
          expect = 1.0,
          name = "p1",
          trigger = 0
        }
      },
      [3] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 502}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 2100212,
          name = "e1",
          pos = 206
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 2100212,
          name = "e2",
          pos = 403
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 2100212,
          name = "e3",
          pos = 301
        }
      },
      [7] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [8] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e2",
          trigger = 88
        }
      },
      [9] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e3",
          trigger = 88
        }
      },
      [10] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 403.0
          }
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "突2：先制攻击 突5：主动技强化：可以选斜方向3列"
    }
  },
  name = "艾莉法突2突5",
  petList = {
    [1] = {
      awakening = 5,
      equiplv = 1,
      grade = 3,
      id = 1501391,
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
