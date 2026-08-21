__SmokeTestCase_Tale = {
  [1] = {
    Next = {10},
    Type = "Infrastructure_Begin"
  },
  [10] = {
    Next = {11},
    Type = "GM_TaleCallPet",
    Data = {1701071}
  },
  [11] = {
    Next = {12},
    Type = "GM_TaleCallPet",
    Data = {1701081}
  },
  [12] = {
    Next = {13},
    Type = "GM_TaleCallPet",
    Data = {1701091}
  },
  [13] = {
    Next = {100},
    Type = "GM_TaleCallPet",
    Data = {1701101}
  },
  [100] = {
    Next = {1000},
    Type = "GM_AddResource",
    Data = {3000001, 50}
  },
  [1000] = {
    Next = {1050, 5000},
    Type = "Tale_BuildTeam"
  },
  [1050] = {
    Next = {1100},
    Type = "Tale_EnterBattle"
  },
  [1100] = {
    Next = {1120},
    Type = "Common_WaitGameEvent",
    Data = {
      GameEventType.LoadingFinish,
      15000
    }
  },
  [1120] = {
    Next = {1125},
    Type = "Common_WaitUnscaledTime",
    Data = {5000}
  },
  [1125] = {
    Next = {1130},
    Type = "Common_ForceCloseStory"
  },
  [1130] = {
    Next = {1140},
    Type = "Common_WaitGameEvent",
    Data = {
      GameEventType.RoundEnterFinish,
      3000
    }
  },
  [1140] = {
    Next = {1145},
    Type = "Common_WaitUnscaledTime",
    Data = {2000}
  },
  [1145] = {
    Next = {1150},
    Type = "Common_EnableAutoBattle",
    Data = {}
  },
  [1150] = {
    Next = {
      [0] = 2000,
      [1] = 3000
    },
    Type = "Common_WaitMatchEnd"
  },
  [2000] = {
    Type = "Common_WaitGameEvent",
    Next = {2100},
    Data = {
      GameEventType.BattleResultFinish,
      5000
    }
  },
  [2100] = {
    Type = "Common_WaitUnscaledTime",
    Next = {2200},
    Data = {3500}
  },
  [2200] = {
    Type = "UISimulate_FakeInput",
    Next = {2300},
    Data = {
      "UIGuideFailedController",
      "bgOnClick"
    }
  },
  [2300] = {
    Type = "Common_WaitUnscaledTime",
    Next = {4000},
    Data = {1000}
  },
  [3000] = {
    Type = "Common_WaitGameEvent",
    Next = {3100},
    Data = {
      GameEventType.BattleResultFinish,
      5000
    }
  },
  [3100] = {
    Type = "Common_ForceCloseStory",
    Next = {3200},
    Data = {}
  },
  [3200] = {
    Type = "Common_WaitUnscaledTime",
    Next = {4000},
    Data = {5000},
    Tip = "等待5秒：等对局结束网络包"
  },
  [4000] = {
    Next = {4100},
    Type = "CTestRobot_Common_ShutdownCoreGame"
  },
  [4100] = {
    Next = {4200},
    Type = "Common_BackToLobby"
  },
  [4200] = {
    Next = {
      [0] = 4300,
      [1] = 100,
      [2] = 4300
    },
    Type = "Mission_CheckMatchResult"
  },
  [4300] = {
    Next = {
      [0] = 100,
      [1] = 5000
    },
    Type = "Common_CheckProgress"
  },
  [5000] = {
    Next = {5100},
    Type = "Common_StopConversationSkipTask"
  },
  [5100] = {
    Next = {5200},
    Type = "CTestRobot_Common_ShutdownCoreGame"
  },
  [5200] = {
    Next = {9000},
    Type = "Common_WaitUnscaledTime",
    Data = {1000}
  },
  [9000] = {
    Next = {},
    Type = "Infrastructure_SilentEnd"
  }
}
return __SmokeTestCase_Tale
