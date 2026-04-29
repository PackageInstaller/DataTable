AutoTest_221026_152737 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 301}
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 907
        }
      },
      [4] = {
        action = "SetEntityHP",
        args = {hp = 100000, name = "e1"}
      },
      [5] = {
        action = "AddBuffToEntity",
        args = {buffID = 10630201, name = "e1"}
      },
      [6] = {
        action = "AddBuffToEntity",
        args = {buffID = 10630202, name = "e1"}
      },
      [7] = {
        action = "AddBuffToEntity",
        args = {buffID = 10630203, name = "e1"}
      },
      [8] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [9] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 907.0
          }
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [11] = {
        action = "FakeCastSkill",
        args = {
          name = "p2",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [13] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [14] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e1",
          trigger = 0
        }
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [16] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [17] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "<",
          name = "e1",
          trigger = 4
        }
      },
      [18] = {
        action = "CheckEntityHP",
        args = {
          compare = "==",
          hp = 71503,
          name = "e1",
          trigger = 4
        }
      },
      [19] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "每回合开始刷新1层次数护盾；回合结束时如果保有次数护盾，恢复4%血量"
    }
  },
  name = "调息Ⅱ",
  petList = {
    [1] = {
      awakening = 5,
      equiplv = 10,
      grade = 3,
      id = 1500901,
      level = 80,
      name = "p1"
    },
    [2] = {
      awakening = 5,
      equiplv = 10,
      grade = 3,
      id = 1600141,
      level = 80,
      name = "p2"
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
