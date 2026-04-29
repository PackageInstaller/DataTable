AutoTest_211213_215024 = {
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
        action = "CheckPieceType",
        args = {
          pieceType = 3,
          pos = 503,
          trigger = 88
        }
      },
      [5] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 503,
          trapIds = {
            [1] = 1.4012711E7
          },
          trigger = 88
        }
      },
      [6] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 503.0
          }
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "SetOnePieceType",
        args = {pieceType = 3, pos = 603}
      },
      [9] = {
        action = "CheckGridTrap",
        args = {
          exist = false,
          pos = 503,
          trapIds = {
            [1] = 1.4012711E7
          },
          trigger = 88
        }
      },
      [10] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 603.0
          },
          pieceType = 3
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [12] = {
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [13] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 17,
          name = "e2",
          pos = 607
        }
      },
      [14] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 707,
          trapIds = {
            [1] = 1.4012711E7
          },
          trigger = 88
        }
      },
      [15] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 707.0
          }
        }
      },
      [16] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "全屏任选一个格子，格子上贴一张纸，强制转为森属性，可以选择深渊格子；玩家经过该格子后纸会被消耗"
    }
  },
  name = "帕索洛主动技",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1401271,
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
