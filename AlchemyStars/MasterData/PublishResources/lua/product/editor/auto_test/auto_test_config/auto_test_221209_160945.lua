AutoTest_221209_160945 = {
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
          pos = 305
        }
      },
      [4] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [5] = {
        action = "CheckTrapExist",
        args = {
          exist = true,
          trapIds = {
            [1] = 14.0
          },
          trigger = 88
        },
        exist = true
      },
      [6] = {
        action = "CheckTrapCount",
        args = {
          expect = 2,
          trapIDs = {
            [1] = 14.0
          },
          trigger = 88
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "先制攻击，施放时将场上随机2个非森格转为强化格"
    }
  },
  name = "歌尔蒂突破Ⅲ",
  petList = {
    [1] = {
      awakening = 3,
      equiplv = 1,
      grade = 3,
      id = 1601771,
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
