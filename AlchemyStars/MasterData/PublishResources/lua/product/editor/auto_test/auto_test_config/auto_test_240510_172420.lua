AutoTest_240510_172420 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPosition",
        args = {pos = 505}
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
          id = 2004101,
          name = "e1",
          pos = 405
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
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 205,
          trigger = 88
        }
      },
      [7] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 200380104,
          exist = true,
          name = "team",
          trigger = 88
        }
      },
      [8] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 200380105,
          exist = true,
          name = "team",
          trigger = 88
        }
      },
      [9] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "攻击2次，然后后撤。每次攻击命中目标后会偷取一定百分比的基础攻击、基础防御属性，效果累积，有单独cd，死亡后返还偷取属性"
    }
  },
  name = "佣兵贼",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
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
