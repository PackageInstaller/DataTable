AutoTest_221103_150418 = {
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
          id = 410081302,
          name = "e1",
          pos = 305
        }
      },
      [4] = {
        action = "SetEntityHPPercent",
        args = {name = "e1", percent = 0.89999997615814}
      },
      [5] = {
        action = "AddBuffToEntity",
        args = {buffID = 88841051, name = "e1"}
      },
      [6] = {
        action = "AddBuffToEntity",
        args = {buffID = 6661005, name = "e1"}
      },
      [7] = {
        action = "AddBuffToEntity",
        args = {buffID = 66610042, name = "e1"}
      },
      [8] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "AttackPercentage",
          expect = 0.029999999329448,
          name = "e1",
          trigger = 88
        }
      },
      [9] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "<",
          name = "e1",
          trigger = 88
        }
      },
      [10] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [11] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [13] = {
        action = "CheckEntityHP",
        args = {
          compare = "==",
          hp = 54250,
          name = "e1",
          trigger = 0
        }
      },
      [14] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "DefencePercentage",
          expect = 0.0,
          name = "e1",
          trigger = 0
        }
      },
      [15] = {
        action = "CheckEntityAttribute",
        args = {
          attr = "DefencePercentage",
          expect = -0.050000000745058,
          name = "e1",
          trigger = 88
        }
      },
      [16] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 402.0,
            [3] = 302.0,
            [4] = 303.0,
            [5] = 304.0
          },
          pieceType = 1
        }
      },
      [17] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "每次光灵释放主动技，场上所有怪物攻击力提升3%并回复3%最大生命值；每当怪物被连锁技命中、减少其5%的防御力。"
    }
  },
  name = "40051技击消长",
  petList = {
    [1] = {
      awakening = 6,
      equiplv = 10,
      grade = 3,
      id = 1600061,
      level = 80,
      name = "p1"
    }
  },
  remotePet = {},
  setup = {
    [1] = {
      args = {
        affixs = {
          [1] = 100902.0
        },
        levelID = 1,
        matchType = 1,
        wordIds = {
          [1] = 40051.0
        }
      },
      setup = "LevelBasic"
    }
  }
}
