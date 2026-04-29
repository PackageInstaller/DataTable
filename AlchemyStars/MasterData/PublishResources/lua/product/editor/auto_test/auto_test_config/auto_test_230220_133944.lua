AutoTest_230220_133944 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 505}
      },
      [3] = {
        action = "SetEntityAttack",
        args = {attack = 1000, name = "p1"}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 527107102,
          name = "e1",
          pos = 306
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 527107202,
          name = "e2",
          pos = 404
        }
      },
      [6] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 505.0,
            [2] = 405.0,
            [3] = 304.0,
            [4] = 303.0,
            [5] = 402.0,
            [6] = 401.0,
            [7] = 501.0,
            [8] = 601.0,
            [9] = 701.0,
            [10] = 702.0,
            [11] = 802.0,
            [12] = 903.0
          },
          pieceType = 1
        }
      },
      [7] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "<",
          name = "e2",
          trigger = 88
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "新测试用例"
    }
  },
  name = "回血怪物pro",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1601411,
      level = 200,
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
