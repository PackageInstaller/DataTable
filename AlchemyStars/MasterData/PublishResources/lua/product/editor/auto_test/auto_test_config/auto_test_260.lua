AutoTest_260 = {
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
        args = {}
      },
      [4] = {
        action = "AddMonster",
        args = {
          dir = 1,
          disableai = true,
          id = 5100111,
          name = "e1",
          pos = 504
        }
      },
      [5] = {
        action = "CheckEntityChangeHP",
        args = {
          compare = "==",
          name = "e1",
          trigger = 30
        }
      },
      [6] = {
        action = "CheckPieceType",
        args = {
          pieceType = 4,
          pos = 603,
          trigger = 30
        }
      },
      [7] = {
        action = "CheckEntityBuffLayer",
        args = {
          layer = 0,
          layerType = 410054,
          name = "p1",
          trigger = 88
        }
      },
      [8] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 503.0,
            [2] = 603.0
          }
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "1.放置1个存在2回个的灯盏，灯盏定格为雷属性 2.队伍经过回血 3.敌人经过消失"
    }
  },
  name = "娜丁主动技",
  petList = {
    [1] = {
      affinity = 1,
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1400541,
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
