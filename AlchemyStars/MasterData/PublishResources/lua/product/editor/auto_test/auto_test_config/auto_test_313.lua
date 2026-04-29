AutoTest_313 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPosition",
        args = {pos = 503}
      },
      [3] = {
        action = "SetTeamPowerFull",
        args = {}
      },
      [4] = {
        action = "SetPieceType",
        args = {pieceType = 2}
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 706
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 806
        }
      },
      [7] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 30
        }
      },
      [8] = {
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 709,
          trigger = 30
        }
      },
      [9] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 701,
          trigger = 30
        }
      },
      [10] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 708,
          trigger = 30
        }
      },
      [11] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 703.0
          }
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "1.瞬移指定位置，纵向1列 2.击退敌人 3.攻击范围转为水属性"
    }
  },
  name = "卡莲主动技",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600061,
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
