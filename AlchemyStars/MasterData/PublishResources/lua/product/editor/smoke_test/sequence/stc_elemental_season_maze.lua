local TestCaseSequence_ElementalSeasonMaze = {
  [1] = {
    Type = "Infrastructure_Begin",
    Next = {10},
    Data = {}
  },
  [10] = {
    Type = "Common_WaitUnscaledTime",
    Next = {13},
    Data = {3000}
  },
  [13] = {
    Type = "GM_SeasonMazeReset",
    Next = {14},
    Data = {}
  },
  [14] = {
    Type = "GM_SeasonMazeLevelDifficulty",
    Data = {1},
    Next = {15},
    Tip = "设置通关难度1"
  },
  [15] = {
    Type = "GM_SeasonMazeLevelDifficulty",
    Data = {2},
    Next = {16},
    Tip = "设置通关难度2"
  },
  [16] = {
    Type = "GM_SeasonMazeLevelDifficulty",
    Data = {3},
    Next = {17},
    Tip = "设置通关难度3"
  },
  [17] = {
    Type = "GM_SeasonMazeLevelDifficulty",
    Data = {4},
    Next = {18},
    Tip = "设置通关难度4"
  },
  [18] = {
    Type = "GM_SetWhiteTestSeasonMazeTrue",
    Data = {},
    Next = {19},
    Tip = "设置服务器白盒模式"
  },
  [19] = {
    Type = "Common_WaitUnscaledTime",
    Next = {20},
    Data = {3000}
  },
  [20] = {
    Type = "CTestRobot_ShowUI",
    Next = {31},
    Data = {
      "UISeasonMazeEnterController"
    },
    Tip = "打开赛季秘境入口"
  },
  [31] = {
    Type = "Common_WaitUnscaledTime",
    Next = {34},
    Data = {500}
  },
  [34] = {
    Type = "CTestRobot_ShowUI",
    Next = {35},
    Data = {
      "UISeasonMazePetsTeamsPrimary",
      3
    },
    Tip = "选择难度3"
  },
  [35] = {
    Type = "SeasonMaze_SetTeamsPrimary",
    Next = {36},
    Data = {},
    Tip = "跳过组队界面"
  },
  [36] = {
    Type = "Common_WaitUnscaledTime",
    Next = {40},
    Data = {5000},
    Tip = "切换地图，这里等待3000在测试机上会卡死"
  },
  [40] = {
    Type = "GM_SeasonMazeAddItem",
    Next = {41},
    Data = {
      1,
      3,
      99
    },
    Tip = "添加倒计时"
  },
  [41] = {
    Type = "GM_SeasonMazeAddAllBead",
    Next = {42},
    Data = {6},
    Tip = "添加自动珠"
  },
  [42] = {
    Type = "GM_SeasonMazeAddAllRelic",
    Next = {43},
    Data = {10},
    Tip = "添加圣物"
  },
  [43] = {
    Type = "Common_WaitUnscaledTime",
    Next = {49},
    Data = {500}
  },
  [49] = {
    Type = "SeasonMaze_BuildTeam",
    Next = {
      50,
      500,
      510
    },
    Tip = "创建队伍"
  },
  [50] = {
    Type = "Common_StartConversationSkipTask",
    Next = {51}
  },
  [51] = {
    Type = "SeasonMaze_EnterBattle",
    Next = {140},
    Data = {}
  },
  [140] = {
    Type = "Common_WaitGameEvent",
    Next = {150, 150},
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
    Next = {175, 175},
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
    Next = {211},
    Data = {3500}
  },
  [211] = {
    Type = "Common_ForceCloseStory",
    Next = {220},
    Data = {}
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
      [1] = 50,
      [2] = 410
    },
    Data = {},
    Tip = "[0]胜利[1]失败[2]多次失败"
  },
  [410] = {
    Type = "Common_CheckProgress",
    Next = {
      [0] = 49,
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
    Next = {9999},
    Data = {},
    Tip = "关闭自动测试MazeGame的开关"
  }
}
return TestCaseSequence_ElementalSeasonMaze
