AutoTest_5 = {
  cases = {
    [1] = {
      [1] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 505}
      },
      [2] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 606
        }
      },
      [3] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [4] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 505.0
          },
          pieceType = 0
        }
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "斜方向普攻"
    }
  },
  name = "巴顿斜方向普攻",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 1,
      equiplv = 1,
      grade = 1,
      id = 1500421,
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
