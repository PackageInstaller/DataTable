local sequence = {
  [1] = {
    Type = "Infrastructure_Begin",
    Next = {1000},
    Data = {}
  },
  [1000] = {
    Type = "WorldBoss_CheatOpen",
    Next = {1001},
    Data = {}
  },
  [1001] = {
    Type = "WorldBoss_Init",
    Next = {2000}
  },
  [2000] = {
    Type = "SelfTest_RandomBuildTeam",
    Next = {
      2001,
      9999,
      9999
    }
  },
  [2001] = {
    Type = "Common_WaitUnscaledTime",
    Next = {2000},
    Data = {20}
  },
  [9999] = {
    Type = "Infrastructure_SilentEnd",
    Next = {99},
    Data = {}
  }
}
return sequence
