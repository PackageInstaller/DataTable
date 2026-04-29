AutoTest_220224_104554 = {
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
        action = "SetOnePieceType",
        args = {pieceType = 3, pos = 505}
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 5,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 505
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 5,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 606
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
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e2",
          trigger = 88
        }
      },
      [9] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 10042,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [10] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [12] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "对全场敌人造成{1}%伤害，减速处于森格子上的敌人"
    }
  },
  name = "露科亚主动技",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1501361,
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
