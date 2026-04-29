AutoTest_221027_183851 = {
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
        action = "WaitGameFsm",
        args = {id = 5}
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
        action = "CheckSanValue",
        args = {
          compare = "==",
          expect = 85,
          trigger = 0
        }
      },
      [10] = {
        action = "CheckCardCount",
        args = {
          compare = "==",
          expect = 2,
          trigger = 0
        }
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
            [1] = 504.0
          }
        }
      },
      [13] = {
        action = "CheckSanValue",
        args = {
          compare = "==",
          expect = 70,
          trigger = 88
        }
      },
      [14] = {
        action = "CheckCardCount",
        args = {
          compare = "==",
          expect = 3,
          trigger = 88
        }
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
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
        action = "CheckSanValue",
        args = {
          compare = "==",
          expect = 50,
          trigger = 88
        }
      },
      [18] = {
        action = "CheckCardCount",
        args = {
          compare = "==",
          expect = 4,
          trigger = 88
        }
      },
      [19] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [20] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [21] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [22] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [23] = {
        action = "CheckSanValue",
        args = {
          compare = "==",
          expect = 45,
          trigger = 88
        }
      },
      [24] = {
        action = "CheckCardCount",
        args = {
          compare = "==",
          expect = 5,
          trigger = 88
        }
      },
      [25] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "消耗5点理智值生成一张卡牌，回合内再次释放会提高5点消耗"
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
