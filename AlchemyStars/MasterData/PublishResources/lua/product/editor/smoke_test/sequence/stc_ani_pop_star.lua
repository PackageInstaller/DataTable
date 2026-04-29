TestSequence_Ani_Pop_Star = {
  [1] = {
    Type = "Infrastructure_Begin",
    Next = {1001},
    Data = {}
  },
  [1001] = {
    Type = "AniPopStar_Reset",
    Next = {1003},
    Data = {}
  },
  [1003] = {
    Type = "AniPopStar_BuildTeamByRunData",
    Next = {
      [1] = 1004,
      [2] = 95,
      [3] = 95
    },
    Data = {}
  },
  [1004] = {
    Type = "Common_WaitUnscaledTime",
    Next = {5},
    Data = {2000},
    Tip = "等待2秒"
  },
  [5] = {
    Type = "AniPopStar_CheckDanglingRelics",
    Next = {
      [0] = 10,
      [1] = 6
    },
    Data = {},
    Tip = "检查是否有上次遗落未拾取的圣物"
  },
  [6] = {
    Type = "CTestRobot_ShowUIByRunData",
    Next = {80},
    Data = {
      "UIEliminateChooseCardController"
    },
    Tip = "弹出圣物拾取界面：使用运行时数据"
  },
  [10] = {
    Type = "AniPopStar_FindRoom",
    Next = {
      [0] = 95,
      [1] = 11
    },
    Tip = "查找房间，找不到[0]则退出"
  },
  [11] = {
    Type = "AniPopStar_InitTeamctx",
    Next = {21},
    Tip = "准备相关数据"
  },
  [21] = {
    Type = "CTestRobot_ShowUIState",
    Next = {22},
    Data = {"UITeams"},
    Tip = "打开队伍界面"
  },
  [22] = {
    Type = "Common_WaitUnscaledTime",
    Next = {25},
    Data = {1000},
    Tip = "等待1秒"
  },
  [25] = {
    Type = "UISimulate_FakeInput",
    Next = {27},
    Data = {
      "UITeams",
      "btnFightOnClick"
    },
    Tip = "点击队伍界面进入对局"
  },
  [27] = {
    Type = "Common_WaitGameEvent",
    Next = {30},
    Data = {
      GameEventType.RoundEnterFinish
    },
    Tip = "等待棋盘创建、玩家入场、怪物刷新等"
  },
  [30] = {
    Type = "CTestRobot_ShowUI",
    Next = {31},
    Data = {
      "UIBattleCheat",
      50000
    },
    Tip = "打开作弊界面，设置默认攻击力是5000"
  },
  [31] = {
    Type = "Common_WaitUnscaledTime",
    Next = {32},
    Data = {1000},
    Tip = "等待1秒"
  },
  [32] = {
    Type = "UISimulate_FakeInput",
    Next = {320},
    Data = {
      "UIBattleCheat",
      "AttackMaxOnClick"
    },
    Tip = "点击作弊按钮：设置攻击力"
  },
  [320] = {
    Type = "Common_WaitUnscaledTime",
    Next = {321},
    Data = {1000},
    Tip = "等待1秒"
  },
  [321] = {
    Type = "UISimulate_FakeInput",
    Next = {33},
    Data = {
      "UIBattleCheat",
      "HeroFullHPOnClick"
    },
    Tip = "点击作弊按钮：光灵满血"
  },
  [33] = {
    Type = "UISimulate_FakeInput",
    Next = {35},
    Data = {
      "UIBattleCheat",
      "BlackBGOnClick"
    },
    Tip = "关闭作弊窗口"
  },
  [35] = {
    Type = "Common_WaitUnscaledTime",
    Next = {40},
    Data = {2000},
    Tip = "等待1秒"
  },
  [40] = {
    Type = "Common_EnableAutoBattle",
    Next = {41},
    Data = {},
    Tip = "设置对局自动战斗"
  },
  [41] = {
    Type = "Common_WaitMatchEnd",
    Next = {
      [0] = 51,
      [1] = 43
    },
    Tip = "等待消息[GameEventType.OnGameOver],[0]对局失败,[1]对局成功"
  },
  [43] = {
    Type = "AniPopStar_OnMatchEnd",
    Next = {
      [0] = 51,
      [1] = 80,
      [2] = 44
    },
    Tip = "等待消息[GameEventType.BattleResultFinish],[0]对局失败,[1]选择圣物,[2]结束密境探索"
  },
  [44] = {
    Type = "UISimulate_FakeInput",
    Next = {91},
    Data = {
      "UIEliminateBattleResultController",
      "BgOnClick"
    },
    Tip = "关闭对局结束页面"
  },
  [51] = {
    Type = "Common_WaitUnscaledTime",
    Next = {95},
    Data = {5000},
    Tip = "等待5秒"
  },
  [80] = {
    Type = "Common_WaitUnscaledTime",
    Next = {81},
    Data = {2000},
    Tip = "等待2秒，等待圣物窗口弹出"
  },
  [81] = {
    Type = "Common_Random",
    Next = {82},
    Data = {1, 3},
    Tip = {
      "生成随机数"
    }
  },
  [82] = {
    Type = "UISimulate_FakeInputWithReturnParam",
    Next = {83},
    Data = {
      "UIEliminateChooseCardController",
      "CardClick"
    },
    Tip = "预览圣物"
  },
  [83] = {
    Type = "Common_WaitUnscaledTime",
    Next = {84},
    Data = {1000},
    Tip = "等待1秒"
  },
  [84] = {
    Type = "UISimulate_FakeInput",
    Next = {841},
    Data = {
      "UIEliminateChooseCardController",
      "ChooseBtnOnClick"
    },
    Tip = "选择圣物"
  },
  [841] = {
    Type = "Common_WaitUnscaledTime",
    Next = {8411},
    Data = {1000},
    Tip = "等待1秒"
  },
  [8411] = {
    Type = "Common_Random",
    Next = {842},
    Data = {1, 3},
    Tip = {
      "生成随机数"
    }
  },
  [842] = {
    Type = "UISimulate_FakeInputWithReturnParam",
    Next = {843},
    Data = {
      "UIEliminateChooseCardController",
      "CardClick"
    },
    Tip = "预览圣物"
  },
  [843] = {
    Type = "Common_WaitUnscaledTime",
    Next = {844},
    Data = {1000},
    Tip = "等待1秒"
  },
  [844] = {
    Type = "UISimulate_FakeInput",
    Next = {845},
    Data = {
      "UIEliminateChooseCardController",
      "ChooseBtnOnClick"
    },
    Tip = "选择圣物"
  },
  [845] = {
    Type = "Common_WaitUnscaledTime",
    Next = {8451},
    Data = {1000},
    Tip = "等待1秒"
  },
  [8451] = {
    Type = "Common_Random",
    Next = {846},
    Data = {1, 3},
    Tip = {
      "生成随机数"
    }
  },
  [846] = {
    Type = "UISimulate_FakeInputWithReturnParam",
    Next = {847},
    Data = {
      "UIEliminateChooseSkillController",
      "TestFakeSelect"
    },
    Tip = "选空裔技"
  },
  [847] = {
    Type = "Common_WaitUnscaledTime",
    Next = {85},
    Data = {1000},
    Tip = "等待1秒"
  },
  [85] = {
    Type = "Common_WaitUnscaledTime",
    Next = {86},
    Data = {5000},
    Tip = "等待5秒：等对局结束网络包"
  },
  [86] = {
    Type = "UISimulate_FakeInput",
    Next = {87},
    Data = {
      "UILevelUp",
      "FullScreenBtnOnClick"
    },
    Tip = "关闭可能出现的升级页面"
  },
  [87] = {
    Type = "Common_WaitUnscaledTime",
    Next = {88},
    Data = {1000},
    Tip = "等待1秒"
  },
  [88] = {
    Type = "UISimulate_FakeInput",
    Next = {89},
    Data = {
      "UIEliminateBattleResultController",
      "BgOnClick"
    },
    Tip = "关闭对局结束页面"
  },
  [89] = {
    Type = "Common_WaitUnscaledTime",
    Next = {890},
    Data = {6000},
    Tip = "等待6秒"
  },
  [890] = {
    Type = "Common_ForceCloseStory",
    Next = {1003},
    Data = {}
  },
  [90] = {
    Type = "UISimulate_FakeInput",
    Next = {91},
    Data = {
      "UIEliminateBattleResultController",
      "BgOnClick"
    },
    Tip = "关闭对局结束页面"
  },
  [91] = {
    Type = "Common_WaitUnscaledTime",
    Next = {95},
    Data = {3000},
    Tip = "等待3秒"
  },
  [95] = {
    Type = "UIToast",
    Next = {99},
    Data = {
      "启迪互联自动测试完成"
    }
  },
  [99] = {
    Type = "Infrastructure_SilentEnd",
    Next = {0},
    Data = {},
    Tip = "关闭自动测试的开关"
  }
}
return TestSequence_Ani_Pop_Star
