AutoTest_211214_152144 = {
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
          pos = 506
        }
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e2",
          pos = 306
        }
      },
      [5] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e3",
          pos = 703
        }
      },
      [6] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [7] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e2",
          trigger = 88
        }
      },
      [8] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e3",
          trigger = 88
        }
      },
      [9] = {
        action = "CheckEntityPos",
        args = {
          name = "p1",
          pos = 504,
          trigger = 88
        }
      },
      [10] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [11] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "菱形12格位移，然后对周围两圈（挖去四个角）造成伤害"
    }
  },
  name = "克主动技",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 0,
      grade = 0,
      id = 1601171,
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
