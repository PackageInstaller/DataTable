AutoTest_221103_150148 = {
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
        action = "CheckEntityHP",
        args = {
          compare = "==",
          hp = 2388,
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
          pos = 305
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 503
        }
      },
      [6] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 602
        }
      },
      [7] = {
        action = "AddBuffToEntity",
        args = {buffID = 88841046, name = "team"}
      },
      [8] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [9] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "<",
          name = "team",
          trigger = 88
        }
      },
      [10] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 502.0
          }
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [12] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "<",
          name = "team",
          trigger = 88
        }
      },
      [13] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 601.0,
            [3] = 702.0,
            [4] = 603.0
          },
          pieceType = 1
        }
      },
      [14] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "进入战斗时，队伍生命为总生命的30%；每次击杀怪物，队伍恢复3%最大生命值的血量。"
    }
  },
  name = "40046泯没黑暗",
  petList = {
    [1] = {
      awakening = 6,
      equiplv = 1,
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
          [1] = 100403.0
        },
        levelID = 1,
        matchType = 1
      },
      setup = "LevelBasic"
    }
  }
}
