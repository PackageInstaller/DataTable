AutoTest_180 = {
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
          pos = 104
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 204
        }
      },
      [5] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e1",
          trigger = 28
        }
      },
      [6] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e2",
          trigger = 28
        }
      },
      [7] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 0,
          layerType = 2002,
          name = "e1",
          trigger = 28
        }
      },
      [8] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 1,
          layerType = 2002,
          name = "e2",
          trigger = 71
        }
      },
      [9] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 501.0,
            [3] = 401.0,
            [4] = 402.0,
            [5] = 302.0,
            [6] = 202.0
          },
          pieceType = 1
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [11] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 202.0
          },
          pieceType = 0
        }
      },
      [12] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 0,
          layerType = 2002,
          name = "e2",
          trigger = 4
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "1阶段连锁：连线5格，对纵向一列造成伤害"
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
          name = "e3",
          pos = 709
        }
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e4",
          pos = 808
        }
      },
      [4] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e3",
          trigger = 28
        }
      },
      [5] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e4",
          trigger = 28
        }
      },
      [6] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 1,
          layerType = 2002,
          name = "e3",
          trigger = 28
        }
      },
      [7] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 0,
          layerType = 2002,
          name = "e4",
          trigger = 28
        }
      },
      [8] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 202.0,
            [2] = 303.0,
            [3] = 304.0,
            [4] = 405.0,
            [5] = 505.0,
            [6] = 506.0,
            [7] = 507.0,
            [8] = 607.0,
            [9] = 606.0,
            [10] = 605.0
          },
          pieceType = 1
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
            [1] = 605.0
          },
          pieceType = 0
        }
      },
      [11] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 0,
          layerType = 2002,
          name = "e3",
          trigger = 4
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新增测试用例1"
    }
  },
  name = "欧缇连锁技",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1500751,
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
