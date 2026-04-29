AutoTest_211220_144130 = {
  cases = {
    [1] = {
      [1] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      [2] = {
        action = "AddTrap",
        args = {
          dir = 1,
          disableai = true,
          id = 19,
          name = "e1",
          pos = 504
        }
      },
      [3] = {
        action = "FakeInputChain",
        args = {
          chainPath = {
            [1] = 502.0,
            [2] = 503.0,
            [3] = 504.0
          },
          pieceType = 1
        }
      },
      [4] = {
        action = "WaitGameFsm",
        args = {id = 25}
      },
      [5] = {
        action = "CheckEntityPos",
        args = {
          name = "team",
          pos = 508,
          trigger = 88
        }
      },
      [6] = {
        action = "FakeDimensionDoorPickUp",
        args = {name = "r1", pickUpPos = 508}
      },
      [7] = {
        action = "WaitGameFsm",
        args = {id = 5}
      },
      name = "任意门"
    }
  },
  name = "任意门",
  petList = {
    [1] = {
      awakening = 0,
      equiplv = 1,
      grade = 0,
      id = 1600191,
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
