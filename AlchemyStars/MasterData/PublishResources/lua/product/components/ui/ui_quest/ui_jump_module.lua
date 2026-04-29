_class("UIJumpModule", UIModule)
UIJumpModule = UIJumpModule
local JumpUIType = {
  StateUI = 0,
  NormalUI = 1,
  StateUIAndNormalUI = 2
}
_enum("JumpUIType", JumpUIType)
local FromUIType = {StateUI = 0, NormalUI = 1}
_enum("FromUIType", FromUIType)
local Id2UIName = {
  [UIJumpType.UI_JumpMission] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIDiscovery,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {
      [1] = 3
    }
  },
  [UIJumpType.UI_JumpResDungeon] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIResEntryController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {
      [1] = 5
    }
  },
  [UIJumpType.UI_JumpExMission] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIExtraMission,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {
      [1] = 7
    }
  },
  [UIJumpType.UI_JumpExMissionStage] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIExtraMissionStage,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {
      [1] = 7
    }
  },
  [UIJumpType.UI_JumpPet] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UIHeartSpiritController",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {
      [1] = 2
    }
  },
  [UIJumpType.UI_JumpMaze] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIMaze,
    normalUI = nil,
    needLoading = true,
    loadingHander = "MazeEnterLoadingHandler",
    sceneName = "mj_01",
    unLockID = {
      [1] = 6
    }
  },
  [UIJumpType.UI_JumpMall] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UIShopController",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {
      [1] = 9
    }
  },
  [UIJumpType.UI_JumpAircraft] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIAircraft,
    normalUI = nil,
    needLoading = true,
    loadingHander = "AircraftEnterLoadingHandler",
    sceneName = "fc_ui",
    unLockID = {
      [1] = 4
    }
  },
  [UIJumpType.UI_JumpDraw] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UIRecruit",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {
      [1] = 8
    }
  },
  [UIJumpType.UI_JumpQuest] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UIQuestController",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {
      [1] = 13,
      [2] = 14,
      [4] = 16,
      [5] = 15
    }
  },
  [UIJumpType.UI_JumpChooseAssistant] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UIChooseAssistantController",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpPlayerInfo] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UIPlayerInfoController",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {
      [1] = 11
    }
  },
  [UIJumpType.UI_JumpTower] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UITower,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {
      [1] = 24
    }
  },
  [UIJumpType.UI_JumpTowerLayer] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UITowerLayer,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {
      [1] = 24
    }
  },
  [UIJumpType.UI_JumpWeChat] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UIWeChatController",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {
      [1] = 25
    }
  },
  [UIJumpType.UI_JumpPetDetail] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UISpiritDetailGroupController",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {
      [1] = 2
    }
  },
  [UIJumpType.UI_JumpPetUpLevel] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UIUpLevelInterfaceController",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {
      [1] = 2
    }
  },
  [UIJumpType.UI_JumpPetBreak] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UIBreakController",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {
      [1] = 2
    }
  },
  [UIJumpType.UI_JumpPetAwaken] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UIGradeInterfaceController",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {
      [1] = 2
    }
  },
  [UIJumpType.UI_JumpPetFile] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UIPetIntimacyMainController",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {
      [1] = 2
    }
  },
  [UIJumpType.UI_JumpNotice] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UINoticeController",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {
      [1] = 20
    }
  },
  [UIJumpType.UI_JumpActivityEveSinsa] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIActivityEveSinsaMainController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivitySakuraEntry] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UISakuraEntryController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpTempSignIn] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UITempSignInController",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_WebView] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UITempSignInController",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivitySummer1] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UISummer1,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivitySummer1LevelSimple] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIXH1SimpleLevel,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivitySummer1LevelHard] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIXH1HardLevel,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivitySummer1Shop] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UIXH1Shop",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivitySummer1Game] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UIMiniGameStageController",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivitySummer2] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UISummer2,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivitySummer2Level] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UISummer2Level,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN5] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIActivityN5,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN5SimpleLevel] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIActivityN5SimpleLevel,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN5BattleField] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIActivityN5BattleField,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpWorldBoss] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIWorldBoss,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {
      [1] = 33
    }
  },
  [UIJumpType.UI_JumpActivityN6Building] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UIActivityNPlusSixBuildingMainController",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN6Level] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UINP6Level",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN7Level] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIN7Level,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityBlackFightMain] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIBlackFightMain,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN8Level] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIActivityN8LineMissionController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN8Combat] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIActivityN8BattleSimulatorController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN9Level] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIActivityN9LineMissionController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN9Shop] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIActivityShopControllerN9,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN10Shop] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UIN10ShopController",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN11Shop] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIN11Shop,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN11Level] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIActivityN11LineMissionController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN12NormalLevel] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIN12NormalLevel,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN13Level] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIN13LineMissionController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN13Build] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIN13BuildController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN15Level] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIN15LineMissionController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN15Lottery] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIN15RaffleController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpHauteCoutureKLReview2] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UIHauteCoutureDrawControllerKLReview2",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpHauteCouture] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UIHauteCoutureDrawV2Controller",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN14Normal] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIActivityN14LineMissionController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN14Shop] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIN14Shop,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN16Level] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIActivityN16LineMissionController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN16Shop] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIActivityShopControllerN16,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN17Shop] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIN17LotteryController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpHome] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIHomeland,
    normalUI = nil,
    needLoading = true,
    loadingHander = "HomelandEnterLoadingHandler",
    sceneName = "konggu02func",
    unLockID = {
      [1] = 34
    }
  },
  [UIJumpType.UI_JumpActivityN18Level] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIN18LineMissionController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN18Shop] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIN18Shop,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN19P5Award] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIN19P5DrawCard,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN19Level] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIN19LineMissionController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN20Level] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIActivityN20NormalLevel,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN20Shop] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UIActivityN20Shop",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN21Line] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIN21LineMissionController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN21Award] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIN21ShopController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN22Line] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIActivityN22LineMissionController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN22Award] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIActivtiyN22ShopController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN23Line] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIN23Line,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN23Shop] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIN23Shop,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpHauteCoutureReview] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UIHauteCoutureDrawV2ReviewController",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN24Shop] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIN24Shop,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN25Shop] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIN25Shop,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN25Line] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIN25Line,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityUIN25HardLevel] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIActivtiyN25HardLevelController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityUIN25Idol] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIN25IdolLogin,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN26Shop] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UIActivityN26Shop",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN26Line] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIN26Line,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN27Shop] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UIN27LotteryMain",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN27Line] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIN27LineMissionController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN28Shop] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UIActivityN28Shop",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN28Line] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIN28Line,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN29DetectiveLogin] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIN29DetectiveLogin,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN29Line] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UIActivityN29LineLevel",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN29Shop] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UIN29Shop",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityCN12N41Line] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UICN12N41LineController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityCN12N41Hard] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UICN12N41HardController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN42Line] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIN28Line,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN42Hard] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIN28HardLevel,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN30Entrust] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIN30Entrust,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN30Shop] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIN30ShopController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN31Line] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIN31Line,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN31Shop] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIActivityN31Shop,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityPopStar] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UISideEnterCenter",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN32Shop] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIN32ShopController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN33Shop] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIN33ShopController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN33Simulation] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = UIStateType.UIActivityN33DateMainController,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN33NormalLevel] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UIActivityN33LevelController",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpSeasonMap] = {
    type = JumpUIType.StateUI,
    stateUI = nil,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpSeasonMainKV] = {
    type = JumpUIType.StateUI,
    stateUI = nil,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpSeasonOnceMission] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UISeasonOnceMission",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpSeasonMazeMainKV] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UISeasonMazeEnterController",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN34Task] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UIActivityN34TaskMainController",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityCN6N35Line] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UICN6N35Line",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityCN6N35Shop] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UIActivityCN6N35Shop",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpHauteCoutureKL_Review] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UIHauteCoutureDraw_Review",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityCN7N36Line] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UICN7N36Line",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityCN7N36Shop] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UICN7N36ShopController",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN37Line] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UIN37LineMissionController",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN37Shop] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UIN37ExchangeController",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN38Line] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UIN38Line",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN38Shop] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UIN38Shop",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityShop] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UIShopController",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_Jump_UIEliminateController] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIEliminateController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {
      [1] = 41
    }
  },
  [UIJumpType.UI_JumpActivityN39Line] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UIN39LineMissionController",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN39Shop] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UIN39ExchangeController",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_Jump_SimpleSkin_Fei] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UISimpleHauteCoutureMainController",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityUIN28AVGMain] = {
    type = JumpUIType.StateUI,
    stateUI = "UIN28AVGMain",
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityWeekTower] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UISideEnterCenter",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityUIN25VampireMain] = {
    type = JumpUIType.StateUI,
    stateUI = "UIN25VampireMain",
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN44Main] = {
    type = JumpUIType.StateUI,
    stateUI = "UIActivityN25MainController",
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN44Line] = {
    type = JumpUIType.StateUI,
    stateUI = nil,
    normalUI = "UIN25Line",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN44Hard] = {
    type = JumpUIType.StateUI,
    stateUI = "UIActivtiyN25HardLevelController",
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpN44Story] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UISideEnterCenter",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityCenter] = {
    type = JumpUIType.NormalUI,
    stateUI = nil,
    normalUI = "UISideEnterCenter",
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityUICN16N45Line] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UICN16N45LineController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityUICN16N45Hard] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UICN16N45HardLevel,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityUICN17N46Line] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UICN17N46LineController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityUICN17N46Hard] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UICN17N46HardLevel,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityUICN18N47Line] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UICN18N47LineController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityUICN18N47Hard] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UICN18N47HardLevel,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN48Main] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIN48MainController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN48Line] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIN48LineMissionController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityN48Hard] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UIN48HardController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityUICN20N49Line] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UICN20N49LineController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityUICN20N49LineTalent] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UICN20N49LineTalentController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityUICN20N49Tree] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UICN20N49TreeController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityUICN20N49MainController] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UICN20N49MainController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityUICN21N50Line] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UICN21N50LineController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityUICN21N50Hard] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UICN21N50HardLevel,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityUICN22N51Line] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UICN22N51LineController,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  },
  [UIJumpType.UI_JumpActivityUICN22N51Hard] = {
    type = JumpUIType.StateUI,
    stateUI = UIStateType.UICN22N51HardLevel,
    normalUI = nil,
    needLoading = false,
    loadingHander = nil,
    sceneName = nil,
    unLockID = {}
  }
}
local HomeUIDialogEnum = {Level = 1}
_enum("HomeUIDialogEnum", HomeUIDialogEnum)
local HomeDialogEnum2DialogName = {
  [HomeUIDialogEnum.Level] = "UIHomelandLevel"
}

