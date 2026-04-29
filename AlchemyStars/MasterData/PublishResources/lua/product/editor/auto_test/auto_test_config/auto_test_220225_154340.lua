AutoTest_220225_154340 = {
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
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 2100212,
          name = "e1",
          pos = 509
        }
      },
      [5] = {
        action = "FakeCastSkill",
        args = {
          name = "p2",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
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
            [5] = 506.0
          },
          pieceType = 1
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "主动技强化：本回合雷属性光灵的连锁技触发所需要的连线需求-1"
    }
  },
  name = "芙罗琳觉醒2",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1501391,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equiplv = 1,
      grade = 2,
      id = 1601401,
      level = 1,
      name = "p2"
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
