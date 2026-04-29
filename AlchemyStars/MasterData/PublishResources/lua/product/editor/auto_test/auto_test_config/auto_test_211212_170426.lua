AutoTest_211212_170426 = {
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
          id = 2060813,
          name = "e1",
          pos = 508
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 2060813,
          name = "e2",
          pos = 706
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 2060813,
          name = "e3",
          pos = 505
        }
      },
      [7] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [8] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e2",
          trigger = 88
        }
      },
      [9] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e3",
          trigger = 88
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
      [12] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 5100111,
          name = "e4",
          pos = 604
        }
      },
      [13] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e5",
          pos = 701
        }
      },
      [14] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e6",
          pos = 603
        }
      },
      [15] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e4",
          trigger = 88
        }
      },
      [16] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e5",
          trigger = 88
        }
      },
      [17] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e6",
          trigger = 88
        }
      },
      [18] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 402.0,
            [3] = 302.0,
            [4] = 303.0,
            [5] = 304.0,
            [6] = 305.0,
            [7] = 306.0,
            [8] = 406.0,
            [9] = 506.0
          },
          pieceType = 1
        }
      },
      [19] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "施放主动技后，在原地留下一个标记，在被动技触发时在该处同等效果的再触发一次"
    }
  },
  name = "拜里厄觉醒2（连锁技）",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 2,
      id = 1601111,
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
