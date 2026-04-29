AutoTest_221109_160622 = {
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
        action = "CheckEntityAttribute",
        args = {
          attr = "LegendPower",
          expect = 1.0,
          name = "p1",
          trigger = 0
        }
      },
      [5] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "LegendPower",
          expect = 2.0,
          name = "p1",
          trigger = 0
        }
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
        action = "CheckEntityAttribute",
        args = {
          attr = "LegendPower",
          expect = 1.0,
          name = "p1",
          trigger = 0
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [11] = {
        action = "SetEntityHPPercent",
        args = {name = "team", percent = 0.5}
      },
      [12] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "<",
          name = "team",
          trigger = 88
        }
      },
      [13] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0
          },
          pieceType = 1
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [15] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "LegendPower",
          expect = 2.0,
          name = "p1",
          trigger = 0
        }
      },
      [16] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 505.0
          }
        }
      },
      [17] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [18] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [19] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [20] = {
        action = "SetEntityHPPercent",
        args = {name = "team", percent = 0.5}
      },
      [21] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "<",
          name = "team",
          trigger = 88
        }
      },
      [22] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "LegendPower",
          expect = 2.0,
          name = "p1",
          trigger = 0
        }
      },
      [23] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 504.0,
            [2] = 505.0
          },
          pieceType = 1
        }
      },
      [24] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [25] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 506.0
          }
        }
      },
      [26] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "LegendPower",
          expect = 2.0,
          name = "p1",
          trigger = 0
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
        action = "FakeInputDoubleClick",
        args = {}
      },
      [31] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [32] = {
        action = "SetEntityHPPercent",
        args = {name = "team", percent = 0.5}
      },
      [33] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "<",
          name = "team",
          trigger = 88
        }
      },
      [34] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 505.0,
            [2] = 506.0
          },
          pieceType = 1
        }
      },
      [35] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "每回合+1能量。在空格子上召唤加血机关，光灵踩到时会吸收该机关并获得本卡40%攻击力的治疗，怪经过会踩坏； 治疗量会随时间成长，提高到100%/200% 若点击场上已有的机关，会吸收该机关并获得对应阶段的治疗。"
    }
  },
  name = "阿克西娅主动技",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1601751,
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
