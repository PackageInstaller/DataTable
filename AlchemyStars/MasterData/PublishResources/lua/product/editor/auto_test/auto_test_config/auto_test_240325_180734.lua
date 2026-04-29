AutoTest_240325_180734 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetEntityPosition",
        args = {name = "p1", pos = 502}
      },
      [3] = {
        action = "SetEntityHPPercent",
        args = {name = "team", percent = 0.30000001192093}
      },
      [4] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [6] = {
        action = "CheckPieceType",
        args = {
          pieceType = 3,
          pos = 504,
          trigger = 88
        }
      },
      [7] = {
        action = "CheckPieceType",
        args = {
          pieceType = 3,
          pos = 302,
          trigger = 88
        }
      },
      [8] = {
        action = "CheckAttributeChange",
        args = {
          attr = "HP",
          cmp = "<",
          name = "team",
          trigger = 88
        }
      },
      [9] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0,
            [2] = 302.0
          },
          skillIndex = 1
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "任选1格，再在周围两圈再选一个确定一个区域。两个点选格转森属性。若队伍在区域内，回复250%攻击力的血量。"
    }
  },
  name = "安顿主动技",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 0,
      id = 1602121,
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
