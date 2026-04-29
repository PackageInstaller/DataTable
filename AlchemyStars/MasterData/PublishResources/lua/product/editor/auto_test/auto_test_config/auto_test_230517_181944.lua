AutoTest_230517_181944 = {
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
          pos = 505
        }
      },
      [4] = {
        action = "SetAllMonstersHP",
        args = {value = 23500}
      },
      [5] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [6] = {
        action = "CheckEntityHP",
        args = {
          compare = "==",
          hp = 0,
          name = "e1",
          trigger = 88
        }
      },
      [7] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          },
          skillIndex = 1
        }
      },
      [8] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "精炼3强化：斩杀线提高到攻击力的2.5倍"
    }
  },
  name = "弥加德精炼Ⅲ",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 3,
      equiplv = 10,
      grade = 3,
      id = 1600931,
      level = 80,
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
