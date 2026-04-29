AutoTest_240510_155745 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 505}
      },
      [3] = {
        action = "SetEntityHP",
        args = {hp = 10000, name = "team"}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 2003701,
          name = "e1",
          pos = 305
        }
      },
      [5] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "team",
          trigger = 88
        }
      },
      [6] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "CheckEntityHP",
        args = {
          compare = "==",
          hp = 6384,
          name = "team",
          trigger = 88
        }
      },
      [9] = {
        action = "FakeCastSkill",
        args = {
          name = "p2",
          pickUpPos = {
            [1] = 905.0
          },
          skillIndex = 1
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "移动后向玩家射击，降低目标40%回复效果"
    }
  },
  name = "佣兵弩手",
  petList = {
    [1] = {
      awakening = 2,
      equipRefineLv = 0,
      equiplv = 0,
      grade = 0,
      id = 1400571,
      level = 1,
      name = "p2"
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
