AutoTest_211221_163218 = {
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
        action = "AddTrap",
        args = {
          dir = 5,
          disableai = true,
          id = 3400,
          name = "j1",
          pos = 709
        }
      },
      [4] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 3401,
          name = "j2",
          pos = 702
        }
      },
      [5] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "team",
          trigger = 88
        }
      },
      [6] = {
        action = "CheckBuffLogic",
        args = {
          exist = true,
          logic = "ATBuffPoision",
          logic_select_index = 0,
          name = "team",
          trigger = 88
        }
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 702.0
          },
          pieceType = 1
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "弩车 毒"
    }
  },
  name = "弩车-毒",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600191,
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
