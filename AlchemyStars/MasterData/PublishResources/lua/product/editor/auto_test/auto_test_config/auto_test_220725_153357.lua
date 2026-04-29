AutoTest_220725_153357 = {
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
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [4] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [5] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 204
        }
      },
      [8] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 304
        }
      },
      [9] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 404
        }
      },
      [10] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e4",
          pos = 504
        }
      },
      [11] = {
        action = "CheckUIPetLayerCount",
        args = {
          expect = 10,
          name = "p1",
          trigger = 27
        }
      },
      [12] = {
        action = "CheckUIPetLayerCount",
        args = {
          expect = 10,
          name = "p1",
          trigger = 28
        }
      },
      [13] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 403.0,
            [4] = 303.0,
            [5] = 203.0,
            [6] = 104.0,
            [7] = 205.0,
            [8] = 305.0,
            [9] = 405.0,
            [10] = 505.0,
            [11] = 604.0
          },
          pieceType = 1
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [15] = {
        action = "CheckUIPetLayerCount",
        args = {
          expect = 1,
          name = "p1",
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
      name = "普攻提供1能量点；施放后进入过载状态：替换连锁技 若回合结束时能量大于10层，则清空所有剩余层数，下回合仍过载；若少于10层，则保留层数并取消过载状态"
    }
  },
  name = "新测试用例",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1601551,
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
