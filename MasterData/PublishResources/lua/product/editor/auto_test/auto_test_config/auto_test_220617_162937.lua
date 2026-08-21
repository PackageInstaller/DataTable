AutoTest_220617_162937 = {
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
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 704,
          trapIds = {
            [1] = 1.5014911E7
          },
          trigger = 88
        }
      },
      [5] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 4,
          pos = 704,
          trigger = 88
        }
      },
      [6] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 704.0
          }
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [12] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 503.0
          }
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [14] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [15] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
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
          name = "p1",
          pickUpPos = {
            [1] = 403.0
          }
        }
      },
      [19] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [20] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [21] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 604.0
          }
        }
      },
      [22] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [23] = {
        action = "CheckTrapCount",
        args = {
          expect = 4,
          trapIDs = {
            [1] = 1.5014911E7
          },
          trigger = 0
        }
      },
      [24] = {
        action = "CheckGridTrap",
        args = {
          exist = false,
          pos = 704,
          trapIds = {
            [1] = 1.5014911E7
          },
          trigger = 0
        }
      },
      [25] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 5100111,
          name = "e1",
          pos = 605
        }
      },
      [26] = {
        action = "CheckGridTrap",
        args = {
          exist = false,
          pos = 604,
          trapIds = {
            [1] = 1.5014911E7
          },
          trigger = 88
        }
      },
      [27] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [28] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "两圈范围内选一个空格子转为雷属性，然后在该格子上召唤一个机关：怪可以踩坏，场上至多存在4个机关"
    }
  },
  name = "罗伊主动技",
  petList = {
    [1] = {
      affinity = 0,
      awakening = 0,
      equiplv = 0,
      grade = 0,
      id = 1501491,
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
