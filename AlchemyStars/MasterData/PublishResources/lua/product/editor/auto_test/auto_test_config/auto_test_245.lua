AutoTest_245 = {
  cases = {
    [1] = {
      [1] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 504
        }
      },
      [2] = {
        action = "SetEntityHPPercent",
        args = {name = "team", percent = 0.30000001192093}
      },
      [3] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = ">",
          name = "e1",
          trigger = 30
        }
      },
      [4] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 5,
          layerType = 2003,
          name = "e1",
          trigger = 30
        }
      },
      [5] = {
        action = "SetTeamPowerFull",
        args = {}
      },
      [6] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "队伍血线低于40%，大招给怪物加五层流血"
    }
  },
  name = "圣钉主动技-5层流血",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 2,
      id = 1400451,
      level = 1,
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
