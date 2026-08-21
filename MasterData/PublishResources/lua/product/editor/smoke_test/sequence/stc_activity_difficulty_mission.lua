local difficultyMissionSequence = {
  [1] = {
    Type = "Infrastructure_Begin",
    Next = {9},
    Data = {}
  },
  [9] = {
    Type = "Mission_Cheat_CompleteAllMission",
    Next = {10},
    Data = {}
  },
  [10] = {
    Type = "GM_OpenAllCampaign",
    Next = {40},
    Data = {}
  },
  [40] = {
    Type = "GM_AddResource",
    Next = {50},
    Data = {3000001, 50}
  },
  [50] = {
    Type = "Common_StartConversationSkipTask",
    Next = {100001}
  },
  [100001] = {
    Type = "GM_PassLineCampMission",
    Next = {100002},
    Data = {108100504, 5271014}
  },
  [100002] = {
    Type = "GM_PassLineCampMission",
    Next = {100003},
    Data = {108100504, 5271015}
  },
  [100003] = {
    Type = "GM_PassLineCampMission",
    Next = {51},
    Data = {108100505, 5272004}
  },
  [51] = {
    Type = "GM_PassLineCampMission",
    Next = {52},
    Data = {108100505, 5272001}
  },
  [52] = {
    Type = "GM_PassLineCampMission",
    Next = {53},
    Data = {108100505, 5272002}
  },
  [53] = {
    Type = "GM_PassLineCampMission",
    Next = {54},
    Data = {108100505, 5272003}
  },
  [54] = {
    Type = "GM_PassLineCampMission",
    Next = {56},
    Data = {108100505, 5272004}
  },
  [56] = {
    Type = "GM_PassLineCampMissionSingle",
    Next = {57},
    Data = {108100505, 5272001}
  },
  [57] = {
    Type = "GM_PassLineCampMissionSingle",
    Next = {58},
    Data = {108100505, 5272002}
  },
  [58] = {
    Type = "GM_PassLineCampMissionSingle",
    Next = {59},
    Data = {108100505, 5272003}
  },
  [59] = {
    Type = "GM_PassLineCampMissionSingle",
    Next = {1020},
    Data = {108100505, 5272004}
  },
  [1020] = {
    Type = "GoldbergEvent_BuildTeam",
    Next = {
      1030,
      1500,
      1510
    }
  },
  [1030] = {
    Type = "GoldbergEvent_ExpensionSupport",
    Next = {1040}
  },
  [1040] = {
    Type = "GM_AddResource",
    Next = {1041},
    Data = {3000001, 50}
  },
  [1041] = {
    Type = "GoldbergEvent_Cheat_AddActionPoint",
    Next = {1050},
    Data = {50}
  },
  [1050] = {
    Type = "Common_StartConversationSkipTask",
    Next = {1130}
  },
  [1130] = {
    Type = "GoldbergEvent_EnterSelectBattle",
    Next = {1140},
    Data = {}
  },
  [1140] = {
    Type = "Common_WaitGameEvent",
    Next = {1150, 1150},
    Data = {
      GameEventType.LoadingFinish,
      15000
    },
    Tip = "等待对局开始"
  },
  [1150] = {
    Type = "Common_WaitUnscaledTime",
    Next = {1160},
    Data = {5000}
  },
  [1160] = {
    Type = "Common_ForceCloseStory",
    Next = {1170},
    Data = {}
  },
  [1170] = {
    Type = "Common_WaitGameEvent",
    Next = {1175, 1175},
    Data = {
      GameEventType.RoundEnterFinish,
      3000
    },
    Tip = "等待输入"
  },
  [1175] = {
    Type = "Common_WaitUnscaledTime",
    Next = {1181},
    Data = {2000}
  },
  [1181] = {
    Type = "Common_BattleKillMonsters",
    Next = {1182},
    Data = {},
    Tip = ""
  },
  [1182] = {
    Type = "Common_WaitUnscaledTime",
    Next = {1183},
    Data = {5000},
    Tip = ""
  },
  [1183] = {
    Type = "Common_BattleKillMonsters",
    Next = {1184},
    Data = {},
    Tip = ""
  },
  [1184] = {
    Type = "Common_WaitUnscaledTime",
    Next = {1190},
    Data = {0},
    Tip = ""
  },
  [1190] = {
    Type = "Common_WaitMatchEnd",
    Next = {
      [0] = 1200,
      [1] = 1300
    },
    Tip = "等待消息[GameEventType.OnGameOver],[0]对局失败,[1]对局成功"
  },
  [1200] = {
    Type = "Common_WaitGameEvent",
    Next = {1210},
    Data = {
      GameEventType.BattleResultFinish,
      5000
    },
    Tip = "等待对局结束"
  },
  [1210] = {
    Type = "Common_WaitUnscaledTime",
    Next = {1211},
    Data = {3500}
  },
  [1211] = {
    Type = "Common_ForceCloseStory",
    Next = {1220},
    Data = {}
  },
  [1220] = {
    Type = "UISimulate_FakeInput",
    Next = {1230},
    Data = {
      "UIGuideFailedController",
      "bgOnClick"
    }
  },
  [1230] = {
    Type = "Common_WaitUnscaledTime",
    Next = {1398},
    Data = {1000}
  },
  [1300] = {
    Type = "Common_WaitGameEvent",
    Next = {1310},
    Data = {
      GameEventType.BattleResultFinish,
      5000
    },
    Tip = "等待对局结束"
  },
  [1310] = {
    Type = "Common_ForceCloseStory",
    Next = {1320},
    Data = {}
  },
  [1320] = {
    Type = "Common_WaitUnscaledTime",
    Next = {1398},
    Data = {5000},
    Tip = "等待5秒：等对局结束网络包"
  },
  [1398] = {
    Type = "CTestRobot_Common_ShutdownCoreGame",
    Next = {1399}
  },
  [1399] = {
    Type = "Common_BackToLobby",
    Next = {1400}
  },
  [1400] = {
    Type = "Mission_CheckMatchResult",
    Next = {
      [0] = 1410,
      [1] = 1410,
      [2] = 1410
    },
    Data = {},
    Tip = "[0]胜利[1]失败[2]多次失败"
  },
  [1410] = {
    Type = "Common_CheckProgress",
    Next = {
      [0] = 1500,
      [1] = 1500
    },
    Data = {},
    Tip = "找下一关"
  },
  [1500] = {
    Type = "Common_StopConversationSkipTask",
    Next = {1501},
    Data = {}
  },
  [1501] = {
    Type = "CTestRobot_Common_ShutdownCoreGame",
    Next = {1502}
  },
  [1502] = {
    Type = "Common_WaitUnscaledTime",
    Data = {5000},
    Next = {1506}
  },
  [1506] = {
    Type = "Common_WaitUnscaledTime",
    Data = {5000},
    Next = {19999}
  },
  [19999] = {
    Type = "Common_DeleteLastPetInfo",
    Data = {},
    Next = {3011}
  },
  [3011] = {
    Type = "DifficultyMission_Init",
    Next = {3015},
    Data = {}
  },
  [3015] = {
    Type = "DifficultyMission_GM_PassAll",
    Next = {3020},
    Data = {}
  },
  [3020] = {
    Type = "DifficultyMission_BuildTeam",
    Next = {
      3040,
      3500,
      510
    }
  },
  [3040] = {
    Type = "GM_AddResource",
    Next = {3050},
    Data = {3000001, 50}
  },
  [3050] = {
    Type = "Common_StartConversationSkipTask",
    Next = {3130}
  },
  [3130] = {
    Type = "DifficultyMission_EnterBattleWithParam",
    Next = {3140},
    Data = {
      2701,
      2701001,
      1,
      108102806
    }
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
    Next = {3183},
    Data = {2000}
  },
  [3183] = {
    Type = "Common_BattleKillMonsters",
    Next = {3184},
    Data = {},
    Tip = ""
  },
  [3184] = {
    Type = "Common_WaitUnscaledTime",
    Next = {3190},
    Data = {0},
    Tip = ""
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
    Next = {3211},
    Data = {3500}
  },
  [3211] = {
    Type = "Common_ForceCloseStory",
    Next = {3220},
    Data = {}
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
    Next = {3398},
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
    Next = {3398},
    Data = {5000},
    Tip = "等待5秒：等对局结束网络包"
  },
  [3398] = {
    Type = "CTestRobot_Common_ShutdownCoreGame",
    Next = {3399}
  },
  [3399] = {
    Type = "Common_BackToLobby",
    Next = {3400}
  },
  [3400] = {
    Type = "Mission_CheckMatchResult",
    Next = {
      [0] = 3410,
      [1] = 3410,
      [2] = 3410
    },
    Data = {},
    Tip = "[0]胜利[1]失败[2]多次失败"
  },
  [3410] = {
    Type = "Common_CheckProgress",
    Next = {
      [0] = 3500,
      [1] = 3500
    },
    Data = {},
    Tip = "找下一关"
  },
  [3500] = {
    Type = "Common_StopConversationSkipTask",
    Next = {3501},
    Data = {}
  },
  [3501] = {
    Type = "CTestRobot_Common_ShutdownCoreGame",
    Next = {3502}
  },
  [3502] = {
    Type = "Common_WaitUnscaledTime",
    Data = {5000},
    Next = {3506}
  },
  [3506] = {
    Type = "Common_WaitUnscaledTime",
    Data = {1000},
    Next = {29998}
  },
  [29998] = {
    Type = "DifficultyMission_BuildTeamClean",
    Next = {
      29999,
      29999,
      29999
    },
    Data = {2701, 2701001}
  },
  [29999] = {
    Type = "Common_DeleteLastPetInfo",
    Data = {},
    Next = {4011}
  },
  [4011] = {
    Type = "DifficultyMission_Init",
    Next = {4015},
    Data = {}
  },
  [4015] = {
    Type = "DifficultyMission_GM_PassAll",
    Next = {4020},
    Data = {}
  },
  [4020] = {
    Type = "DifficultyMission_BuildTeam",
    Next = {
      4040,
      4500,
      510
    }
  },
  [4040] = {
    Type = "GM_AddResource",
    Next = {4050},
    Data = {3000001, 50}
  },
  [4050] = {
    Type = "Common_StartConversationSkipTask",
    Next = {4130}
  },
  [4130] = {
    Type = "DifficultyMission_EnterBattleWithParam",
    Next = {4140},
    Data = {
      2702,
      2702001,
      1,
      108102806
    }
  },
  [4140] = {
    Type = "Common_WaitGameEvent",
    Next = {4150, 4150},
    Data = {
      GameEventType.LoadingFinish,
      15000
    },
    Tip = "等待对局开始"
  },
  [4150] = {
    Type = "Common_WaitUnscaledTime",
    Next = {4160},
    Data = {5000}
  },
  [4160] = {
    Type = "Common_ForceCloseStory",
    Next = {4170},
    Data = {}
  },
  [4170] = {
    Type = "Common_WaitGameEvent",
    Next = {4175, 4175},
    Data = {
      GameEventType.RoundEnterFinish,
      3000
    },
    Tip = "等待输入"
  },
  [4175] = {
    Type = "Common_WaitUnscaledTime",
    Next = {4181},
    Data = {2000}
  },
  [4181] = {
    Type = "Common_BattleKillMonsters",
    Next = {4182},
    Data = {},
    Tip = ""
  },
  [4182] = {
    Type = "Common_WaitUnscaledTime",
    Next = {4183},
    Data = {5000},
    Tip = ""
  },
  [4183] = {
    Type = "Common_BattleKillMonsters",
    Next = {4184},
    Data = {},
    Tip = ""
  },
  [4184] = {
    Type = "Common_WaitUnscaledTime",
    Next = {4190},
    Data = {0},
    Tip = ""
  },
  [4190] = {
    Type = "Common_WaitMatchEnd",
    Next = {
      [0] = 4200,
      [1] = 4300
    },
    Tip = "等待消息[GameEventType.OnGameOver],[0]对局失败,[1]对局成功"
  },
  [4200] = {
    Type = "Common_WaitGameEvent",
    Next = {4210},
    Data = {
      GameEventType.BattleResultFinish,
      5000
    },
    Tip = "等待对局结束"
  },
  [4210] = {
    Type = "Common_WaitUnscaledTime",
    Next = {4211},
    Data = {3500}
  },
  [4211] = {
    Type = "Common_ForceCloseStory",
    Next = {4220},
    Data = {}
  },
  [4220] = {
    Type = "UISimulate_FakeInput",
    Next = {4230},
    Data = {
      "UIGuideFailedController",
      "bgOnClick"
    }
  },
  [4230] = {
    Type = "Common_WaitUnscaledTime",
    Next = {4398},
    Data = {1000}
  },
  [4300] = {
    Type = "Common_WaitGameEvent",
    Next = {4310},
    Data = {
      GameEventType.BattleResultFinish,
      5000
    },
    Tip = "等待对局结束"
  },
  [4310] = {
    Type = "Common_ForceCloseStory",
    Next = {4320},
    Data = {}
  },
  [4320] = {
    Type = "Common_WaitUnscaledTime",
    Next = {4398},
    Data = {5000},
    Tip = "等待5秒：等对局结束网络包"
  },
  [4398] = {
    Type = "CTestRobot_Common_ShutdownCoreGame",
    Next = {4399}
  },
  [4399] = {
    Type = "Common_BackToLobby",
    Next = {4400}
  },
  [4400] = {
    Type = "Mission_CheckMatchResult",
    Next = {
      [0] = 4410,
      [1] = 4410,
      [2] = 4410
    },
    Data = {},
    Tip = "[0]胜利[1]失败[2]多次失败"
  },
  [4410] = {
    Type = "Common_CheckProgress",
    Next = {
      [0] = 4500,
      [1] = 4500
    },
    Data = {},
    Tip = "找下一关"
  },
  [4500] = {
    Type = "Common_StopConversationSkipTask",
    Next = {4501},
    Data = {}
  },
  [4501] = {
    Type = "CTestRobot_Common_ShutdownCoreGame",
    Next = {4502}
  },
  [4502] = {
    Type = "Common_WaitUnscaledTime",
    Data = {5000},
    Next = {4506}
  },
  [4506] = {
    Type = "Common_WaitUnscaledTime",
    Data = {1000},
    Next = {9998}
  },
  [9998] = {
    Type = "DifficultyMission_BuildTeamClean",
    Next = {
      9999,
      9999,
      9999
    },
    Data = {2702, 2702001}
  },
  [9999] = {
    Type = "Common_DeleteLastPetInfo",
    Data = {},
    Next = {11}
  },
  [11] = {
    Type = "DifficultyMission_Init",
    Next = {15},
    Data = {}
  },
  [15] = {
    Type = "DifficultyMission_GM_PassAll",
    Next = {20},
    Data = {}
  },
  [20] = {
    Type = "DifficultyMission_BuildTeam",
    Next = {
      2040,
      500,
      510
    }
  },
  [2040] = {
    Type = "GM_AddResource",
    Next = {2050},
    Data = {3000001, 50}
  },
  [2050] = {
    Type = "Common_StartConversationSkipTask",
    Next = {130}
  },
  [130] = {
    Type = "DifficultyMission_EnterBattle",
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
      [1] = 40,
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
return difficultyMissionSequence
