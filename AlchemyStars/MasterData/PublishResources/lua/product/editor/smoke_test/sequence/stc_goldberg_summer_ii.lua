require("campaign_info")
TestSequence_Goldberg_SummerII = {
  [1] = {
    Type = "Infrastructure_Begin",
    Next = {13},
    Data = {}
  },
  [13] = {
    Type = "GoldbergEvent_GM_PassSumIICampMission",
    Data = {100401101, 5041005},
    Next = {14}
  },
  [14] = {
    Type = "Common_WaitUnscaledTime",
    Next = {15},
    Data = {100}
  },
  [15] = {
    Type = "GoldbergEvent_GM_PassSumIICampMission",
    Data = {100401101, 5042005},
    Next = {16}
  },
  [16] = {
    Type = "Common_WaitUnscaledTime",
    Next = {17},
    Data = {100}
  },
  [17] = {
    Type = "GoldbergEvent_GM_PassSumIICampMission",
    Data = {100401101, 5043005},
    Next = {18}
  },
  [18] = {
    Type = "Common_WaitUnscaledTime",
    Next = {19},
    Data = {100}
  },
  [19] = {
    Type = "GoldbergEvent_GM_PassSumIICampMission",
    Data = {100401101, 5044005},
    Next = {20}
  },
  [20] = {
    Type = "Common_WaitUnscaledTime",
    Next = {21},
    Data = {100}
  },
  [21] = {
    Type = "GoldbergEvent_GM_PassSumIICampMission",
    Data = {100401101, 5045005},
    Next = {22}
  },
  [22] = {
    Type = "Common_WaitUnscaledTime",
    Next = {23},
    Data = {100}
  },
  [23] = {
    Type = "GoldbergEventTest_HandleSelectAffix",
    Next = {24},
    Data = {}
  },
  [24] = {
    Type = "Mission_BuildTeam",
    Next = {
      [1] = 30,
      [2] = 9999,
      [3] = 9999
    },
    Data = {}
  },
  [30] = {
    Type = "GM_AddResource",
    Next = {31},
    Data = {3000001, 50},
    Tip = "加体力"
  },
  [31] = {
    Type = "GoldbergEvent_SummerII_EnterBattle",
    Next = {40}
  },
  [40] = {
    Type = "Common_WaitGameEvent",
    Next = {50},
    Data = {
      GameEventType.LoadingFinish
    },
    Tip = "等待对局开始"
  },
  [50] = {
    Type = "Common_WaitUnscaledTime",
    Next = {60},
    Data = {3000}
  },
  [60] = {
    Type = "Common_ForceCloseStory",
    Next = {70},
    Data = {}
  },
  [70] = {
    Type = "Common_WaitGameEvent",
    Next = {80},
    Data = {
      GameEventType.RoundEnterFinish
    }
  },
  [80] = {
    Type = "Common_EnableAutoBattle",
    Next = {90},
    Data = {},
    Tip = "设置对局自动战斗"
  },
  [90] = {
    Type = "Common_WaitMatchEnd",
    Next = {
      [0] = 100,
      [1] = 200
    },
    Tip = "等待消息[GameEventType.OnGameOver],[0]对局失败,[1]对局成功"
  },
  [100] = {
    Type = "Common_WaitGameEvent",
    Next = {110},
    Data = {
      GameEventType.BattleResultFinish,
      5000
    },
    Tip = "等待对局结束"
  },
  [110] = {
    Type = "Common_WaitUnscaledTime",
    Next = {120},
    Data = {3500}
  },
  [120] = {
    Type = "UISimulate_FakeInput",
    Next = {130},
    Data = {
      "UIGuideFailedController",
      "bgOnClick"
    }
  },
  [130] = {
    Type = "Common_WaitUnscaledTime",
    Next = {210},
    Data = {1000}
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
    Type = "Common_ForceCloseStory",
    Next = {220},
    Data = {}
  },
  [220] = {
    Type = "Common_WaitUnscaledTime",
    Next = {230},
    Data = {5000},
    Tip = "等待5秒：等对局结束网络包"
  },
  [230] = {
    Type = "UISimulate_FakeInput",
    Next = {240},
    Data = {
      "UILevelUp",
      "FullScreenBtnOnClick"
    },
    Tip = "关闭可能出现的升级页面"
  },
  [240] = {
    Type = "Common_WaitUnscaledTime",
    Next = {250},
    Data = {2000},
    Tip = "等待2秒"
  },
  [250] = {
    Type = "UISimulate_FakeInput",
    Next = {260},
    Data = {
      "UIBattleResultComplete",
      "bgOnClick"
    }
  },
  [260] = {
    Type = "Common_WaitUnscaledTime",
    Next = {270},
    Data = {6000},
    Tip = "等待6秒"
  },
  [270] = {
    Type = "Common_ForceCloseStory",
    Next = {300},
    Data = {}
  },
  [300] = {
    Type = "Mission_CheckMatchResult",
    Next = {
      [0] = 400,
      [1] = 310,
      [2] = 400
    },
    Data = {}
  },
  [310] = {
    Type = "GM_AddResource",
    Next = {320},
    Data = {3000001, 50},
    Tip = "加体力"
  },
  [320] = {
    Type = "Common_WaitUnscaledTime",
    Next = {30},
    Data = {1000}
  },
  [400] = {
    Type = "GoldbergEvent_UpdateProgress",
    Next = {
      [0] = 9999,
      [1] = 24
    },
    Data = {},
    Tip = "找下一关"
  },
  [9999] = {
    Type = "Infrastructure_End",
    Next = {0}
  }
}
return TestSequence_Goldberg_SummerII
