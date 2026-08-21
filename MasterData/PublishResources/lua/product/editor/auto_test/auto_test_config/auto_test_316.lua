AutoTest_316 = {
  cases = {
    [1] = {
      [1] = {
        action = "SetTeamPowerFull",
        args = {}
      },
      [2] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 503
        }
      },
      [3] = {
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 503,
          trigger = 88
        }
      },
      [4] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 503.0
          }
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "1.重置所有非火属性格子，敌人所处位置至多1个格子被转为火属性"
    }
  },
  name = "乌列尔主动技",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600261,
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