function UIJumpModule:Dispose()
  self._fromUIType = nil
  self._fromUIName = nil
  self._fromUIOfStateUI = nil
  self._fromUIParams = nil
  self._uiControllerType = nil
  self._jumpUIType = nil
  self._jumpStateUIName = nil
  self._jumpNormalUIName = nil
  self._jumpUIParams = nil
  self._jumpLoadingHander = nil
  self._jumpLoadingSceneName = nil
end

function UIJumpModule:Constructor()
  self._fromUIType = nil
  self._fromUIName = nil
  self._fromUIOfStateUI = nil
  self._fromUIParams = {}
  self._uiControllerType = nil
  self._jumpUIType = nil
  self._jumpStateUIName = nil
  self._jumpNormalUIName = nil
  self._jumpNeedLoading = nil
  self._jumpLoadingHander = nil
  self._jumpLoadingSceneName = nil
  self._jumpUIParams = {}
end

function UIJumpModule:_ResetData()
  self._fromUIType = nil
  self._fromUIName = nil
  self._fromUIOfStateUI = nil
  self._fromUIParams = {}
  self._uiControllerType = nil
  self._jumpUIType = nil
  self._jumpStateUIName = nil
  self._jumpNormalUIName = nil
  self._jumpNeedLoading = nil
  self._jumpLoadingHander = nil
  self._jumpLoadingSceneName = nil
  self._jumpUIParams = {}
