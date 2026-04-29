AutoTest_230116_204148 = {
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
          pos = 308
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 504
        }
      },
      [6] = {
        action = "SetAllMonstersHP",
        args = {value = 99999}
      },
      [7] = {
        action = "AddBuffToEntity",
        args = {buffID = 95012, name = "p1"}
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
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e2",
          trigger = 88
        }
      },
      [10] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e3",
          trigger = 88
        }
      },
      [11] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 402.0,
            [3] = 302.0,
            [4] = 202.0,
            [5] = 103.0,
            [6] = 104.0,
            [7] = 105.0,
            [8] = 106.0,
            [9] = 107.0,
            [10] = 207.0,
            [11] = 208.0
          },
          pieceType = 1
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "秘境中虚影二圈内 不在范围 空放"
    }
  },
  name = "56066-木月白虚影秘境",
  petList = {
    [1] = {
      awakening = 6,
      equiplv = 1,
      grade = 3,
      id = 1601821,
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
