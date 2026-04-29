AutoTest_221028_175334 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 506}
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 507
        }
      },
      [4] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [5] = {
        action = "CheckSanValue",
        args = {
          compare = "==",
          expect = 95,
          trigger = 0
        }
      },
      [6] = {
        action = "CheckCardCount",
        args = {
          compare = "==",
          expect = 1,
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
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [10] = {
        action = "CheckSanValue",
        args = {
          compare = "==",
          expect = 85,
          trigger = 0
        }
      },
      [11] = {
        action = "CheckCardCount",
        args = {
          compare = "==",
          expect = 2,
          trigger = 0
        }
      },
      [12] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [14] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [15] = {
        action = "CheckSanValue",
        args = {
          compare = "==",
          expect = 70,
          trigger = 88
        }
      },
      [16] = {
        action = "CheckCardCount",
        args = {
          compare = "==",
          expect = 3,
          trigger = 88
        }
      },
      [17] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [18] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [19] = {
        action = "CheckSanValue",
        args = {
          compare = "==",
          expect = 50,
          trigger = 88
        }
      },
      [20] = {
        action = "CheckCardCount",
        args = {
          compare = "==",
          expect = 4,
          trigger = 88
        }
      },
      [21] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [22] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [23] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [24] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [25] = {
        action = "CheckSanValue",
        args = {
          compare = "==",
          expect = 45,
          trigger = 88
        }
      },
      [26] = {
        action = "CheckCardCount",
        args = {
          compare = "==",
          expect = 5,
          trigger = 88
        }
      },
      [27] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "全相同卡牌 当前队长获得强化加成，理智值越低加成越高"
    }
  },
  name = "杰诺主动技",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1601671,
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
