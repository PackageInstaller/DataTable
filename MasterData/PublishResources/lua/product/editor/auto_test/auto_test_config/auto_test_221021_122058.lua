AutoTest_221021_122058 = {
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
          pos = 505
        }
      },
      [4] = {
        action = "SetEntityHP",
        args = {hp = 99999, name = "e1"}
      },
      [5] = {
        action = "SetPieceType",
        args = {pieceType = 2}
      },
      [6] = {
        action = "FakeCastSkill",
        args = {
          name = "p2",
          pickUpPos = {
            [1] = 503.0
          }
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 20011,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [9] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 20021,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [10] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 20031,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [11] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 603.0,
            [4] = 703.0,
            [5] = 604.0,
            [6] = 605.0,
            [7] = 506.0
          },
          pieceType = 2
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "怪物无BUFF时，不免疫dot（灼烧/中毒/流血）伤害"
    },
    [2] = {
      [1] = {
        action = "AddBuffToEntity",
        args = {buffID = 102501, name = "e1"}
      },
      [2] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [3] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [4] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [5] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [6] = {
        action = "FakeCastSkill",
        args = {
          name = "p2",
          pickUpPos = {
            [1] = 505.0
          }
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 20011,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [9] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 20021,
          exist = true,
          name = "e1",
          trigger = 88
        }
      },
      [10] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 20031,
          exist = false,
          name = "e1",
          trigger = 88
        }
      },
      [11] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 506.0,
            [2] = 406.0,
            [3] = 405.0,
            [4] = 404.0,
            [5] = 504.0
          },
          pieceType = 2
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "怪物有BUFF时，免疫流血伤害，不免疫中毒/灼烧"
    }
  },
  name = "1025免疫流血",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1500211,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 3,
      equiplv = 1,
      grade = 2,
      id = 1300511,
      level = 1,
      name = "p2"
    },
    [3] = {
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1600191,
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
