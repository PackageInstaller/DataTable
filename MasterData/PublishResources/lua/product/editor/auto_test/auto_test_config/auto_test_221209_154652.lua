AutoTest_221209_154652 = {
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
          pos = 607
        }
      },
      [4] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 602.0,
            [3] = 702.0,
            [4] = 802.0,
            [5] = 701.0,
            [6] = 601.0,
            [7] = 501.0,
            [8] = 402.0,
            [9] = 403.0
          },
          pieceType = 1
        }
      },
      [5] = {
        action = "CheckTrapExist",
        args = {
          exist = true,
          trapIds = {
            [1] = 14.0
          },
          trigger = 102
        },
        exist = true
      },
      [6] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [7] = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      },
      [8] = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {
            [1] = 504.0
          }
        }
      },
      [9] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [10] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 403.0,
            [2] = 503.0,
            [3] = 603.0,
            [4] = 703.0,
            [5] = 803.0,
            [6] = 903.0,
            [7] = 904.0,
            [8] = 804.0,
            [9] = 704.0,
            [10] = 604.0
          },
          pieceType = 1
        }
      },
      [11] = {
        action = "CheckTrapCount",
        args = {
          expect = 1,
          trapIDs = {
            [1] = 14.0
          },
          trigger = 0
        }
      },
      [12] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "偶像形态连锁技强化：全场随机1/2/3个非森格转为强化格"
    }
  },
  name = "歌尔蒂觉醒Ⅱ",
  petList = {
    [1] = {
      awakening = 2,
      equiplv = 2,
      grade = 2,
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
