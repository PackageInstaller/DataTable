AutoTest_220224_161752 = {
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
        action = "SetPieceType",
        args = {pieceType = 2}
      },
      [4] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 3,
          pos = 406,
          trigger = 88
        }
      },
      [5] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 3,
          pos = 407,
          trigger = 88
        }
      },
      [6] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 3,
          pos = 506,
          trigger = 88
        }
      },
      [7] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 3,
          pos = 507,
          trigger = 88
        }
      },
      [8] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "Ready",
          attr_select_index = 11,
          expect = 1.0,
          name = "p1",
          trigger = 0
        }
      },
      [9] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 506.0,
            [2] = 407.0
          }
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "突3：先制攻击 突6：被动强化：触发时若被动不少于10层，额外获得等同于希诺普最大生命15%的护盾"
    }
  },
  name = "希诺普主动技",
  petList = {
    [1] = {
      awakening = 6,
      equiplv = 1,
      grade = 3,
      id = 1601381,
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
