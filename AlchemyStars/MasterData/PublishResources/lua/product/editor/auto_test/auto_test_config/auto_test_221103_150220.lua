AutoTest_221103_150220 = {
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
          pos = 504
        }
      },
      [5] = {
        action = "SetAllMonstersHPPercent",
        args = {percent = 0.5}
      },
      [6] = {
        action = "AddBuffToEntity",
        args = {buffID = 88841019, name = "e1"}
      },
      [7] = {
        action = "CheckAttributeChange",
        args = {
          attr = "HP",
          cmp = "<",
          name = "e1",
          trigger = 88
        }
      },
      [8] = {
        action = "CheckEntityHP",
        args = {
          compare = "==",
          hp = 5263,
          name = "e1",
          trigger = 88
        }
      },
      [9] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 603.0,
            [3] = 604.0,
            [4] = 505.0,
            [5] = 404.0,
            [6] = 503.0
          },
          pieceType = 1
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "怪物死亡时，其他怪物回满血"
    }
  },
  name = "40019死亡复苏",
  petList = {
    [1] = {
      awakening = 6,
      equiplv = 1,
      grade = 3,
      id = 1600061,
      level = 80,
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