end

function UIJumpModule:SetFromUIData(fromUIType, fromUIName, fromUIOfStateUI, fromUIParams)
  self._fromUIType = fromUIType
  self._fromUIName = fromUIName
  self._fromUIOfStateUI = fromUIOfStateUI
  self._fromUIParams = fromUIParams
end

function UIJumpModule:SetJumpUIData(jumpUIType, jumpUIParams)
  self._uiControllerType, self._jumpUIType, self._jumpStateUIName, self._jumpNormalUIName, self._jumpNeedLoading, self._jumpLoadingHander, self._jumpLoadingSceneName, self._jumpUnLockID, self._jumpToSeasonMap = self:_SetJumpUIType(jumpUIType)
  if not jumpUIParams then
    self._jumpUIParams = {}
  else
    self._jumpUIParams = jumpUIParams
  end
end

function UIJumpModule:_SetJumpUIType(UIJumpType)
  local type = Id2UIName[UIJumpType].type
  local stateUI = Id2UIName[UIJumpType].stateUI
  local normalUI = Id2UIName[UIJumpType].normalUI
  local needLoading = Id2UIName[UIJumpType].needLoading
  local loadingHander = Id2UIName[UIJumpType].loadingHander
  local sceneName = Id2UIName[UIJumpType].sceneName
  local unLockID = Id2UIName[UIJumpType].unLockID
  local toSeasonMap = Id2UIName[UIJumpType].ToSeasonMap
  return UIJumpType, type, stateUI, normalUI, needLoading, loadingHander, sceneName, unLockID, toSeasonMap
