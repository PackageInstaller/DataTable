AutoTest_20 = {
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
          disableai = false,
          id = 5100111,
          name = "e1",
          pos = 709
        }
      },
      [4] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 708,
          trapId = 14,
          trapIds = {
            [1] = 2236.0
          },
          trigger = 88
        }
      },
      [5] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 708.0
          }
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "任选1格放置旗帜。艾米与旗帜的距离越近防御越高，最高增加100%的防御。旗帜被敌人触碰后消失。"
    }
  },
  name = "艾米主动技生成旗帜",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 0,
      grade = 0,
      id = 1300581,
      level = 1,
      name = "p1"
    }
  },
  setup = {
    [1] = {
      args = {levelID = 1, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
