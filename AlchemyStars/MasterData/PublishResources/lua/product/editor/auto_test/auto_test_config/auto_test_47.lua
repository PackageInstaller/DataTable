AutoTest_47 = {
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
          disableai = false,
          id = 5100111,
          name = "e1",
          pos = 305
        }
      },
      [4] = {
        action = "SetTeamPowerFull",
        args = {}
      },
      [5] = {
        action = "SetEntityHPPercent",
        args = {name = "team", percent = 0.5}
      },
      [6] = {
        action = "CheckEntityBuff",
        args = {
          buffId = 30021,
          exist = true,
          name = "team",
          trigger = 30
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
      [9] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0
          },
          pieceType = 0
        }
      },
      [10] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "<",
          name = "team",
          trigger = 9
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "护盾消失时，将剩余护盾值的30%转化为生命。"
    }
  },
  name = "诺尔被动技：护盾回血",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 10,
      grade = 1,
      id = 1500131,
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