end

function UIJumpModule:GetUnLockId(UIJumpType)
  return Id2UIName[UIJumpType].unLockID
end

function UIJumpModule:Goto(id, fromType, uiName, uiStateType, ...)
  local cfg = Cfg.cfg_jump[id]
  if not cfg then
    return
  end
  self:SetFromUIData(fromType, uiName, uiStateType, {
    ...
  })
  local jumpType = cfg.JumpID
  local jumpParams = cfg.JumpParam
  self:SetJumpUIData(jumpType, jumpParams)
  self:Jump()
end

function UIJumpModule:GotoWithItemGetPath(id, extParam, fromType, uiName, uiStateType, ...)
  local cfg = Cfg.cfg_jump[id]
  if not cfg then
    return
  end
  local param = {
    ...
  }
  self._gotoParam = param
  self:SetFromUIData(fromType, uiName, uiStateType, {
    ...
  })
  local jumpType = cfg.JumpID
  local jumpParams
  if cfg.JumpParam then
    jumpParams = {}
    for i, value in ipairs(cfg.JumpParam) do
      jumpParams[i] = value
    end
  end
  if jumpType == UIJumpType.UI_JumpAircraft and jumpParams and jumpParams[1] == OpenAircraftParamType.Spaceid then
    local airModule = GameGlobal.GetModule(AircraftModule)
    local gotoSpaceId = jumpParams[2]
    if gotoSpaceId then
      local space = airModule:GetSpaceInfo(gotoSpaceId)
      if space or self._gotoParam and self._gotoParam[1] and self._gotoParam[1].isSmeltRoom and not self._gotoParam[1].conform then
      else
        ToastManager.ShowToast("The Jump Space Is Not Open !")
        Log.debug("Space is nil !")
        return
      end
      if space then
        if space.space_status == SpaceState.SpaceStateFull then
          local room = airModule:GetRoom(gotoSpaceId)
          if room:GetRoomType() == AirRoomType.SmeltRoom then
            local lock = airModule:IsSmeltItemLock(extParam)
            if lock and (not (self._gotoParam and self._gotoParam[1]) or not self._gotoParam[1].isSmeltRoom) then
              ToastManager.ShowToast("The Jump Mat Is Not UnLock !")
              Log.debug("mat is lock !")
              return
            end
            if extParam then
              jumpParams[#jumpParams + 1] = extParam
              if self._gotoParam and self._gotoParam[1] then
                jumpParams[#jumpParams + 1] = self._gotoParam[1].NeedNumRawData
              end
            end
          end
        elseif self._gotoParam and self._gotoParam[1] and self._gotoParam[1].isSmeltRoom and not self._gotoParam[1].conform then
        else
          Log.debug("space.space_status ~= SpaceState.SpaceStateFull")
          return
        end
      end
    end
  end
  self:SetJumpUIData(jumpType, jumpParams)
  self:Jump()
end

function UIJumpModule:Jump()
  local currentStateUI = GameGlobal.UIStateManager():CurUIStateType()
  if currentStateUI == UIStateType.UIAircraft then
    if self._uiControllerType == UIJumpType.UI_JumpAircraft and self._jumpUIParams[2] == AircraftLayer.Smelt then
      GameGlobal.UIStateManager():CloseDialog("UIItemGetPathController")
      local controller = GameGlobal.UIStateManager():GetController("UIAircraftItemSmeltController")
      local gotoSpaceId = self._jumpUIParams[2]
      local airModule = GameGlobal.GetModule(AircraftModule)
      local space = airModule:GetSpaceInfo(gotoSpaceId)
      if not space then
        GameGlobal.UIStateManager():ShowDialog("UIAircraftRoomUnLockTipsController", AircraftLayer.Smelt)
        return
      end
      if controller then
        controller:OpenJump(self._jumpUIParams[3], self._jumpUIParams[4], true)
      else
        GameGlobal.UIStateManager():ShowDialog("UIAircraftItemSmeltController", self._jumpUIParams[3], self._jumpUIParams[4])
      end
    elseif self._uiControllerType == UIJumpType.UI_JumpAircraft then
      local param = self._jumpUIParams
      GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftOpenRoom, table.unpack(param))
    elseif self._uiControllerType == UIJumpType.UI_JumpDraw then
      self:_GotoJump()
    else
      GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftJumpOutTo, function()
        if self._jumpUIType == JumpUIType.NormalUI and self._uiControllerType == UIJumpType.UI_JumpMall then
          self._jumpUIType = JumpUIType.StateUI
          self._jumpStateUIName = UIStateType.UIShopController
          self._jumpNormalUIName = nil
        end
        self:_GotoJump()
      end)
    end
    return
  elseif currentStateUI == UISeasonHelper.CurSeasonSceneState() then
    if self._jumpNeedLoading then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.SeasonLeaveToBattle)
      self:_GotoJump()
    elseif self._jumpUIType == JumpUIType.NormalUI and self._jumpStateUIName == nil and self._jumpNormalUIName == "UIRecruit" then
      local seasonUIModule = GameGlobal.GetUIModule(SeasonModule)
      seasonUIModule:ExitSeasonTo(UIStateType.UIRecruit)
    elseif self._jumpUIType == JumpUIType.NormalUI and self._jumpStateUIName == nil then
      local seasonUIModule = GameGlobal.GetUIModule(SeasonModule)
      seasonUIModule:ExitSeasonTo(function()
        GameGlobal.UIStateManager():SwitchState(UIStateType.UIMain)
        GameGlobal.UIStateManager():Lock("JumpOutFromSeason")
        GameGlobal.TaskManager():StartTask(function(TT)
          YIELD(TT, 1000)
          GameGlobal.UIStateManager():UnLock("JumpOutFromSeason")
          self:_GotoJump()
        end)
      end)
    else
      local seasonUIModule = GameGlobal.GetUIModule(SeasonModule)
      seasonUIModule:ExitSeasonTo(function()
        self:_GotoJump()
      end)
    end
    return
  end
  if currentStateUI ~= UIStateType.UIAircraft and self._uiControllerType == UIJumpType.UI_JumpAircraft then
    local gotoSpaceId = self._jumpUIParams[2]
    local param = self._jumpUIParams[3]
    local param2 = self._jumpUIParams[4]
    local airModule = GameGlobal.GetModule(AircraftModule)
    local room = airModule:GetRoom(gotoSpaceId)
    local canJump = self._gotoParam and self._gotoParam[1] and self._gotoParam[1].isSmeltRoom and self._gotoParam[1].conform or not self._gotoParam or self._gotoParam and #self._gotoParam == 0
    if room and room:GetRoomType() == AirRoomType.SmeltRoom and canJump then
      local space = airModule:GetSpaceInfo(gotoSpaceId)
      if not space then
        ToastManager.ShowToast("Space is nil !")
        return
      end
      GameGlobal.UIStateManager():CloseDialog("UIItemGetPathController")
      local controller = GameGlobal.UIStateManager():GetController("UIAircraftItemSmeltController")
      if controller then
        controller:OpenJump(param, param2, true)
      else
        GameGlobal.UIStateManager():ShowDialog("UIAircraftItemSmeltController", param, param2)
      end
      return
    end
    if self._gotoParam and self._gotoParam[1] and self._gotoParam[1].isSmeltRoom then
      self._jumpUIParams = self._gotoParam[1].conform and self._jumpUIParams or {}
    end
  end
  if currentStateUI == UIStateType.UIMaze then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftJumpOutTo, function()
      if self._jumpUIType == JumpUIType.NormalUI then
        GameGlobal.UIStateManager():SwitchState(UIStateType.UIMain)
      end
      self:_GotoJump()
    end)
    return
  end
  if currentStateUI == UIStateType.UIHomeland then
    if self._uiControllerType == UIJumpType.UI_JumpHome and self._jumpUIParams and 0 < table.count(self._jumpUIParams) then
      local param = table.clone(self._jumpUIParams)
      if param then
        local isShowDialog = param[1]
        if isShowDialog and isShowDialog == 1 then
          local dialogName = HomeDialogEnum2DialogName[param[2]]
          table.remove(param, 2)
          table.remove(param, 1)
          local dialogParm = param
          local uiHomeModule = GameGlobal.GetUIModule(HomelandModule)
          uiHomeModule:SetDialog(dialogName, dialogParm)
          uiHomeModule:ShowDialog()
        end
      end
    end
    return
  end
  if self._jumpNormalUIName == "UISideEnterCenter" then
    local param = {
      campaign_id = self._jumpUIParams[1]
    }
    GameGlobal.UIStateManager():ShowDialog("UISideEnterCenterController", param)
    return
  end
  if self._jumpToSeasonMap then
    self:_GotoSeaonJump()
    return
  end
  self:_GotoJump()
