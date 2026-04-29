AutoTest_230216_140303 = {
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
          dir = 1,
          disableai = true,
          id = 527304101,
          name = "e2",
          pos = 803
        }
      },
      [5] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "SetEntityAttack",
        args = {attack = 999999, name = "p1"}
      },
      [8] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "team",
          trigger = 88
        }
      },
      [9] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 702.0,
            [4] = 703.0
          },
          pieceType = 1
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "被杀后自爆"
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
          name = "e1",
          pos = 605
        }
      },
      [3] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 2802103,
          name = "e3",
          pos = 504
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
      [6] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "team",
          trigger = 88
        }
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 703.0,
            [2] = 603.0,
            [3] = 504.0,
            [4] = 604.0
          },
          pieceType = 1
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "踩机关后，被杀不自爆"
    }
  },
  name = "卷轴机关Ⅱ",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1600251,
      level = 200,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1601481,
      level = 200,
      name = "p2"
    },
    [3] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1501421,
      level = 200,
      name = "p3"
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
