AutoTest_221024_174131 = {
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
          pos = 505
        }
      },
      [4] = {
        action = "SetEntityHP",
        args = {hp = 5000, name = "e1"}
      },
      [5] = {
        action = "AddBuffToEntity",
        args = {buffID = 10480101, name = "e1"}
      },
      [6] = {
        action = "AddBuffToEntity",
        args = {buffID = 10480202, name = "e1"}
      },
      [7] = {
        action = "SetEntityAttack",
        args = {attack = 9999, name = "p1"}
      },
      [8] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "CheckEntityHP",
        args = {
          compare = "==",
          hp = 50,
          name = "e1",
          trigger = 102
        }
      },
      [11] = {
        action = "CheckEntityHP",
        args = {
          compare = "==",
          hp = 1300,
          name = "e1",
          trigger = 88
        }
      },
      [12] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 504.0,
            [2] = 505.0,
            [3] = 506.0,
            [4] = 507.0,
            [5] = 508.0
          },
          pieceType = 1
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "1%血量时锁血，之后回复25%最大血量（有BUFF）"
    },
    [2] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 608
        }
      },
      [3] = {
        action = "CheckMonsterCount",
        args = {
          count = 0,
          monsterid = 5100111,
          trigger = 88
        }
      },
      [4] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "1%血量时锁血，之后回复25%最大血量（无BUFF）"
    }
  },
  name = "104802回生II",
  petList = {
    [1] = {
      awakening = 6,
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