end

function UIJumpModule:_GotoJump()
  if self._uiControllerType > UIJumpType.UI_JumpSeasonStart and self._uiControllerType < UIJumpType.UI_JumpSeasonEnd then
    Log.info("跳转到赛季:", self._uiControllerType)
    UIEventTrailerSeasonHelper.Jump(self._uiControllerType)
    return
  end
  if self._jumpUIType ~= nil then
    if self._uiControllerType == UIJumpType.UI_JumpQuest then
      local questType = self._jumpUnLockID[self._jumpUIParams[1]]
      if questType then
        local module = GameGlobal.GetModule(RoleModule)
        if module:CheckModuleUnlock(questType) == false then
          local cfg = Cfg.cfg_module_unlock[questType]
          if cfg then
            ToastManager.ShowToast(StringTable.Get(cfg.Tips))
          end
          return
        elseif GameGlobal.UIStateManager():IsShow("UIQuestController") then
          local args = table.unpack(self._jumpUIParams, 1, table.maxn(self._jumpUIParams))
          GameGlobal.EventDispatcher():Dispatch(GameEventType.ChangeQuestController, args)
          return
        end
      end
    else
      local unLockID = self._jumpUnLockID[1]
      if unLockID then
        local module = GameGlobal.GetModule(RoleModule)
        if module:CheckModuleUnlock(unLockID) == false then
          Log.debug("###jumpModule -- 没有解锁-id", unLockID)
          local cfg = Cfg.cfg_module_unlock[unLockID]
          if cfg then
            ToastManager.ShowToast(StringTable.Get(cfg.Tips))
          end
          return
        else
          Log.debug("###jumpModule -- 解锁了-id", unLockID)
        end
      end
    end
    if self._uiControllerType == UIJumpType.UI_JumpMission then
      local module = GameGlobal.GetModule(MissionModule)
      local data = module:GetDiscoveryData()
      if self._jumpUIParams and table.count(self._jumpUIParams) > 0 then
        local newParams = {}
        if self._jumpUIParams[1] == 1 then
          local discoveryData = module:GetDiscoveryData()
          local node = discoveryData:GetCanPlayNode()
          table.insert(newParams, node.stages[1].id)
        else
          newParams = self._jumpUIParams
        end
        DiscoveryData.EnterStateUIDiscovery(6, table.unpack(newParams, 1, table.maxn(newParams)))
      else
        DiscoveryData.EnterStateUIDiscovery(1)
      end
      return
    end
    if self._uiControllerType == UIJumpType.UI_JumpExMissionStage then
      local extId = self._jumpUIParams[1]
      local stageId = self._jumpUIParams[2]
      local extModule = GameGlobal.GetModule(ExtMissionModule)
      local extState = extModule:UI_GetExtMissionState(extId)
      if extState == EnumExtMissionState.Disable then
        ToastManager.ShowToast(StringTable.Get("str_extra_mission_public_chapter_is_lock"))
        return
      end
      local star = extModule:UI_GetExtTaskState(extId, stageId)
      if star < 0 then
        local cfg_extra_mission = Cfg.cfg_extra_mission[extId]
        local stagelist = cfg_extra_mission.ExtTaskList
        for i = 1, #stagelist do
          local star = extModule:UI_GetExtTaskState(extId, stagelist[i])
          if star <= 0 then
            self._jumpUIParams[2] = stagelist[i]
            break
          end
        end
      end
    end
    if self._uiControllerType == UIJumpType.UI_JumpPetDetail or self._uiControllerType == UIJumpType.UI_JumpPetUpLevel or self._uiControllerType == UIJumpType.UI_JumpPetBreak or self._uiControllerType == UIJumpType.UI_JumpPetAwaken or self._uiControllerType == UIJumpType.UI_JumpPetFile then
      local petid = self._jumpUIParams[1]
      local petModule = GameGlobal.GetModule(PetModule)
      local pet = petModule:GetPetByTemplateId(petid)
      if not pet then
        self:SetJumpUIData(UIJumpType.UI_JumpPet, self._jumpUIParams)
      end
    end
    if self._uiControllerType == UIJumpType.UI_JumpNotice and SDKProxy:GetInstance():IsInternationalSDK() and NoNoticeOut then
      return
    end
    if self._uiControllerType == UIJumpType.UI_WebView then
      local www = self._jumpUIParams[1]
      if string.isnullorempty(www) then
        Log.fatal("### jump param is empty.")
      else
        SDKProxy:GetInstance():OpenUrl(www)
        return
      end
    end
    if self._uiControllerType == UIJumpType.UI_JumpHome and self._jumpUIParams and table.count(self._jumpUIParams) > 0 then
      local param = table.clone(self._jumpUIParams)
      if param then
        local isShowDialog = param[1]
        if isShowDialog and isShowDialog == 1 then
          local dialogName = HomeDialogEnum2DialogName[param[2]]
          table.remove(param, 2)
          table.remove(param, 1)
          local dialogParm = param
          local uiHomeModule = GameGlobal.GetUIModule(HomelandModule)
          uiHomeModule:SetDialog(dialogName, dialogParm)
        end
      end
    end
    if self._jumpUIType == JumpUIType.NormalUI then
      if self._jumpStateUIName == nil then
        GameGlobal.UIStateManager():ShowDialog(self._jumpNormalUIName, table.unpack(self._jumpUIParams, 1, table.maxn(self._jumpUIParams)))
      end
    elseif self._jumpUIType == JumpUIType.StateUI then
      if self._jumpNeedLoading == true then
        GameGlobal.LoadingManager():StartLoading(self._jumpLoadingHander, self._jumpLoadingSceneName, table.unpack(self._jumpUIParams, 1, table.maxn(self._jumpUIParams)))
      elseif self._uiControllerType == 3 then
        GameGlobal.UIStateManager():SwitchState(self._jumpStateUIName, self._jumpUIParams)
      else
        GameGlobal.UIStateManager():SwitchState(self._jumpStateUIName, table.unpack(self._jumpUIParams, 1, table.maxn(self._jumpUIParams)))
      end
    elseif self._jumpUIType == JumpUIType.StateUIAndNormalUI then
      self._openUICallback = GameHelper:GetInstance():CreateCallback(self.UIOpenHandleJump, self)
      GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.UIOpen, self._openUICallback)
      GameGlobal.UIStateManager():SwitchState(self._jumpStateUIName)
    end
  end
