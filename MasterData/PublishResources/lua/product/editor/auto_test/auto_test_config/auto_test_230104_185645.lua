AutoTest_230104_185645 = {
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
          pos = 507
        }
      },
      [4] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [5] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 40018311,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [6] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 40018321,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [7] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 40018331,
          exist = false,
          name = "e1",
          trigger = 88
        }
      },
      [8] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 507.0
          },
          skillIndex = 0
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "主动技强化debuff1-3次（随机）"
    }
  },
  name = "厘青觉醒Ⅲ",
  petList = {
    [1] = {
      awakening = 5,
      equiplv = 6,
      grade = 3,
      id = 1501831,
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
