AutoTest_48 = {
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
        action = "SetEntityHP",
        args = {hp = 999999, name = "team"}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = false,
          id = 5100111,
          name = "e1",
          pos = 504
        }
      },
      [5] = {
        action = "CheckEntityBuffValue",
        args = {
          key = "ReflexiveDamageLayer",
          name = "p1",
          trigger = 0,
          value = 1
        }
      },
      [6] = {
        action = "CheckEntityBuffValue",
        args = {
          key = "ReflexiveDamageLayer",
          name = "p1",
          trigger = 88,
          value = 1
        }
      },
      [7] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0
          },
          pieceType = 1
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "每回合开始获得1个狼魂。首次受到攻击时会消耗1个狼魂对攻击目标造成相当于休拉德100%攻击力的真实伤害。回合结束狼魂清空。"
    }
  },
  name = "休拉德1觉被动技：狼魂",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 1,
      id = 1500361,
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
