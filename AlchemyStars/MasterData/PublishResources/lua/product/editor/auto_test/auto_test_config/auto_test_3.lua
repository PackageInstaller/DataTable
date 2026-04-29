AutoTest_3 = {
  cases = {
    [1] = {
      [1] = {
        action = "SetEntityHPPercent",
        args = {name = "team", percent = 0.5}
      },
      [2] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 505}
      },
      [3] = {
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 506
        }
      },
      [5] = {
        action = "SetEntityHP",
        args = {hp = 999999, name = "e1"}
      },
      [6] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 30
        }
      },
      [7] = {
        action = "FakeCastSkill",
        args = {name = "p1"}
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "维多利亚主动技1个敌人"
    },
    [2] = {
      [1] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 905
        }
      },
      [2] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 707
        }
      },
      [3] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e4",
          pos = 802
        }
      },
      [4] = {
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [5] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 30
        }
      },
      [6] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e2",
          trigger = 30
        }
      },
      [7] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e3",
          trigger = 30
        }
      },
      [8] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e4",
          trigger = 30
        }
      },
      [9] = {
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [10] = {
        action = "FakeCastSkill",
        args = {name = "p1"}
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "维多利亚主动技最近3个敌人"
    },
    [3] = {
      [1] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 501}
      },
      [2] = {
        action = "SetEntityPosition",
        args = {name = "e1", pos = 507}
      },
      [3] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 1,
          layerType = 2003,
          name = "e1",
          trigger = 28
        }
      },
      [4] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 501.0,
            [2] = 502.0,
            [3] = 503.0,
            [4] = 504.0,
            [5] = 505.0
          },
          pieceType = 1
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "维多利亚连锁技回血提升50%"
    }
  },
  name = "维多利亚3觉6突10级",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 6,
      equiplv = 1,
      grade = 3,
      id = 1600191,
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
