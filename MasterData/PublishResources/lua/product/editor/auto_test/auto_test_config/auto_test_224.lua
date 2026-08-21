AutoTest_224 = {
  cases = {
    [1] = {
      [1] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 605
        }
      },
      [2] = {
        action = "SetPieceType",
        args = {pieceType = 3}
      },
      [3] = {
        action = "SetOnePieceType",
        args = {pieceType = 1, pos = 504}
      },
      [4] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "ActiveSkillIncreaseParam",
          attr_select_index = 1,
          expect = 1.0700000524521,
          name = "p1",
          trigger = 88
        }
      },
      [5] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "ChainSkillIncreaseParam",
          attr_select_index = 32,
          expect = 1.1399999856949,
          name = "p1",
          trigger = 88
        }
      },
      [6] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "NormalSkillIncreaseParam",
          attr_select_index = 20,
          expect = 1.0700000524521,
          name = "p1",
          trigger = 88
        }
      },
      [7] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "主动技强化：基础攻击6次，根据周围12格判断"
    }
  },
  name = "薇丝突觉3突5：印记强化",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 5,
      equiplv = 1,
      grade = 3,
      id = 1500331,
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
