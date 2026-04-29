AutoTest_230713_150840 = {
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
          pos = 509
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 508
        }
      },
      [5] = {
        action = "SetEntityAttack",
        args = {attack = 999999, name = "p1"}
      },
      [6] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 509.0
          },
          skillIndex = 1
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "FakeInputDoubleClick",
        args = {}
      },
      [11] = {
        action = "CheckPetActiveSkillCanCast",
        args = {
          expect = true,
          name = "p1",
          skillID = 3002041,
          trigger = 88
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "处于圣决状态下，主动技强化：目标死亡后立即刷新cd"
    }
  },
  name = "约书亚精炼3",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 3,
      equiplv = 1,
      grade = 3,
      id = 1602041,
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
