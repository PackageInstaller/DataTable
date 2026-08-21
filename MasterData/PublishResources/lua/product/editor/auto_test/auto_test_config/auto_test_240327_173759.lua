AutoTest_240327_173759 = {
  cases = {
    [1] = {
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
          pos = 404
        }
      },
      [3] = {
        action = "SetEntityPosition",
        args = {name = "p1", pos = 502}
      },
      [4] = {
        action = "CheckUIPetLayerCount",
        args = {
          expect = 1,
          name = "p1",
          trigger = 102
        }
      },
      [5] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 505.0
          },
          skillIndex = 1
        }
      },
      [6] = {
        action = "CheckTrapExist",
        args = {
          exist = true,
          trapIds = {
            [1] = 1.6021611E7
          },
          trigger = 88
        },
        exist = true
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e1",
          trigger = 88
        }
      },
      [9] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0
          },
          pieceType = 1
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [11] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [12] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 503.0,
            [2] = 604.0,
            [3] = 505.0
          },
          pieceType = 1
        }
      },
      [13] = {
        action = "CheckTrapExist",
        args = {
          exist = false,
          trapIds = {
            [1] = 1.6021611E7
          },
          trigger = 88
        },
        exist = true
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "消耗3点能量（战斗开始时获得3点，此后每回合1点）。任选1格，在其周围2圈内再形成一个3*3范围的结界。范围内普攻可攻击斜方向，结界持续2回合"
    }
  },
  name = "璇极主动技",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 0,
      grade = 0,
      id = 1602161,
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
