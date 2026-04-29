AutoTest_211223_183730 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetTeamPosition",
        args = {pos = 502}
      },
      [3] = {
        action = "CheckGridTrap",
        args = {
          exist = true,
          pos = 504,
          trapIds = {
            [1] = 14.0
          },
          trigger = 88
        }
      },
      [4] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 2,
          pos = 504,
          trigger = 88
        }
      },
      [5] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "1.突2：主动技强化：目标所选格子转色为火属性强化格子 2、突5：先制攻击"
    }
  },
  name = "泷突2突5",
  petList = {
    [1] = {
      awakening = 5,
      equiplv = 1,
      grade = 3,
      id = 1500711,
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
