AutoTest_221020_185230 = {
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
          pos = 503
        }
      },
      [4] = {
        action = "AddBuffToEntity",
        args = {buffID = 103301, name = "e1"}
      },
      [5] = {
        action = "SetEntityAttack",
        args = {attack = 999999, name = "p1"}
      },
      [6] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 103301,
          exist = true,
          name = "e1",
          trigger = 0
        }
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
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [10] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [12] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 301.0,
            [2] = 401.0,
            [3] = 501.0,
            [4] = 601.0,
            [5] = 701.0,
            [6] = 802.0,
            [7] = 803.0,
            [8] = 804.0,
            [9] = 704.0,
            [10] = 604.0,
            [11] = 504.0,
            [12] = 404.0,
            [13] = 304.0,
            [14] = 204.0,
            [15] = 203.0
          },
          pieceType = 1
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [14] = {
        action = "CheckMonsterCount",
        args = {
          count = 1,
          monsterid = 5100111,
          trigger = 88
        }
      },
      [15] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [16] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "如果回合开始满血，本回合免死"
    }
  },
  name = "1033 不屈意志",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1500331,
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
