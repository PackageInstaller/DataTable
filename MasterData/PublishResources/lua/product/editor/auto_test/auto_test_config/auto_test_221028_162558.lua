AutoTest_221028_162558 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "SetEntityHPPercent",
        args = {name = "team", percent = 0.40000000596046}
      },
      [3] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "<",
          name = "team",
          trigger = 88
        }
      },
      [4] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 505}
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 506
        }
      },
      [6] = {
        action = "AddCardByType",
        args = {
          cardTypeList = {
            [1] = 1.0,
            [2] = 2.0,
            [3] = 3.0
          }
        }
      },
      [7] = {
        action = "AddCardByType",
        args = {
          cardTypeList = {
            [1] = 1.0,
            [2] = 2.0,
            [3] = 3.0
          }
        }
      },
      [8] = {
        action = "AddCardByType",
        args = {
          cardTypeList = {
            [1] = 1.0,
            [2] = 2.0,
            [3] = 3.0
          }
        }
      },
      [9] = {
        action = "FakeCastFeatureCardSkill",
        args = {cardCompositionType = 2}
      },
      [10] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "释放特殊技能时回复队伍基础攻击力的60%的血量"
    }
  },
  name = "杰诺觉醒1",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 1,
      id = 1601671,
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
