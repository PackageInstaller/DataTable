AutoTest_220 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPosition",
        args = {pos = 502}
      },
      [3] = {
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 605
        }
      },
      [5] = {
        action = "SetPieceType",
        args = {pieceType = 3}
      },
      [6] = {
        action = "SetOnePieceType",
        args = {pieceType = 1, pos = 107}
      },
      [7] = {
        action = "SetOnePieceType",
        args = {pieceType = 1, pos = 403}
      },
      [8] = {
        action = "SetOnePieceType",
        args = {pieceType = 1, pos = 601}
      },
      [9] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          invert = 0.0,
          name = "e1",
          trigger = 30
        }
      },
      [10] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "随机对场上的敌人造成5次80%攻击力的伤害，所在位置周围1圈内每有1个水属性格子，再额外攻击1次。"
    }
  },
  name = "薇丝主动技",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1500331,
      level = 10,
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
