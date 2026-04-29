AutoTest_220224_132717 = {
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
          id = 2071313,
          name = "e1",
          pos = 505
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 5,
          disableai = true,
          id = 2071313,
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
          buffId = 4001361,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [10] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 2,
          layerType = 400136,
          name = "e1",
          trigger = 88
        }
      },
      [11] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 2,
          layerType = 400136,
          name = "e2",
          trigger = 88
        }
      },
      [12] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [13] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [14] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [15] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "主动技强化:造成伤害前,附加2层被动"
    }
  },
  name = "露科亚觉醒2",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 2,
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
