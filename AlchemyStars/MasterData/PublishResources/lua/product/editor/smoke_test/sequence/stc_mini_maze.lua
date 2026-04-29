TestSequence_Mini_Maze = {
  [1] = {
    Type = "Infrastructure_Begin",
    Next = {5},
    Data = {}
  },
  [5] = {
    Type = "GM_AddAllPet",
    Next = {10},
    Data = {}
  },
  [10] = {
    Type = "GM_OpenAllCampaign",
    Next = {11},
    Data = {},
    Tip = "解锁活动"
  },
  [11] = {
    Type = "GM_PassMiniMazeMission",
    Next = {12},
    Data = {},
    Tip = "解锁关卡"
  },
  [12] = {
    Type = "GM_MiniMazeTalentMax",
    Next = {20},
    Data = {},
    Tip = "解锁天赋"
  },
  [20] = {
    Type = "Mini_Maze_BuildTeam",
    Next = {
      30,
      500,
      510
    },
    Tip = "BuildTeam"
  },
  [30] = {
    Type = "GoldbergEvent_ExpensionSupport",
    Next = {41}
  },
  [41] = {
    Type = "GoldbergEvent_Cheat_AddActionPoint",
    Next = {50},
    Data = {50}
  },
  [50] = {
    Type = "Common_StartConversationSkipTask",
    Next = {130}
  },
  [130] = {
    Type = "MiniMaze_EnterBattle",
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
    Next = {170},
    Data = {5000}
  },
  [170] = {
    Type = "Common_WaitGameEvent",
    Next = {180, 180},
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
    Type = "Common_WaitUnscaledTime",
    Next = {181},
    Data = {2000},
    Tip = "等待2秒，等待圣物窗口弹出"
  },
  [181] = {
    Type = "Common_Random",
    Next = {182},
    Data = {1, 3},
    Tip = {
      "生成随机数"
    }
  },
  [182] = {
    Type = "UISimulate_FakeInputWithReturnParam",
    Next = {183},
    Data = {
      "UIMiniMazeChooseRelicController",
      "CardClick"
    },
    Tip = "预览圣物"
  },
  [183] = {
    Type = "Common_WaitUnscaledTime",
    Next = {184},
    Data = {1000},
    Tip = "等待1秒"
  },
  [184] = {
    Type = "UISimulate_FakeInput",
    Next = {185},
    Data = {
      "UIMiniMazeChooseRelicController",
      "ChooseBtnOnClick"
    },
    Tip = "选择圣物"
  },
  [185] = {
    Type = "Common_WaitUnscaledTime",
    Next = {186},
    Data = {5000},
    Tip = "等待5秒：等对局结束网络包"
  },
  [186] = {
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
  },
  [1000] = {
    Type = "Common_WaitUnscaledTime",
    Next = {1001},
    Data = {2000},
    Tip = "等待2秒，等待圣物窗口弹出"
  },
  [1001] = {
    Type = "Common_Random",
    Next = {1002},
    Data = {1, 3},
    Tip = {
      "生成随机数"
    }
  },
  [1002] = {
    Type = "UISimulate_FakeInputWithReturnParam",
    Next = {1003},
    Data = {
      "UIMiniMazeChooseRelicController",
      "CardClick"
    },
    Tip = "预览圣物"
  },
  [1003] = {
    Type = "Common_WaitUnscaledTime",
    Next = {1004},
    Data = {1000},
    Tip = "等待1秒"
  },
  [1004] = {
    Type = "UISimulate_FakeInput",
    Next = {1100},
    Data = {
      "UIMiniMazeChooseRelicController",
      "ChooseBtnOnClick"
    },
    Tip = "选择圣物"
  },
  [1100] = {
    Type = "Common_WaitGameEvent",
    Next = {1101, 190},
    Data = {
      GameEventType.WaveSwitch,
      3000
    },
    Tip = "等待输入"
  },
  [1101] = {
    Type = "Common_WaitUnscaledTime",
    Next = {1102},
    Data = {2000}
  },
  [1102] = {
    Type = "Common_WaitUnscaledTime",
    Next = {1103},
    Data = {2000},
    Tip = "等待2秒，等待圣物窗口弹出"
  },
  [1103] = {
    Type = "Common_Random",
    Next = {1104},
    Data = {1, 3},
    Tip = {
      "生成随机数"
    }
  },
  [1105] = {
    Type = "UISimulate_FakeInputWithReturnParam",
    Next = {1106},
    Data = {
      "UIMiniMazeChoosePartnerController",
      "CardClick"
    },
    Tip = "预览光灵"
  },
  [1107] = {
    Type = "Common_WaitUnscaledTime",
    Next = {1108},
    Data = {1000},
    Tip = "等待1秒"
  },
  [1109] = {
    Type = "UISimulate_FakeInput",
    Next = {1110},
    Data = {
      "UIMiniMazeChoosePartnerController",
      "chooseBtnOnClick"
    },
    Tip = "选择光灵"
  },
  [1111] = {
    Type = "Common_WaitUnscaledTime",
    Next = {190},
    Data = {5000},
    Tip = "等待5秒：等对局结束网络包"
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
    Next = {400}
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
  [1408] = {
    Type = "UISimulate_FakeInput",
    Next = {1100},
    Data = {
      "UIBattleResultComplete",
      "bgOnClick"
    },
    Tip = "关闭"
  },
  [1409] = {
    Type = "Common_WaitUnscaledTime",
    Data = {1000},
    Next = {1410}
  },
  [1410] = {
    Type = "Common_CheckProgress",
    Next = {
      [0] = 20,
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
    Data = {1000},
    Next = {1510}
  },
  [1510] = {
    Type = "Infrastructure_SilentEnd",
    Next = {99},
    Data = {},
    Tip = "关闭自动测试MazeGame的开关"
  }
}
return TestSequence_Mini_Maze
