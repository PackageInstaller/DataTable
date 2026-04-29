__TestCaseSequence_Elemental = {
  [1] = {
    Type = "Infrastructure_Begin",
    Next = {2},
    Data = {}
  },
  [2] = {
    Type = "Mission_Cheat_CompleteAllMission",
    Next = {5},
    Data = {}
  },
  [5] = {
    Type = "Common_StartConversationSkipTask",
    Next = {20}
  },
  [20] = {
    Type = "Mission_BuildTeam",
    Next = {
      40,
      500,
      510
    }
  },
  [40] = {
    Type = "GM_AddResource",
    Next = {130},
    Data = {3000001, 50}
  },
  [130] = {
    Type = "Mission_EnterBattle",
    Next = {140},
    Data = {}
  },
  [140] = {
    Type = "Common_WaitGameEvent",
    Next = {150},
    Data = {
      GameEventType.LoadingFinish,
      15000
    },
    Tip = "等待对局开始"
  },
  [150] = {
    Type = "Common_WaitUnscaledTime",
    Next = {160},
    Data = {5000}
  },
  [160] = {
    Type = "Common_ForceCloseStory",
    Next = {170},
    Data = {}
  },
  [170] = {
    Type = "Common_WaitGameEvent",
    Next = {175},
    Data = {
      GameEventType.RoundEnterFinish,
      3000
    },
    Tip = "等待输入"
  },
  [175] = {
    Type = "Common_WaitUnscaledTime",
    Next = {180},
    Data = {2000}
  },
  [180] = {
    Type = "Common_EnableAutoBattle",
    Next = {190},
    Data = {},
    Tip = "设置对局自动战斗"
  },
  [190] = {
    Type = "Common_WaitMatchEnd",
    Next = {
      [0] = 200,
      [1] = 300
    },
    Tip = "等待消息[GameEventType.OnGameOver],[0]对局失败,[1]对局成功"
  },
  [200] = {
    Type = "Common_WaitGameEvent",
    Next = {210},
    Data = {
      GameEventType.BattleResultFinish,
      5000
    },
    Tip = "等待对局结束"
  },
  [210] = {
    Type = "Common_WaitUnscaledTime",
    Next = {220},
    Data = {3500}
  },
  [220] = {
    Type = "UISimulate_FakeInput",
    Next = {230},
    Data = {
      "UIGuideFailedController",
      "bgOnClick"
    }
  },
  [230] = {
    Type = "Common_WaitUnscaledTime",
    Next = {398},
    Data = {1000}
  },
  [300] = {
    Type = "Common_WaitGameEvent",
    Next = {310},
    Data = {
      GameEventType.BattleResultFinish,
      5000
    },
    Tip = "等待对局结束"
  },
  [310] = {
    Type = "Common_ForceCloseStory",
    Next = {320},
    Data = {}
  },
  [320] = {
    Type = "Common_WaitUnscaledTime",
    Next = {398},
    Data = {5000},
    Tip = "等待5秒：等对局结束网络包"
  },
  [398] = {
    Type = "CTestRobot_Common_ShutdownCoreGame",
    Next = {399}
  },
  [399] = {
    Type = "Common_BackToLobby",
    Next = {400}
  },
  [400] = {
    Type = "Mission_CheckMatchResult",
    Next = {
      [0] = 410,
      [1] = 130,
      [2] = 410
    },
    Data = {},
    Tip = "[0]胜利[1]失败[2]多次失败"
  },
  [410] = {
    Type = "Common_CheckProgress",
    Next = {
      [0] = 20,
      [1] = 500
    },
    Data = {},
    Tip = "找下一关"
  },
  [500] = {
    Type = "Common_StopConversationSkipTask",
    Next = {501},
    Data = {}
  },
  [501] = {
    Type = "CTestRobot_Common_ShutdownCoreGame",
    Next = {502}
  },
  [502] = {
    Type = "Common_WaitUnscaledTime",
    Data = {5000},
    Next = {506}
  },
  [506] = {
    Type = "Common_WaitUnscaledTime",
    Data = {1000},
    Next = {510}
  },
  [510] = {
    Type = "Infrastructure_SilentEnd",
    Next = {99},
    Data = {},
    Tip = "关闭自动测试MazeGame的开关"
  }
}
return __TestCaseSequence_Elemental
