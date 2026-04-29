AutoTest_230808_150414 = {
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
        args = {name = "team"}
      },
      [4] = {
        action = "SetPieceType",
        args = {pieceType = 3}
      },
      [5] = {
        action = "SetEntityHPPercent",
        args = {name = "team", percent = 0.5}
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 505
        }
      },
      [7] = {
        action = "FakeCastSkill",
        args = {
          name = "p2",
          pickUpPos = {
            [1] = 504.0
          },
          skillIndex = 1
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [9] = {
        action = "FakeCastSkill",
        args = {
          name = "p3",
          pickUpPos = {
            [1] = 505.0
          },
          skillIndex = 1
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [11] = {
        action = "FakeCastSkill",
        args = {
          name = "p4",
          pickUpPos = {
            [1] = 504.0
          },
          skillIndex = 1
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [13] = {
        action = "FakeCastSkill",
        args = {
          name = "p5",
          pickUpPos = {
            [1] = 504.0
          },
          skillIndex = 1
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [15] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [16] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [17] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [18] = {
        action = "FakeCastSkill",
        args = {
          name = "p2",
          pickUpPos = {
            [1] = 504.0
          },
          skillIndex = 1
        }
      },
      [19] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [20] = {
        action = "FakeCastSkill",
        args = {
          name = "p3",
          pickUpPos = {
            [1] = 509.0
          },
          skillIndex = 1
        }
      },
      [21] = {
        action = "CheckUIPetLayerCount",
        args = {
          expect = 6,
          name = "p1",
          trigger = 88
        }
      },
      [22] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [23] = {
        action = "FakeCastSkill",
        args = {
          name = "p4",
          pickUpPos = {
            [1] = 504.0
          },
          skillIndex = 1
        }
      },
      [24] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [25] = {
        action = "CheckUIPetLayerCount",
        args = {
          expect = 0,
          name = "p1",
          trigger = 88
        }
      },
      [26] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [27] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新测试用例"
    }
  },
  name = "希南觉醒1",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 1,
      id = 1602071,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 6,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 3,
      id = 1600261,
      level = 1,
      name = "p2"
    },
    [3] = {
      awakening = 5,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 3,
      id = 1501831,
      level = 1,
      name = "p3"
    },
    [4] = {
      awakening = 5,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 3,
      id = 1500421,
      level = 1,
      name = "p4"
    },
    [5] = {
      awakening = 1,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 2,
      id = 1300471,
      level = 1,
      name = "p5"
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
