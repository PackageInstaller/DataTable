AutoTest_220121_140401 = {
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
        action = "SetEntityHP",
        args = {hp = 999999, name = "team"}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 5,
          disableai = false,
          id = 2090213,
          name = "e1",
          pos = 506
        }
      },
      [5] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 403.0,
            [2] = 404.0,
            [3] = 405.0,
            [4] = 406.0,
            [5] = 503.0,
            [6] = 506.0,
            [7] = 603.0,
            [8] = 606.0,
            [9] = 703.0,
            [10] = 704.0,
            [11] = 705.0,
            [12] = 706.0
          },
          skillid = 1004505,
          trigger = 102
        }
      },
      [6] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 405,
          trapIds = {
            [1] = 64.0
          },
          trigger = 88
        }
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0
          },
          pieceType = 1
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [9] = {
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [10] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 402,
          trapIds = {
            [1] = 61.0
          },
          trigger = 88
        }
      },
      [11] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 602,
          trapIds = {
            [1] = 61.0
          },
          trigger = 88
        }
      },
      [12] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 502,
          trapIds = {
            [1] = 61.0
          },
          trigger = 88
        }
      },
      [13] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 404.0
          }
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [15] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 1,
          pos = 404,
          trigger = 88
        }
      },
      [16] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [17] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新测试用例"
    }
  },
  name = "锁格子狞崮",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600021,
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
