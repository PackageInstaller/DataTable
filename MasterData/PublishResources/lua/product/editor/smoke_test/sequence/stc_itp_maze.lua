TestSequence_ITP_Maze = {
  [1] = {
    Type = "Infrastructure_Begin",
    Next = {1001},
    Data = {}
  },
  [1001] = {
    Type = "Maze_Reset",
    Next = {1003},
    Data = {}
  },
  [1003] = {
    Type = "Maze_BuildTeamByRunData",
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
    Type = "Maze_CheckDanglingRelics",
    Next = {
      [0] = 10,
      [1] = 6
    },
    Data = {},
    Tip = "检查密境是否有上次遗落未拾取的圣物"
  },
  [6] = {
    Type = "CTestRobot_ShowUIByRunData",
    Next = {80},
    Data = {
      "UIRugueLikeChooseCardController"
    },
    Tip = "弹出圣物拾取界面：使用运行时数据"
  },
  [10] = {
    Type = "Maze_FindRoom",
    Next = {
      [0] = 95,
      [1] = 11
    },
    Tip = "查找密境房间，找不到[0]则退出"
  },
  [11] = {
    Type = "Maze_IsMatchRoom",
    Next = {
      [0] = 70,
      [1] = 21
    },
    Tip = "准备密境相关数据：[0]休息室，[1]战斗房间"
  },
  [21] = {
    Type = "CTestRobot_ShowUI",
    Next = {22},
    Data = {"UITeams"},
    Tip = "打开队伍界面"
  },
  [22] = {
    Type = "Common_WaitUnscaledTime",
    Next = {24},
    Data = {1000},
    Tip = "等待1秒"
  },
  [24] = {
    Type = "GM_AddResource",
    Next = {25},
    Data = {3000006, 25},
    Tip = "加MS"
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
    Next = {40},
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
      5000
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
    Next = {33},
    Data = {
      "UIBattleCheat",
      "AttackMaxOnClick"
    },
    Tip = "点击作弊按钮：设置攻击力"
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
    Tip = "等待1秒：等密境保存进度弹窗弹出"
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
    Type = "CTestRobot_WaitMatchEnd",
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
      "UIRugueLikeBattleResultController",
      "bgOnClick"
    },
    Tip = "关闭对局结束页面"
  },
  [51] = {
    Type = "Common_WaitUnscaledTime",
    Next = {52},
    Data = {1000},
    Tip = "等待1秒：等密境保存进度弹窗弹出"
  },
  [52] = {
    Type = "CTestRobot_MsgBoxCaller",
    Next = {53},
    Data = {
      "UICommonMessageBox",
      "ButtonOKOnClick"
    },
    Tip = "密境战斗失败弹窗，选择保存进度继续"
  },
  [53] = {
    Type = "Common_WaitUIState",
    Next = {54},
    Data = {
      UIStateType.UIMaze
    },
    Tip = "等待1秒：等密境保存进度弹窗关闭"
  },
  [54] = {
    Type = "CTestRobot_UICaller",
    Next = {540},
    Data = {
      "UIRugueLikeDefeatedController",
      "bgOnClick"
    },
    Tip = "关闭密境战斗失败UI"
  },
  [540] = {
    Type = "Maze_RevivePets",
    Next = {541},
    Data = {}
  },
  [541] = {
    Type = "Maze_RecoverFormation",
    Next = {55},
    Data = {}
  },
  [55] = {
    Type = "Common_WaitUnscaledTime",
    Next = {10},
    Data = {5000},
    Tip = "等待5秒：等密境战斗失败UI关闭、局内退出"
  },
  [70] = {
    Type = "CTestRobot_ShowUIByRunData",
    Next = {72},
    Data = {
      "UIRugueLikeRestRoomController"
    },
    Tip = "弹出休息室界面：使用运行时数据"
  },
  [72] = {
    Type = "Common_WaitUnscaledTime",
    Next = {73},
    Data = {1000},
    Tip = "等待1秒"
  },
  [73] = {
    Type = "Common_Random",
    Next = {74},
    Data = {1, 1},
    Tip = {
      "生成随机数"
    }
  },
  [74] = {
    Type = "UISimulate_FakeInputWithReturnParam",
    Next = {75},
    Data = {
      "UIRugueLikeRestRoomController",
      "BtnOnClickByParam"
    }
  },
  [75] = {
    Type = "Common_WaitUnscaledTime",
    Next = {10},
    Data = {9000},
    Tip = "等待9秒：等待休息室功能完成，网络数据包"
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
      "UIRugueLikeChooseCardController",
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
    Next = {85},
    Data = {
      "UIRugueLikeChooseCardController",
      "chooseBtnOnClick"
    },
    Tip = "选择圣物"
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
    Next = {880},
    Data = {
      "UIRugueLikeBattleResultController",
      "bgOnClick"
    },
    Tip = "关闭对局结束页面"
  },
  [880] = {
    Type = "Maze_RevivePets",
    Next = {881},
    Data = {}
  },
  [881] = {
    Type = "Maze_RecoverFormation",
    Next = {89},
    Data = {}
  },
  [89] = {
    Type = "Common_WaitUnscaledTime",
    Next = {10},
    Data = {6000},
    Tip = "等待6秒"
  },
  [90] = {
    Type = "UISimulate_FakeInput",
    Next = {91},
    Data = {
      "UIRugueLikeBattleResultController",
      "bgOnClick"
    },
    Tip = "关闭对局结束页面"
  },
  [91] = {
    Type = "Common_WaitUnscaledTime",
    Next = {95},
    Data = {1000},
    Tip = "等待1秒"
  },
  [95] = {
    Type = "UIToast",
    Next = {99},
    Data = {
      "密境房间自动测试完成"
    }
  },
  [99] = {
    Type = "Infrastructure_SilentEnd",
    Next = {0},
    Data = {},
    Tip = "关闭自动测试MazeGame的开关"
  }
}
return TestSequence_ITP_Maze
