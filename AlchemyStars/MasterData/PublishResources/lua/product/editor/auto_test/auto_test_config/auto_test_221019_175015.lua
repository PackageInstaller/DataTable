AutoTest_221019_175015 = {
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
          pos = 305
        }
      },
      [4] = {
        action = "AddBuffToEntity",
        args = {buffID = 100001, name = "e1"}
      },
      [5] = {
        action = "AddBuffToEntity",
        args = {buffID = 101301, name = "e1"}
      },
      [6] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [7] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [9] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [11] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 504,
          trapIds = {
            [1] = 60.0
          },
          trigger = 88
        }
      },
      [12] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 604,
          trapIds = {
            [1] = 60.0
          },
          trigger = 88
        }
      },
      [13] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 504.0,
            [2] = 604.0,
            [3] = 605.0
          },
          pieceType = 1
        }
      },
      [14] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [15] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 100001,
          exist = true,
          name = "e1",
          trigger = 0
        }
      },
      [16] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 101301,
          exist = true,
          name = "e1",
          trigger = 0
        }
      },
      [17] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "清醒状态下，任何新生成的格子都是碎格子（移动生成和转色生成）"
    },
    [2] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "AddBuffToEntity",
        args = {buffID = 10011, name = "e1"}
      },
      [3] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [4] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 704.0
          }
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [6] = {
        action = "CheckGridTrap",
        args = {
          exist = false,
          pos = 707,
          trapIds = {
            [1] = 60.0
          },
          trigger = 0
        }
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 704.0,
            [2] = 705.0,
            [3] = 706.0,
            [4] = 707.0
          },
          pieceType = 1
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [9] = {
        action = "CheckGridTrap",
        args = {
          exist = false,
          pos = 705,
          trapIds = {
            [1] = 60.0
          },
          trigger = 0
        }
      },
      name = "清醒状态下，任何新生成的格子正常"
    }
  },
  name = "1013大地污染",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600061,
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
