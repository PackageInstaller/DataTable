AutoTest_240328_160735 = {
  cases = {
    [1] = {
      [1] = {
        action = "CheckRenderPieceType",
        args = {
          pieceType = 4,
          pos = 505,
          trigger = 88
        }
      },
      [2] = {
        action = "CheckPieceType",
        args = {
          pieceType = 4,
          pos = 505,
          trigger = 88
        }
      },
      [3] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 505.0
          },
          skillIndex = 1
        }
      },
      [4] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "任选一个格子删除，其周围两圈（最多5*5）形成一个特殊区域，然后倒计时15s（不受倍速影响），期间可以如同拼图一样滑动格子块来改变其位置；到时间后空出的格子补为雷属性"
    }
  },
  name = "三十三号主动技",
  petList = {
    [1] = {
      awakening = 0,
      equipRefineLv = 0,
      equiplv = 0,
      grade = 0,
      id = 1502131,
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
