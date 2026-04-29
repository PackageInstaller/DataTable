AutoTest_240325_130449 = {
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
        action = "SetOnePieceType",
        args = {pieceType = 4, pos = 503}
      },
      [4] = {
        action = "SetOnePieceType",
        args = {pieceType = 4, pos = 603}
      },
      [5] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          },
          skillIndex = 0
        }
      },
      [8] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 1,
          pos = 503,
          trigger = 88
        }
      },
      [9] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 1,
          pos = 603,
          trigger = 88
        }
      },
      [10] = {
        action = "CheckPetActiveSkillCanCast",
        args = {
          expect = false,
          name = "p1",
          skillID = 30021102,
          trigger = 88
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "将最近的2个雷属性格子转为水属性。该技能释放后，冰塑树影的冷却回合+1"
    }
  },
  name = "查莉娅主动技1",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 0,
      grade = 0,
      id = 1602111,
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
