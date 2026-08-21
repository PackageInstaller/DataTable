AutoTest_211214_194210 = {
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
          id = 2010113,
          name = "e1",
          pos = 103
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 203
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 303
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e4",
          pos = 403
        }
      },
      [7] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e5",
          pos = 503
        }
      },
      [8] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e6",
          pos = 603
        }
      },
      [9] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e7",
          pos = 703
        }
      },
      [10] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e8",
          pos = 803
        }
      },
      [11] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e9",
          pos = 903
        }
      },
      [12] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e10",
          pos = 904
        }
      },
      [13] = {
        action = "KillAllMonsters",
        args = {}
      },
      [14] = {
        action = "CheckUIPetLayerCount",
        args = {
          expect = 10,
          name = "p1",
          trigger = 88
        }
      },
      [15] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 410122,
          exist = true,
          name = "p1",
          trigger = 88
        }
      },
      [16] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [17] = {
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [18] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 2100612,
          name = "e11",
          pos = 509
        }
      },
      [19] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 2100612,
          name = "e12",
          pos = 104
        }
      },
      [20] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e11",
          trigger = 88
        }
      },
      [21] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e12",
          trigger = 88
        }
      },
      [22] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [23] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "主动技强化：被动超过10层后，主动技范围改为米字最大"
    }
  },
  name = "艾尔戈丝觉醒3",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1601221,
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
