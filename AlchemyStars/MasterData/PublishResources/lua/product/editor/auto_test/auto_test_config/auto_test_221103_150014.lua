AutoTest_221103_150014 = {
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
          pos = 305
        }
      },
      [4] = {
        action = "SetEntityHPPercent",
        args = {name = "e1", percent = 0.5}
      },
      [5] = {
        action = "AddBuffToEntity",
        args = {buffID = 88841012, name = "e1"}
      },
      [6] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "<",
          name = "e1",
          trigger = 88
        }
      },
      [7] = {
        action = "CheckEntityHP",
        args = {
          compare = "==",
          hp = 3157,
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
      name = "怪物每回合都会恢复10%最大生命值的血量。"
    }
  },
  name = "40012不朽之躯",
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
