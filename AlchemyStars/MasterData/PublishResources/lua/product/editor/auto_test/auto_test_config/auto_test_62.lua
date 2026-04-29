AutoTest_62 = {
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
          pos = 805
        }
      },
      [4] = {
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [5] = {
        action = "CheckPieceType",
        args = {
          pieceType = 4,
          pos = 709,
          trigger = 30
        }
      },
      [6] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 709,
          trapId = 14,
          trapIds = {
            [1] = 800001.0,
            [2] = 800002.0,
            [3] = 800003.0,
            [4] = 800004.0,
            [5] = 800005.0
          },
          trigger = 30
        }
      },
      [7] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 709.0
          }
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "全局任选一格转为雷属性，并生成落雷结晶、陨石结晶、绷带、攻击和防御中的一种道具"
    }
  },
  name = "尤尼梅特主动技",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1300801,
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
