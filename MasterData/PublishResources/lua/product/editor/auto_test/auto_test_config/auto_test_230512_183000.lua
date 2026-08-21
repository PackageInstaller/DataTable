AutoTest_230512_183000 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetEntityPosition",
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
          pos = 506
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 507
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e4",
          pos = 605
        }
      },
      [7] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e5",
          pos = 606
        }
      },
      [8] = {
        action = "SetAllMonstersHP",
        args = {value = 999999}
      },
      [9] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 1,
          layerType = 4300231,
          name = "p1",
          trigger = 88
        }
      },
      [10] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 702.0,
            [4] = 603.0,
            [5] = 503.0
          },
          pieceType = 1
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [12] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 2,
          layerType = 4300231,
          name = "p1",
          trigger = 88
        }
      },
      [13] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 503.0,
            [2] = 403.0,
            [3] = 303.0,
            [4] = 304.0,
            [5] = 404.0
          },
          pieceType = 1
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [15] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 3,
          layerType = 4300231,
          name = "p1",
          trigger = 88
        }
      },
      [16] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 404.0,
            [2] = 304.0,
            [3] = 204.0,
            [4] = 104.0,
            [5] = 203.0
          },
          pieceType = 1
        }
      },
      [17] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [18] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [19] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 4,
          layerType = 4300231,
          name = "p1",
          trigger = 88
        }
      },
      [20] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 203.0,
            [2] = 303.0,
            [3] = 403.0,
            [4] = 503.0,
            [5] = 603.0
          },
          pieceType = 1
        }
      },
      [21] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [22] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 5,
          layerType = 4300231,
          name = "p1",
          trigger = 88
        }
      },
      [23] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 603.0,
            [2] = 703.0,
            [3] = 804.0,
            [4] = 905.0,
            [5] = 906.0
          },
          pieceType = 1
        }
      },
      [24] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [25] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 5,
          layerType = 4300231,
          name = "p1",
          trigger = 88
        }
      },
      [26] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 906.0,
            [2] = 907.0,
            [3] = 808.0,
            [4] = 709.0,
            [5] = 609.0
          },
          pieceType = 1
        }
      },
      [27] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [28] = {
        action = "CheckBuffLogic",
        args = {
          exist = true,
          logic = "ATBuffSCared",
          name = "e1",
          trigger = 88
        }
      },
      [29] = {
        action = "CheckBuffLogic",
        args = {
          exist = true,
          logic = "ATBuffSCared",
          name = "e2",
          trigger = 88
        }
      },
      [30] = {
        action = "CheckBuffLogic",
        args = {
          exist = true,
          logic = "ATBuffSCared",
          name = "e3",
          trigger = 88
        }
      },
      [31] = {
        action = "CheckBuffLogic",
        args = {
          exist = true,
          logic = "ATBuffSCared",
          name = "e4",
          trigger = 88
        }
      },
      [32] = {
        action = "CheckBuffLogic",
        args = {
          exist = true,
          logic = "ATBuffSCared",
          name = "e5",
          trigger = 88
        }
      },
      [33] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 507.0
          },
          skillIndex = 1
        }
      },
      [34] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [35] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [36] = {
        action = "CheckBuffLogic",
        args = {
          exist = false,
          logic = "ATBuffSCared",
          name = "e1",
          trigger = 88
        }
      },
      [37] = {
        action = "CheckBuffLogic",
        args = {
          exist = false,
          logic = "ATBuffSCared",
          name = "e2",
          trigger = 88
        }
      },
      [38] = {
        action = "CheckBuffLogic",
        args = {
          exist = false,
          logic = "ATBuffSCared",
          name = "e3",
          trigger = 88
        }
      },
      [39] = {
        action = "CheckBuffLogic",
        args = {
          exist = false,
          logic = "ATBuffSCared",
          name = "e4",
          trigger = 88
        }
      },
      [40] = {
        action = "CheckBuffLogic",
        args = {
          exist = false,
          logic = "ATBuffSCared",
          name = "e5",
          trigger = 88
        }
      },
      [41] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [42] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "释放连锁技可获得1层颤栗印记，最大5层。每层印记增加{1}主动技伤害。使用主动技可恐惧等同于印记层数的敌人1回合。"
    }
  },
  name = "克娜莉觉醒Ⅰ",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 1,
      grade = 1,
      id = 1600231,
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
