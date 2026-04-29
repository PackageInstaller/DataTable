__TestCaseSequence_WorldBoss_Elemental = {
  [1] = {
    Type = "Infrastructure_Begin",
    Next = {2},
    Data = {}
  },
  [2] = {
    Type = "Mission_Cheat_CompleteAllMission",
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
    Type = "WorldBoss_BuildTeam",
    Next = {
      2001,
      9999,
      9999
    }
  },
  [2001] = {
    Type = "GM_AddResource",
    Next = {3130},
    Data = {3000001, 50}
  },
  [3130] = {
    Type = "WorldBoss_EnterBattle",
    Next = {3140},
    Data = {}
  },
  [3140] = {
    Type = "Common_WaitGameEvent",
    Next = {3150, 3150},
    Data = {
      GameEventType.LoadingFinish,
      15000
    },
    Tip = "等待对局开始"
  },
  [3150] = {
    Type = "Common_WaitUnscaledTime",
    Next = {3160},
    Data = {5000}
  },
  [3160] = {
    Type = "Common_ForceCloseStory",
    Next = {3170},
    Data = {}
  },
  [3170] = {
    Type = "Common_WaitGameEvent",
    Next = {3175, 3175},
    Data = {
      GameEventType.RoundEnterFinish,
      3000
    },
    Tip = "等待输入"
  },
  [3175] = {
    Type = "Common_WaitUnscaledTime",
    Next = {3180},
    Data = {2000}
  },
  [3180] = {
    Type = "Common_EnableAutoBattle",
    Next = {3190},
    Data = {},
    Tip = "设置对局自动战斗"
  },
  [3190] = {
    Type = "Common_WaitMatchEnd",
    Next = {
      [0] = 3200,
      [1] = 3300
    },
    Tip = "等待消息[GameEventType.OnGameOver],[0]对局失败,[1]对局成功"
  },
  [3200] = {
    Type = "Common_WaitGameEvent",
    Next = {3210},
    Data = {
      GameEventType.BattleResultFinish,
      5000
    },
    Tip = "等待对局结束"
  },
  [3210] = {
    Type = "Common_WaitUnscaledTime",
    Next = {3220},
    Data = {3500}
  },
  [3220] = {
    Type = "UISimulate_FakeInput",
    Next = {3230},
    Data = {
      "UIGuideFailedController",
      "bgOnClick"
    }
  },
  [3230] = {
    Type = "Common_WaitUnscaledTime",
    Next = {4397},
    Data = {1000}
  },
  [3300] = {
    Type = "Common_WaitGameEvent",
    Next = {3310},
    Data = {
      GameEventType.BattleResultFinish,
      5000
    },
    Tip = "等待对局结束"
  },
  [3310] = {
    Type = "Common_ForceCloseStory",
    Next = {3320},
    Data = {}
  },
  [3320] = {
    Type = "Common_WaitUnscaledTime",
    Next = {4397},
    Data = {5000},
    Tip = "等待5秒：等对局结束网络包"
  },
  [4397] = {
    Type = "CTestRobot_Common_ShutdownCoreGame",
    Next = {4398}
  },
  [4398] = {
    Type = "Common_BackToLobby",
    Next = {4399}
  },
  [4399] = {
    Type = "Common_WaitUnscaledTime",
    Next = {4400},
    Data = {3000}
  },
  [4400] = {
    Type = "Mission_CheckMatchResult",
    Next = {
      [0] = 4410,
      [1] = 4410,
      [2] = 4410
    },
    Data = {},
    Tip = "世界BOSS不能传统地打赢，所以无论如何都走向结束"
  },
  [4410] = {
    Type = "Common_CheckProgress",
    Next = {
      [0] = 2000,
      [1] = 9500
    },
    Data = {},
    Tip = "找下一关"
  },
  [9500] = {
    Type = "Common_StopConversationSkipTask",
    Next = {9501},
    Data = {}
  },
  [9501] = {
    Type = "CTestRobot_Common_ShutdownCoreGame",
    Next = {9502}
  },
  [9502] = {
    Type = "Common_WaitUnscaledTime",
    Data = {5000},
    Next = {9506}
  },
  [9506] = {
    Type = "Common_WaitUnscaledTime",
    Data = {1000},
    Next = {9999}
  },
  [9999] = {
    Type = "Infrastructure_SilentEnd",
    Next = {99},
    Data = {}
  }
}
return __TestCaseSequence_WorldBoss_Elemental
