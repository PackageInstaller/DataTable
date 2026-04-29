AutoTest_220119_134911 = {
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
          dir = 5,
          disableai = false,
          id = 6000011,
          name = "e1",
          pos = 505
        }
      },
      [5] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 505.0
          },
          skillid = 290120102,
          trigger = 102
        }
      },
      [6] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [9] = {
        action = "SetOnePieceType",
        args = {pieceType = 3, pos = 405}
      },
      [10] = {
        action = "SetOnePieceType",
        args = {pieceType = 3, pos = 106}
      },
      [11] = {
        action = "SetOnePieceType",
        args = {pieceType = 3, pos = 206}
      },
      [12] = {
        action = "SetOnePieceType",
        args = {pieceType = 3, pos = 306}
      },
      [13] = {
        action = "SetOnePieceType",
        args = {pieceType = 3, pos = 406}
      },
      [14] = {
        action = "SetOnePieceType",
        args = {pieceType = 2, pos = 303}
      },
      [15] = {
        action = "SetOnePieceType",
        args = {pieceType = 3, pos = 304}
      },
      [16] = {
        action = "SetOnePieceType",
        args = {pieceType = 2, pos = 301}
      },
      [17] = {
        action = "SetOnePieceType",
        args = {pieceType = 4, pos = 302}
      },
      [18] = {
        action = "FakeCastSkill",
        args = {
          name = "p2",
          pickUpPos = {
            [1] = 203.0
          }
        }
      },
      [19] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [20] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 202.0,
            [2] = 203.0,
            [3] = 204.0,
            [4] = 302.0,
            [5] = 304.0,
            [6] = 402.0,
            [7] = 403.0,
            [8] = 404.0
          },
          skillid = 290120101,
          trigger = 102
        }
      },
      [21] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [22] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [23] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 202.0
          },
          skillid = 290120102,
          trigger = 102
        }
      },
      [24] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [25] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e1",
          trigger = 88
        }
      },
      [26] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [27] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 5,
          pos = 605,
          trigger = 88
        }
      },
      [28] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 0,
          pos = 605,
          trigger = 88
        }
      },
      [29] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 303.0
          }
        }
      },
      [30] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [31] = {
        action = "SetEntityHPPercent",
        args = {name = "e1", percent = 0.40000000596046}
      },
      [32] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [33] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e1",
          trigger = 88
        }
      },
      [34] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [35] = {
        action = "SetPieceType",
        args = {pieceType = 1}
      },
      [36] = {
        action = "CheckSkillRange",
        args = {
          range = {
            [1] = 105.0,
            [2] = 205.0,
            [3] = 305.0,
            [4] = 405.0,
            [5] = 501.0,
            [6] = 502.0,
            [7] = 503.0,
            [8] = 504.0,
            [9] = 505.0,
            [10] = 506.0,
            [11] = 507.0,
            [12] = 508.0,
            [13] = 509.0,
            [14] = 605.0,
            [15] = 705.0,
            [16] = 805.0,
            [17] = 905.0
          },
          skillid = 290120103,
          trigger = 102
        }
      },
      [37] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 203.0,
            [2] = 304.0,
            [3] = 404.0
          },
          pieceType = 1
        }
      },
      [38] = {
        action = "CheckTrapExist",
        args = {
          exist = true,
          trapIds = {
            [1] = 2901201.0
          },
          trigger = 88
        },
        exist = true
      },
      [39] = {
        action = "CheckTrapExist",
        args = {
          exist = true,
          trapIds = {
            [1] = 2901202.0
          },
          trigger = 88
        },
        exist = true
      },
      [40] = {
        action = "CheckTrapExist",
        args = {
          exist = false,
          trapIds = {
            [1] = 2901203.0
          },
          trigger = 88
        },
        exist = true
      },
      [41] = {
        action = "CheckTrapExist",
        args = {
          exist = true,
          trapIds = {
            [1] = 2901204.0
          },
          trigger = 88
        },
        exist = true
      },
      [42] = {
        action = "CheckEntityPos",
        args = {
          name = "p1",
          pos = 403,
          trigger = 88
        }
      },
      [43] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [44] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [45] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [46] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [47] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [48] = {
        action = "SetTeamPowerFull",
        args = {name = "team", name_select_index = 0}
      },
      [49] = {
        action = "CheckTrapExist",
        args = {
          exist = false,
          trapIds = {
            [1] = 2901201.0
          },
          trigger = 88
        },
        exist = true
      },
      [50] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "<",
          name = "e1",
          trigger = 88
        }
      },
      [51] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "team",
          trigger = 88
        }
      },
      [52] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 403.0
          }
        }
      },
      [53] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [54] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [55] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "技能1+技能2+特殊锁血机关+万色格子+反制"
    }
  },
  name = "祭剑座",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1701071,
      level = 1,
      name = "p1"
    },
    [2] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600111,
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
