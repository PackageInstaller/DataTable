AutoTest_220228_114824 = {
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
        action = "CheckEntityAttribute",
        args = {
          attr = "Ready",
          expect = 1.0,
          name = "p1",
          trigger = 0
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 504
        }
      },
      [5] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [6] = {
        action = "CheckFormulaAttr",
        args = {
          attr = "baseDamage",
          defname = "e1",
          expect = 5046.0,
          key = "CalcDamage_122",
          skillid = 326131,
          trigger = 102
        }
      },
      [7] = {
        action = "CheckFormulaAttr",
        args = {
          attr = "blood",
          defname = "team",
          expect = 5046.0,
          key = "CalcAddBlood",
          skillid = 326131,
          trigger = 102
        }
      },
      [8] = {
        action = "CheckUIHPShieldExist",
        args = {
          exist = true,
          name = "team",
          trigger = 88
        }
      },
      [9] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "突3：先制攻击 突6：主动技的护盾系数提高30%"
    }
  },
  name = "诺维亚突3突6",
  petList = {
    [1] = {
      awakening = 6,
      equiplv = 1,
      grade = 3,
      id = 1601311,
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
