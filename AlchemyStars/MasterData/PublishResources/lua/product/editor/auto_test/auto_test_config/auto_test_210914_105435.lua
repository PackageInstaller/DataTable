AutoTest_210914_105435 = {
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
          dir = 5,
          disableai = true,
          id = 2010611,
          name = "e1",
          pos = 505
        }
      },
      [4] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "e1"}
      },
      [5] = {
        action = "CheckPieceType",
        args = {
          pieceType = 1,
          pos = 507,
          trigger = 20
        }
      },
      [6] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "CheckPieceType",
        args = {
          pieceType = 2,
          pos = 507,
          trigger = 20
        }
      },
      [9] = {
        action = "FakeCastSkill",
        args = {
          name = "p2",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [11] = {
        action = "CheckPieceType",
        args = {
          pieceType = 3,
          pos = 507,
          trigger = 20
        }
      },
      [12] = {
        action = "FakeCastSkill",
        args = {
          name = "p3",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [14] = {
        action = "CheckPieceType",
        args = {
          pieceType = 4,
          pos = 507,
          trigger = 88
        }
      },
      [15] = {
        action = "FakeCastSkill",
        args = {
          name = "p4",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [16] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "巴顿、玛吉、希卡蕾、奈弥西斯等十字转色类主动技能对克拉肯造成伤害"
    }
  },
  name = "27768-十字转色对卡拉肯",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 5,
      equiplv = 1,
      grade = 3,
      id = 1500421,
      level = 1,
      name = "p1"
    },
    [2] = {
      affinity = 1,
      awakening = 5,
      equiplv = 1,
      grade = 3,
      id = 1500881,
      level = 1,
      name = "p2"
    },
    [3] = {
      affinity = 1,
      awakening = 5,
      equiplv = 1,
      grade = 3,
      id = 1501001,
      level = 1,
      name = "p3"
    },
    [4] = {
      affinity = 1,
      awakening = 5,
      equiplv = 1,
      grade = 3,
      id = 1500121,
      level = 1,
      name = "p4"
    }
  },
  setup = {
    [1] = {
      args = {levelID = 1, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
