AutoTest_2 = {
  cases = {
    [1] = {
      [1] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 501}
      },
      [2] = {
        action = "AddMonster",
        args = {
          aipath = {
            [1] = 403.0,
            [2] = 503.0
          },
          dir = 1,
          disableai = false,
          id = 5100111,
          name = "e1",
          pos = 303
        }
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 305
        }
      },
      [4] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "team"}
      },
      [5] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "e1"}
      },
      [6] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "e2"}
      },
      [7] = {
        action = "SetTeamPowerFull",
        args = {}
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
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 501.0
          },
          pieceType = 1
        }
      },
      [11] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 1,
          layerType = 2002,
          name = "e1",
          trigger = 88
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "莱斯特大招"
    },
    [2] = {
      [1] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 501}
      },
      [2] = {
        action = "SetEntityPosition",
        args = {name = "e1", pos = 303}
      },
      [3] = {
        action = "SetEntityPosition",
        args = {name = "e2", pos = 305}
      },
      [4] = {
        action = "SetPieceType",
        args = {pieceType = 3}
      },
      [5] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 3,
          layerType = 2002,
          name = "e1",
          trigger = 28
        }
      },
      [6] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 0,
          layerType = 2002,
          name = "e2",
          trigger = 28
        }
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 501.0,
            [2] = 502.0,
            [3] = 503.0,
            [4] = 504.0,
            [5] = 505.0
          },
          pieceType = 3
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "莱斯特连锁技1"
    },
    [3] = {
      [1] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 501}
      },
      [2] = {
        action = "SetEntityPosition",
        args = {name = "e1", pos = 202}
      },
      [3] = {
        action = "SetEntityPosition",
        args = {name = "e2", pos = 808}
      },
      [4] = {
        action = "SetPieceType",
        args = {pieceType = 3}
      },
      [5] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 5,
          layerType = 2002,
          name = "e1",
          trigger = 28
        }
      },
      [6] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 1,
          layerType = 2002,
          name = "e2",
          trigger = 28
        }
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 501.0,
            [2] = 601.0,
            [3] = 502.0,
            [4] = 602.0,
            [5] = 503.0,
            [6] = 603.0,
            [7] = 504.0,
            [8] = 604.0,
            [9] = 505.0
          },
          pieceType = 3
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "莱斯特连锁技2"
    }
  },
  name = "莱斯特3觉3突10级",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 3,
      equiplv = 1,
      grade = 3,
      id = 1400951,
      level = 10,
      name = "p1"
    }
  },
  setup = {
    [1] = {
      args = {levelID = 1, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
