AutoTest_194 = {
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
          pos = 507
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 508
        }
      },
      [6] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 501.0,
            [3] = 401.0,
            [4] = 402.0,
            [5] = 403.0,
            [6] = 404.0
          },
          pieceType = 1
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [8] = {
        action = "SetEntityHPPercent",
        args = {name = "e1", percent = 0.25}
      },
      [9] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          invert = 0.0,
          name = "e2",
          trigger = 30
        }
      },
      [10] = {
        action = "CheckEntityHP",
        args = {
          compare = "==",
          hp = 0,
          invert = 0.0,
          name = "e1",
          trigger = 30
        }
      },
      [11] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 507.0
          }
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "若造成击杀，在该位置发生爆炸，目标之前每层印记附加库斯库塔攻击力40%的真实伤害"
    }
  },
  name = "库斯库塔主动技强化：击杀后爆炸",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 3,
      id = 1500981,
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
