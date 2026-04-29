AutoTest_220629_140537 = {
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
          id = 5100111,
          name = "e1",
          pos = 506
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 405
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 604
        }
      },
      [7] = {
        action = "CheckTeamOrder",
        args = {
          index = 1,
          name = "p2",
          trigger = 88
        }
      },
      [8] = {
        action = "FakeCastSkill",
        args = {
          name = "p2",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "CaptureFormulaAttr",
        args = {
          attr = "attackPercentage",
          defname = "e3",
          key = "FinalAtk",
          skillid = 2001461,
          trigger = 102,
          varname = "v1"
        }
      },
      [11] = {
        action = "CheckLocalValue",
        args = {
          target = 0.019999999552965,
          trigger = 88,
          varname = "v1"
        }
      },
      [12] = {
        action = "CheckTeamOrder",
        args = {
          index = 2,
          name = "p2",
          trigger = 88
        }
      },
      [13] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0
          },
          pieceType = 1
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "回合开始获得1层印记，最大7层；玩家回合如果当过队长，每层印记提供XXX%攻击力，回合结束清空印记"
    }
  },
  name = "瑶觉醒1",
  petList = {
    [1] = {
      affinity = 0,
      awakening = 0,
      equiplv = 0,
      grade = 0,
      id = 1601451,
      level = 1,
      name = "p1"
    },
    [2] = {
      affinity = 0,
      awakening = 0,
      equiplv = 1,
      grade = 1,
      id = 1601461,
      level = 1,
      name = "p2"
    }
  },
  setup = {
    [1] = {
      args = {levelID = 1, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
