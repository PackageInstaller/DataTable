AutoTest_220221_165952 = {
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
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 403
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 404
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
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e3",
          trigger = 88
        }
      },
      [10] = {
        action = "CheckFormulaAttr",
        args = {
          attr = "baseDamage",
          defname = "e1",
          expect = 1104.0,
          key = "CalcDamage_122",
          skillid = 300131,
          trigger = 102
        }
      },
      [11] = {
        action = "CheckFormulaAttr",
        args = {
          attr = "blood",
          defname = "team",
          expect = 1104.0,
          key = "CalcAddBlood",
          skillid = 300131,
          trigger = 102
        }
      },
      [12] = {
        action = "CheckUIHPShieldExist",
        args = {
          exist = true,
          name = "team",
          trigger = 88
        }
      },
      [13] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "为队伍恢复相当于诺维亚XXX%攻击力的血量，溢出的治疗量将对菱形12格内的所有敌人造成等量伤害，然后获得相当于诺维亚90%生命上限的护盾。"
    }
  },
  name = "诺维亚主动技",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
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
