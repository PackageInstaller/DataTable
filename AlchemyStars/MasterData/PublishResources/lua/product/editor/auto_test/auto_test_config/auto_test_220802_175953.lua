AutoTest_220802_175953 = {
  cases = {
    [1] = {
      [1] = {
        action = "SetTeamPosition",
        args = {name = "team", pos = 502}
      },
      [2] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 101311,
          name = "e1",
          pos = 305
        }
      },
      [3] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 88
        }
      },
      [4] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 12,
          layerType = 4001580,
          name = "e1",
          trigger = 88
        }
      },
      [5] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 305.0
          }
        }
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "主动强化：对水属性敌人叠12层"
    }
  },
  name = "新岛真觉醒2",
  petList = {
    [1] = {
      awakening = 3,
      equiplv = 1,
      grade = 2,
      id = 1601591,
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
