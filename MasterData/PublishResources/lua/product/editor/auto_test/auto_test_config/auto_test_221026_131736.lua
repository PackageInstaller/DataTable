AutoTest_221026_131736 = {
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
        action = "SetEntityAttack",
        args = {attack = 999999, name = "p1"}
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
        action = "AddBuffToEntity",
        args = {buffID = 10580101, name = "e1"}
      },
      [6] = {
        action = "CheckMonsterCount",
        args = {
          count = 1,
          monsterid = 5100111,
          trigger = 88
        }
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 702.0,
            [4] = 802.0,
            [5] = 803.0,
            [6] = 703.0,
            [7] = 603.0,
            [8] = 503.0,
            [9] = 504.0,
            [10] = 604.0,
            [11] = 704.0,
            [12] = 605.0,
            [13] = 505.0,
            [14] = 405.0,
            [15] = 406.0,
            [16] = 306.0,
            [17] = 206.0
          },
          pieceType = 1
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [9] = {
        action = "CheckMonsterCount",
        args = {
          count = 0,
          monsterid = 5100111,
          trigger = 88
        }
      },
      [10] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "受到致命伤害后不会立即死亡，一直撑到回合结束后"
    }
  },
  name = "死亡迟滞",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1400071,
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
