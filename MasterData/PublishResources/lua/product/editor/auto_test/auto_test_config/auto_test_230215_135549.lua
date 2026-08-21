AutoTest_230215_135549 = {
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
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 208
        }
      },
      [5] = {
        action = "SetAllMonstersHP",
        args = {value = 100000}
      },
      [6] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          },
          skillIndex = 1
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 404.0
          },
          skillIndex = 1
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
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
            [1] = 405.0
          },
          skillIndex = 1
        }
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [16] = {
        action = "FakeInputDoubleClick",
        args = {}
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
            [1] = 406.0
          },
          skillIndex = 1
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
            [1] = 506.0
          },
          skillIndex = 1
        }
      },
      [23] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [24] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [25] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [26] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 606.0
          },
          skillIndex = 1
        }
      },
      [27] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [28] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [29] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [30] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 605.0
          },
          skillIndex = 1
        }
      },
      [31] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [32] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [33] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [34] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 604.0
          },
          skillIndex = 1
        }
      },
      [35] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [36] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 8,
          layerType = 4101850,
          name = "p1",
          trigger = 0
        }
      },
      [37] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [38] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e2",
          trigger = 88
        }
      },
      [39] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 208.0
          },
          skillIndex = 2
        }
      },
      [40] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新主动技：每触发1次被动获得1层，不小于8解锁：cd2（先制）：任选一只怪，然后位移到距离其相邻最近的格子"
    }
  },
  name = "凯亚觉醒Ⅲ",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1501851,
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
