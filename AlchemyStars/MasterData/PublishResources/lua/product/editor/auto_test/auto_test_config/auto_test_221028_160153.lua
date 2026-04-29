AutoTest_221028_160153 = {
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
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [4] = {
        action = "CheckSanValue",
        args = {
          compare = "==",
          expect = 95,
          trigger = 0
        }
      },
      [5] = {
        action = "CheckCardCount",
        args = {
          compare = "==",
          expect = 1,
          trigger = 0
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [8] = {
        action = "CheckSanValue",
        args = {
          compare = "==",
          expect = 85,
          trigger = 0
        }
      },
      [9] = {
        action = "CheckCardCount",
        args = {
          compare = "==",
          expect = 2,
          trigger = 0
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [11] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [12] = {
        action = "CheckSanValue",
        args = {
          compare = "==",
          expect = 70,
          trigger = 88
        }
      },
      [13] = {
        action = "CheckCardCount",
        args = {
          compare = "==",
          expect = 3,
          trigger = 88
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
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
        action = "CheckSanValue",
        args = {
          compare = "==",
          expect = 50,
          trigger = 88
        }
      },
      [17] = {
        action = "CheckCardCount",
        args = {
          compare = "==",
          expect = 4,
          trigger = 88
        }
      },
      [18] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [19] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [20] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [21] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [22] = {
        action = "CheckSanValue",
        args = {
          compare = "==",
          expect = 45,
          trigger = 88
        }
      },
      [23] = {
        action = "CheckCardCount",
        args = {
          compare = "==",
          expect = 5,
          trigger = 88
        }
      },
      [24] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [25] = {
        action = "AddCardByType",
        args = {
          cardTypeList = {
            [1] = 1.0,
            [2] = 2.0,
            [3] = 3.0
          }
        }
      },
      [26] = {
        action = "AddCardByType",
        args = {
          cardTypeList = {
            [1] = 1.0,
            [2] = 2.0,
            [3] = 3.0
          }
        }
      },
      [27] = {
        action = "FakeCastFeatureCardSkill",
        args = {cardCompositionType = 6}
      },
      [28] = {
        action = "CheckSanValue",
        args = {
          compare = "==",
          expect = 55,
          trigger = 88
        }
      },
      [29] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "ChangeTeamLeaderCount",
          expect = 4.0,
          name = "team",
          trigger = 88
        }
      },
      [30] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [31] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "两个相同的卡牌释放后队长次数+1，回复18%理智值"
    }
  },
  name = "杰诺特殊技能",
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
      args = {levelID = 1000106, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
