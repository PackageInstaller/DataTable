AutoTest_220118_143610 = {
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
          id = 3040201,
          name = "e1",
          pos = 506
        }
      },
      [5] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0
          },
          pieceType = 1
        }
      },
      [6] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 404.0,
            [2] = 405.0,
            [3] = 503.0,
            [4] = 504.0,
            [5] = 505.0,
            [6] = 506.0,
            [7] = 603.0,
            [8] = 604.0,
            [9] = 605.0,
            [10] = 606.0,
            [11] = 704.0,
            [12] = 705.0
          },
          skillid = 1002680,
          trigger = 102
        }
      },
      [7] = {
        action = "CheckEntityPos",
        args = {
          name = "p1",
          pos = 501,
          trigger = 88
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [9] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 501.0,
            [2] = 602.0,
            [3] = 503.0
          },
          pieceType = 1
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [11] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [12] = {
        action = "CheckUIHPShieldExist",
        args = {
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [14] = {
        action = "SetEntityAttack",
        args = {attack = 999999, name = "p1"}
      },
      [15] = {
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [16] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [17] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新测试用例"
    }
  },
  name = "t1024",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1501321,
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
