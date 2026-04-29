AutoTest_230713_103628 = {
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
          pos = 508
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 606
        }
      },
      [5] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 43002042,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [8] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e1",
          trigger = 88
        }
      },
      [9] = {
        action = "FakeCastSkill",
        args = {
          name = "p2",
          pickUpPos = {
            [1] = 508.0
          },
          skillIndex = 1
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [11] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [13] = {
        action = "SetEntityAttack",
        args = {attack = 99999, name = "p2"}
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [15] = {
        action = "FakeCastSkill",
        args = {
          name = "p2",
          pickUpPos = {
            [1] = 508.0
          },
          skillIndex = 1
        }
      },
      [16] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [17] = {
        action = "CheckMonsterCount",
        args = {
          count = 1,
          monsterid = 5100111,
          trigger = 88
        }
      },
      [18] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [19] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "任选一个敌人刺入诅咒：怪的血条左侧出现一个标识，当前血量和标识接触时怪直接死亡（仍受免死、锁血等效果）初始值为200%的攻击力"
    }
  },
  name = "约书亚主动技",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 0,
      id = 1602041,
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
