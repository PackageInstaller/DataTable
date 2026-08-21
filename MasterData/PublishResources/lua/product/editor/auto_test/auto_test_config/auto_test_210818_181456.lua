AutoTest_210818_181456 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetPieceType",
        args = {pieceType = 4}
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
          pos = 306
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 307
        }
      },
      [6] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 4100441,
          exist = true,
          name = "p1",
          trigger = 28
        }
      },
      [7] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 4100441,
          exist = true,
          name = "p2",
          trigger = 28
        }
      },
      [8] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0,
            [4] = 505.0,
            [5] = 605.0,
            [6] = 606.0,
            [7] = 506.0
          },
          pieceType = 4
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "连锁技对全部敌人造成伤害时，雷属性光灵本回合获得薇薇安{1}攻击力的攻击加成。"
    }
  },
  name = "薇薇安连锁加攻",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 1,
      equiplv = 1,
      grade = 3,
      id = 1600051,
      level = 10,
      name = "p1"
    },
    [2] = {
      affinity = 1,
      awakening = 1,
      equiplv = 1,
      grade = 1,
      id = 1400441,
      level = 10,
      name = "p2"
    }
  },
  setup = {
    [1] = {
      args = {levelID = 1, matchType = 1},
      setup = "LevelBasic"
    }
  }
}
