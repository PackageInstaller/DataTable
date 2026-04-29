AutoTest_256 = {
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
        args = {}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 503
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 504
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 505
        }
      },
      [7] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e4",
          pos = 506
        }
      },
      [8] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 30
        }
      },
      [9] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e2",
          trigger = 30
        }
      },
      [10] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e3",
          trigger = 30
        }
      },
      [11] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e4",
          trigger = 30
        }
      },
      [12] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "1.范围提高3圈 2.先制攻击"
    }
  },
  name = "安西娅主动技2-先制攻击",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 4,
      equiplv = 1,
      grade = 3,
      id = 1401011,
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
