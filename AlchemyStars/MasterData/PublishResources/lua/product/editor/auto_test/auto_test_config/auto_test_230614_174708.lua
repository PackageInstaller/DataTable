AutoTest_230614_174708 = {
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
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [4] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 4102033,
          exist = true,
          name = "p1",
          trigger = 102
        }
      },
      [5] = {
        action = "FakeCastSkill",
        args = {
          name = "p2",
          pickUpPos = {
            [1] = 504.0
          },
          skillIndex = 1
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "每当因为光灵主动技而扣血时，获得等同于本卡XX%攻击力的护盾"
    }
  },
  name = "加晴觉醒1",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 1,
      id = 1502031,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 4,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 3,
      id = 1400451,
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