end

function UIJumpModule:_GotoSeaonJump()
  local seasonUIModule = GameGlobal.GetUIModule(SeasonModule)
  if self._jumpNormalUIName then
    seasonUIModule:SetDefaultDialog(self._jumpNormalUIName)
  end
  seasonUIModule:EnterCurrentSeasonMainUI()
end

function UIJumpModule:_BackFromUI()
  if self._fromUIType ~= nil then
    if self._fromUIType == FromUIType.StateUI then
      GameGlobal.UIStateManager():SwitchState(self._fromUIName, self._fromUIParams)
      self:_ResetData()
    elseif self._fromUIType == FromUIType.NormalUI then
      self._openUICallback = GameHelper:GetInstance():CreateCallback(self.UIOpenHandleFrom, self)
      GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.UIOpen, self._openUICallback)
      GameGlobal.UIStateManager():SwitchState(self._fromUIOfStateUI)
    end
  end
end

function UIJumpModule:UIOpenHandleFrom(uiname)
  local n = GameGlobal.UIStateManager().registeredStateDic[self._jumpStateUIName]
  if uiname == n.defaultUIList[1] then
    GameGlobal.UIStateManager():ShowDialog(self._jumpNormalUIName, table.unpack(self._jumpUIParams, 1, table.maxn(self._jumpUIParams)))
    self:_ResetData()
  end
  GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.UIOpen, self._openUICallback)
end

function UIJumpModule:UIOpenHandleJump(uiname)
  local n = GameGlobal.UIStateManager().registeredStateDic[self._fromUIOfStateUI]
  if uiname == n.defaultUIList[1] then
    GameGlobal.UIStateManager():ShowDialog(self._fromUIName, table.unpack(self._fromUIParams, 1, table.maxn(self._fromUIParams)))
    self:_ResetData()
  end
  GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.UIOpen, self._openUICallback)
end

function UIJumpModule:CheckUIOpenType(uiName)
  if self._jumpUIType ~= nil then
    if self._jumpStateUIName ~= nil and self._jumpStateUIName == uiName then
      self:_BackFromUI()
      return true
    end
    if self._jumpNormalUIName ~= nil and self._jumpNormalUIName == uiName then
      self:_BackFromUI()
      return true
    end
    return false
  end
  return false
end
