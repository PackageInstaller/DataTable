AutoTest_221024_155109 = {
  cases = {
    [1] = {
      [1] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 505
        }
      },
      [2] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 502}
      },
      [3] = {
        action = "AddBuffToEntity",
        args = {buffID = 10470101, name = "e1"}
      },
      [4] = {
        action = "AddBuffToEntity",
        args = {buffID = 10470102, name = "e1"}
      },
      [5] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "FinalBehitDamageParam",
          expect = 1.0,
          name = "e1",
          trigger = 102
        }
      },
      [6] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 0,
          layerType = 10470101,
          name = "e1",
          trigger = 102
        }
      },
      [7] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "FinalBehitDamageParam",
          expect = 0.69999998807907,
          name = "e1",
          trigger = 88
        }
      },
      [8] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 3,
          layerType = 10470101,
          name = "e1",
          trigger = 88
        }
      },
      [9] = {
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
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [11] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "FinalBehitDamageParam",
          expect = 0.89999997615814,
          name = "e1",
          trigger = 102
        }
      },
      [12] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 1,
          layerType = 10470101,
          name = "e1",
          trigger = 102
        }
      },
      [13] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 504.0,
            [2] = 605.0
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
          attr = "FinalBehitDamageParam",
          expect = 1.0,
          name = "e1",
          trigger = 102
        }
      },
      [16] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 0,
          layerType = 10470101,
          name = "e1",
          trigger = 102
        }
      },
      [17] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 605.0,
            [2] = 606.0,
            [3] = 506.0
          },
          pieceType = 1
        }
      },
      [18] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [19] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "FinalBehitDamageParam",
          expect = 0.80000001192093,
          name = "e1",
          trigger = 102
        }
      },
      [20] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 2,
          layerType = 10470101,
          name = "e1",
          trigger = 102
        }
      },
      [21] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 506.0
          }
        }
      },
      [22] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "每回合刷新3层减伤印记，每层减免10%所有类型的伤害，每次受伤减少1层印记"
    }
  },
  name = "104701坚韧I",
  petList = {
    [1] = {
      awakening = 6,
      equiplv = 1,
      grade = 0,
      id = 1600061,
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
