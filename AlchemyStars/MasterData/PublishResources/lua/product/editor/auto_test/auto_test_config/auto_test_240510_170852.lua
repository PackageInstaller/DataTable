AutoTest_240510_170852 = {
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
        args = {hp = 999999, name = "team"}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 2003901,
          name = "e1",
          pos = 305
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 2003801,
          name = "e2",
          pos = 506
        }
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
        action = "CheckEntityBuff",
        args = {
          buffId = 20039014,
          exist = true,
          name = "e2",
          trigger = 88
        }
      },
      [8] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 20039019,
          exist = true,
          name = "e2",
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
      [11] = {
        action = "SetEntityHPPercent",
        args = {name = "e1", percent = 0.30000001192093}
      },
      [12] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "<",
          name = "e1",
          trigger = 88
        }
      },
      [13] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "选中前方敌人为目标。怪物回合开始时，若血量低于n%时，切换ai，移动方式改为远离玩家行走，主动技更改为恢复自身已损失血量的n%"
    }
  },
  name = "佣兵提灯人",
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
