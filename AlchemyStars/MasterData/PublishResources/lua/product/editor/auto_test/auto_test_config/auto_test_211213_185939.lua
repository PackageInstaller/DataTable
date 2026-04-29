AutoTest_211213_185939 = {
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
          disableai = false,
          id = 5100111,
          name = "e1",
          pos = 503
        }
      },
      [5] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 4101131,
          exist = true,
          name = "p1",
          trigger = 88
        }
      },
      [6] = {
        action = "CheckUIPetLayerCount",
        args = {
          expect = 1,
          name = "p1",
          trigger = 0
        }
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
        action = "CheckUIPetLayerCount",
        args = {
          expect = 0,
          name = "p1",
          trigger = 88
        }
      },
      [9] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "（检查印记）开场携带一个傀儡（类似白水仙的镜子，只是一个称呼不是实体），受到伤害消失，存在时自身防御值提高XXX%，释放主动技刷新傀儡"
    }
  },
  name = "波娜瑟觉醒1",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 1,
      id = 1501131,
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
