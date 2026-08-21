AutoTest_344 = {
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
        args = {name = "team", name_select_index = 0}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 2091314,
          name = "e1",
          pos = 503
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 2091314,
          name = "e2",
          pos = 504
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 2091314,
          name = "e3",
          pos = 505
        }
      },
      [7] = {
        action = "SetEntityHPPercent",
        args = {name = "e1", percent = 0.0099999997764826}
      },
      [8] = {
        action = "SetEntityHPPercent",
        args = {name = "e2", percent = 9999999.0}
      },
      [9] = {
        action = "SetEntityHP",
        args = {hp = 9999999, name = "e3"}
      },
      [10] = {
        action = "SetPieceType",
        args = {pieceType = 4}
      },
      [11] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [12] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e2",
          trigger = 88
        }
      },
      [13] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e3",
          trigger = 88
        }
      },
      [14] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 503.0
          },
          skillIndex = 1
        }
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [16] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "全屏任选1个敌人造成20次伤害，打死之后选离该敌人最近的目标继续打。所在位置周围1圈内每有1个雷属性格子，增加1次伤害害"
    }
  },
  name = "伊芙主动技1",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 0,
      id = 1601051,
      level = 30,
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
