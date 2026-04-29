AutoTest_221103_150139 = {
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
          pos = 305
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 503
        }
      },
      [5] = {
        action = "AddBuffToEntity",
        args = {buffID = 88841050, name = "e1"}
      },
      [6] = {
        action = "AddBuffToEntity",
        args = {buffID = 88842050, name = "p1"}
      },
      [7] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
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
            [1] = 504.0,
            [2] = 503.0,
            [3] = 502.0
          },
          pieceType = 1
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [12] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "DefencePercentage",
          expect = -0.25,
          name = "e1",
          trigger = 0
        }
      },
      [13] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "DefencePercentage",
          expect = -0.25,
          name = "p1",
          trigger = 0
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "每当场上有怪物死亡，所有光灵和和寂静君王各减少25%防御力。"
    }
  },
  name = "40050融光寂静",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 2,
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
