AutoTest_211216_101121 = {
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
          disableai = false,
          id = 2091314,
          name = "e1",
          pos = 506
        }
      },
      [5] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 9,
          name = "j1",
          pos = 505
        }
      },
      [6] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 9,
          name = "e2",
          pos = 507
        }
      },
      [7] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 9,
          name = "e3",
          pos = 406
        }
      },
      [8] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 9,
          name = "e4",
          pos = 606
        }
      },
      [9] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 505,
          trapIds = {
            [1] = 9.0
          },
          trigger = 88
        }
      },
      [10] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 507,
          trapIds = {
            [1] = 9.0
          },
          trigger = 88
        }
      },
      [11] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 406,
          trapIds = {
            [1] = 9.0
          },
          trigger = 88
        }
      },
      [12] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 606,
          trapIds = {
            [1] = 9.0
          },
          trigger = 88
        }
      },
      [13] = {
        action = "SetEntityPosition",
        args = {name = "e1", pos = 506}
      },
      [14] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e1",
          trigger = 88
        }
      },
      [15] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          }
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
        action = "CheckEntityPos",
        args = {
          name = "e1",
          pos = 506,
          trigger = 88
        }
      },
      [19] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e1",
          trigger = 88
        }
      },
      [20] = {
        action = "FakeCastSkill",
        args = {
          name = "p2",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [21] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [22] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [23] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 404.0
          },
          pieceType = 1
        }
      },
      [24] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "不可销毁坚石，怪物在中间，无视牵引，击退，范围够可造成伤害"
    }
  },
  name = "坚石机关",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1601031,
      level = 1,
      name = "p3"
    },
    [2] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600061,
      level = 1,
      name = "p1"
    },
    [3] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1300741,
      level = 1,
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
