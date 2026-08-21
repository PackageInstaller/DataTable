_class("UIRegister", Singleton)
UIRegister = UIRegister
require("audio_const")
UIRegister.registeredUIs = {
  UIMonitorController = {
    uiPrefab = "UIMonitor.prefab"
  },
  UIResLeak = {
    uiPrefab = "UIResLeak.prefab"
  },
  UIGameStatus = {
    uiPrefab = "UIGameStatus.prefab"
  },
  UILoginEmpty = {
    uiPrefab = "UILoginEmpty.prefab"
  },
  UIMainLobbyController = {
    uiPrefab = "UIMainLobbyController.prefab"
  },
  UITestFuncController = {
    uiPrefab = "UITestFuncController.prefab"
  },
  UISideEnterCenterController = {
    uiPrefab = "UISideEnterCenterController.prefab",
    hideUnderLayer = HideUnderLayerType.Manual_Hide,
    maskType = MaskType.MT_None
  },
  UISideEnterCenterSingleController = {
    uiPrefab = "UISideEnterCenterSingleController.prefab",
    maskType = MaskType.MT_None
  },
  UIPetForecast = {
    uiPrefab = "UIPetForecast.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIPetForecast2 = {
    uiPrefab = "UIPetForecast2.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIMailController = {
    uiPrefab = "UIMailController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIMailContentController = {
    uiPrefab = "UIMailContentController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIChatController = {
    uiPrefab = "UIChatController.prefab",
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIChatFriendInfoController = {
    uiPrefab = "UIChatFriendInfoController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIChatDeleteFriendController = {
    uiPrefab = "UIChatDeleteFriendController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIChatDontFriendTipsController = {
    uiPrefab = "UIChatDontFriendTipsController.prefab",
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIChatSetNoteNameController = {
    uiPrefab = "UIChatSetNoteNameController.prefab",
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIChatBlackListController = {
    uiPrefab = "UIChatBlackListController.prefab",
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIChatAddBlacklistController = {
    uiPrefab = "UIChatAddBlacklistController.prefab",
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIChatRemoveBlacklistController = {
    uiPrefab = "UIChatRemoveBlacklistController.prefab",
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UICommonLoading = {
    uiPrefab = "UICommonLoading.prefab",
    maskType = MaskType.MT_None
  },
  UILevelUp = {
    uiPrefab = "UILevelUp.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISetParamOnShowComponent = {
        [UIComponentParamType.KeepVoice] = true
      }
    }
  },
  UIStoryController = {
    uiPrefab = "UIStory.prefab",
    maskType = MaskType.MT_None
  },
  UIDemoPrepare = {
    uiPrefab = "UIDemoPrepare.prefab"
  },
  UIBackPackController = {
    uiPrefab = "UIBackPackController.prefab"
  },
  UIGetItemController = {
    uiPrefab = "UIGetItemController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {},
      UISetParamOnShowComponent = {
        [UIComponentParamType.KeepVoice] = true
      }
    }
  },
  UIBackPackBox = {
    uiPrefab = "UIBackPackBox.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIPetBackPackBox = {
    uiPrefab = "UIPetBackPackBox.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIPetBackPackConfirm = {
    uiPrefab = "UIPetBackPackConfirm.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIBackPackBoxGain = {
    uiPrefab = "UIBackPackBoxGain.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIAmbientPanel = {
    uiPrefab = "UIAmbientPanel.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIItemGetPathController = {
    uiPrefab = "UIItemGetPathController.prefab",
    maskType = MaskType.MT_None
  },
  UIItemSaleAndUseWithCountController = {
    uiPrefab = "UIItemSaleAndUseWithCountController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIDiscovery = {
    uiPrefab = "UIDiscovery.prefab",
    maskType = MaskType.MT_MoreBlackMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMDiscovery
    }
  },
  UIChapters = {
    uiPrefab = "UIChapters.prefab",
    maskType = MaskType.MT_None
  },
  UIChapterAward = {
    uiPrefab = "UIChapterAward.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIDiscoveryPart = {
    uiPrefab = "UIDiscoveryPart.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIDiscoveryPartUnlock = {
    uiPrefab = "UIDiscoveryPartUnlock.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIMazeEnter = {
    uiPrefab = "UIMazeEnter.prefab",
    maskType = MaskType.MT_None
  },
  UIPlotEnter = {
    uiPrefab = "UIPlotEnter.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIDiscoveryUnlock = {
    uiPrefab = "UIDiscoveryUnlock.prefab",
    maskType = MaskType.MT_None
  },
  UIHeartSpiritController = {
    uiPrefab = "UIHeartSpiritController.prefab",
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIUpLevelInterfaceController = {
    uiPrefab = "UIUpLevelInterfaceController.prefab",
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIGradeInterfaceController = {
    uiPrefab = "UIGradeInterfaceController.prefab"
  },
  UIBreakController = {
    uiPrefab = "UIBreakController.prefab",
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UISpiritDetailGroupController = {
    uiPrefab = "UISpiritDetailGroupController.prefab",
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIPetSkillDetailController = {
    uiPrefab = "UIPetSkillDetailController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIPetIntimacyMainController = {
    uiPrefab = "UIPetIntimacyMainController.prefab",
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIPetIntimacyImageRecallController = {
    uiPrefab = "UIPetIntimacyImageRecallController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIPetIntimacyStumbles = {
    uiPrefab = "UIPetIntimacyStumbles.prefab",
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIPetIntimacyLevelUp = {
    uiPrefab = "UIPetIntimacyLevelUp.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {},
      UISetParamOnShowComponent = {
        [UIComponentParamType.KeepVoice] = true
      }
    }
  },
  UISpiritDetailLookCgAndSpineController = {
    uiPrefab = "UISpiritDetailLookCgAndSpineController.prefab"
  },
  UIStage = {
    uiPrefab = "UIStage.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIEnemyTip = {
    uiPrefab = "UIEnemyTip.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIEnemyBookTip = {
    uiPrefab = "UIEnemyBookTip.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIPlot = {
    uiPrefab = "UIPlot.prefab",
    maskType = MaskType.MT_None
  },
  UITeams = {
    uiPrefab = "UITeams.prefab"
  },
  UITeamsGuide = {
    uiPrefab = "UITeamsGuide.prefab"
  },
  UITeamsNameModify = {
    uiPrefab = "UITeamsNameModify.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISkillScope = {
    uiPrefab = "UISkillScope.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UITeamChangeController = {
    uiPrefab = "UITeamChangeController.prefab",
    uiComponents = {
      UISetParamOnShowComponent = {
        [UIComponentParamType.KeepVoice] = true
      }
    }
  },
  UIStageRecordController = {
    uiPrefab = "UIStageRecord.prefab",
    maskType = MaskType.MT_LessBlackMask
  },
  UIBattle = {
    uiPrefab = "UIBattle.prefab"
  },
  UIBattleInfo = {
    uiPrefab = "UIBattleInfo.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIBattleQuit = {
    uiPrefab = "UIBattleQuit.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIFeatureSanInfo = {
    uiPrefab = "UIFeatureSanInfo.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIFeatureAlgorithmUpgradeInfo = {
    uiPrefab = "UIFeatureAlgorithmUpgradeInfo.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIFeatureShopInfo = {
    uiPrefab = "UIFeatureShopInfo.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIFeatureAlchemyInfo = {
    uiPrefab = "UIFeatureAlchemyInfo.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIBattleTeamState = {
    uiPrefab = "UIBattleTeamState.prefab",
    maskType = MaskType.MT_LessBlackMask
  },
  UIBattleResultComplete = {
    uiPrefab = "UIBattleResultComplete.prefab",
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIBattleResultRevive = {
    uiPrefab = "UIBattleResultRevive.prefab",
    maskType = MaskType.MT_None
  },
  UIBattleBossWarning = {
    uiPrefab = "UIBattleBossWarning.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {},
      UISetParamOnShowComponent = {
        [UIComponentParamType.KeepVoice] = true
      }
    }
  },
  UIBattleBossSpeakDialog = {
    uiPrefab = "UIBattleBossSpeakDialog.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISetParamOnShowComponent = {
        [UIComponentParamType.KeepVoice] = true
      }
    }
  },
  UIHarvestTime = {
    uiPrefab = "UIHarvestTime.prefab",
    maskType = MaskType.MT_None
  },
  UISuperChainSkill = {
    uiPrefab = "UISuperChainSkill.prefab",
    maskType = MaskType.MT_LessBlackMask
  },
  UIBattleWaveSwitch = {
    uiPrefab = "UIBattleWaveSwitch.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIBattleZeroRoundWarning = {
    uiPrefab = "UIBattleZeroRoundWarning.prefab",
    maskType = MaskType.MT_None
  },
  UIBattleOutOfRoundPunishWarn = {
    uiPrefab = "UIBattleOutOfRoundPunishWarn.prefab",
    maskType = MaskType.MT_None
  },
  UIBattleBonus = {
    uiPrefab = "UIBattleStart.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISetParamOnShowComponent = {
        [UIComponentParamType.KeepVoice] = true
      }
    }
  },
  UIBattleCheat = {
    uiPrefab = "UIBattleCheat.prefab"
  },
  UIBattleChangeTeamLeader = {
    uiPrefab = "UIBattleChangeTeamLeader.prefab",
    maskType = MaskType.MT_None
  },
  UIBattleUltraSkillCG = {
    uiPrefab = "UIBattleUltraSkillCG.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISetParamOnShowComponent = {
        [UIComponentParamType.KeepVoice] = true
      }
    }
  },
  UIBattlePersonaSkillEffTop = {
    uiPrefab = "UIBattlePersonaSkillEffTop.prefab",
    maskType = MaskType.MT_None
  },
  UIPetObtain = {
    uiPrefab = "UIPetObtain.prefab",
    maskType = MaskType.MT_None
  },
  UIDragImageController = {
    uiPrefab = "UIDragImage.prefab"
  },
  UITestEntry = {
    uiPrefab = "UITestEntry.prefab",
    maskType = MaskType.MT_Default
  },
  UIExtraMissionDetailController = {
    uiPrefab = "UIExtraMissionDetailController.prefab",
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMDiscovery,
      UITransitionComponent = {}
    }
  },
  UIExtraMissionStageController = {
    uiPrefab = "UIExtraMissionStageController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMDiscovery,
      UITransitionComponent = {}
    }
  },
  UIExtraMissionAwardController = {
    uiPrefab = "UIExtraMissionAwardController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIPowerInfoRunTimeController = {
    uiPrefab = "UIPowerInfoRunTimeController.prefab",
    maskType = MaskType.MT_None
  },
  UIEmptyController = {
    uiPrefab = "UIEmptyController.prefab",
    maskType = MaskType.MT_None
  },
  UIAircraftController = {
    uiPrefab = "UIAircraft.prefab",
    maskType = MaskType.MT_None
  },
  UIAircraftRoomLevelUpController = {
    uiPrefab = "UIAircraftRoomLevelUp.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIAircraftPreconditionController = {
    uiPrefab = "UIAircraftPrecondition.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIAircraftRoomLevelDownController = {
    uiPrefab = "UIAircraftRoomLevelDown.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIAircraftConfirmDialogController = {
    uiPrefab = "UIAircraftConfirmDialog.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIAircraftEvilInfoController = {
    uiPrefab = "UIAircraftEvilInfo.prefab",
    maskType = MaskType.MT_None
  },
  UIAircraftEvilClearController = {
    uiPrefab = "UIAircraftEvilClear.prefab",
    maskType = MaskType.MT_None
  },
  UIPowerExchangeController = {
    uiPrefab = "UIPowerExchange.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIAircraftFireflySpeedupController = {
    uiPrefab = "UIAircraftFireflySpeedup.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIAircraftSpaceCleanController = {
    uiPrefab = "UIAircraftSpaceClean.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIAircraftBuildRoomController = {
    uiPrefab = "UIAircraftBuildRoomController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIAircraftEnterBuildController = {
    uiPrefab = "UIAircraftEnterBuildController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIAircraftRoomInteractiveEventController = {
    uiPrefab = "UIAircraftInteractiveEventInfo.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIAircraftUnlockFileController = {
    uiPrefab = "UIAircraftUnlockFile.prefab",
    maskType = MaskType.MT_None
  },
  UIAircraftItemSmeltController = {
    uiPrefab = "UIAircraftItemSmeltController.prefab",
    maskType = MaskType.MT_Default
  },
  UIAircraftDecorateController = {
    uiPrefab = "UIAircraftDecorateController.prefab",
    maskType = MaskType.MT_None
  },
  UISmeltAtomExchangeController = {
    uiPrefab = "UISmeltAtomExchange.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIAircraftDecorateTip = {
    uiPrefab = "UIAircraftDecorateTip.prefab",
    maskType = MaskType.MT_None
  },
  UIHomelandMain = {
    uiPrefab = "UIHomelandMain.prefab",
    maskType = MaskType.MT_None
  },
  UIHomelandBuild = {
    uiPrefab = "UIHomelandBuild.prefab",
    maskType = MaskType.MT_None
  },
  UIHomelandBuildEditRotate = {
    uiPrefab = "UIHomelandBuildEditRotate.prefab",
    maskType = MaskType.MT_None
  },
  UIHomelandShopController = {
    uiPrefab = "UIHomelandShopController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomelandShopBuyConfirm = {
    uiPrefab = "UIHomelandShopBuyConfirm.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomelandShopSellConfirm = {
    uiPrefab = "UIHomelandShopSellConfirm.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIBuildInfo = {
    uiPrefab = "UIBuildInfo.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIBuildSkinTips = {
    uiPrefab = "UIBuildSkinTips.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIForge = {
    uiPrefab = "UIForge.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIForgeDetail = {
    uiPrefab = "UIForgeDetail.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIForgeSpeed = {
    uiPrefab = "UIForgeSpeed.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomelandMessageBox = {
    uiPrefab = "UIHomelandMessageBox.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomelandMessageBox_Items = {
    uiPrefab = "UIHomelandMessageBox_Items.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIItemTipsHomeland = {
    uiPrefab = "UIItemTipsHomeland.prefab",
    maskType = MaskType.MT_None
  },
  UIHomelandBackpack = {
    uiPrefab = "UIHomelandBackpack.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIHomelandToolLevelUp = {
    uiPrefab = "UIHomelandToolLevelUp.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomelandGetPath = {
    uiPrefab = "UIHomelandGetPath.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomelandSaleAndUseWithCount = {
    uiPrefab = "UIHomelandSaleAndUseWithCount.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomelandBackpackBox = {
    uiPrefab = "UIHomelandBackpackBox.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomelandBackPackBoxGain = {
    uiPrefab = "UIHomelandBackPackBoxGain.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UITreasureBoard = {
    uiPrefab = "UITreasureBoard.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIBuildRaiseFish = {
    uiPrefab = "UIBuildRaiseFish.prefab",
    maskType = MaskType.MT_None
  },
  UIBuildCollectCoin = {
    uiPrefab = "UIBuildCollectCoin.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIBuildCollectCoinTask = {
    uiPrefab = "UIBuildCollectCoinTask.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIHomelandLevel = {
    uiPrefab = "UIHomelandLevel.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomelandLevelSignPop = {
    uiPrefab = "UIHomelandLevelSignPop.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomelandLevelExpTips = {
    uiPrefab = "UIHomelandLevelExpTips.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomeTopTips = {
    uiPrefab = "UIHomeTopTips.prefab",
    maskType = MaskType.MT_None
  },
  UIHomelandMedalWall = {
    uiPrefab = "UIHomelandMedalWall.prefab",
    maskType = MaskType.MT_None
  },
  UIStoryViewerController = {
    uiPrefab = "UIStoryViewer.prefab",
    MaskType = MaskType.MT_Default
  },
  UIVideo = {
    uiPrefab = "UIVideo.prefab"
  },
  UIStoryBanner = {
    uiPrefab = "UIStoryBanner.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISetParamOnShowComponent = {
        [UIComponentParamType.KeepVoice] = true
      }
    }
  },
  UISetController = {
    uiPrefab = "UISetController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UICredits = {
    uiPrefab = "UICredits.prefab",
    maskType = MaskType.MT_None
  },
  UIColorBlind = {
    uiPrefab = "UIColorBlind.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISetAgeConfirmController = {
    uiPrefab = "UISetAgeConfirmController.prefab"
  },
  UISetDataCopyController = {
    uiPrefab = "UISetDataCopyController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISetPrivacySetController = {
    uiPrefab = "UISetPrivacySetController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISetPrivacySetTipsController = {
    uiPrefab = "UISetPrivacySetTipsController.prefab"
  },
  UISetChangePasswdController = {
    uiPrefab = "UISetChangePasswdController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISkillEditorController = {
    uiPrefab = "SkillEditor.prefab"
  },
  UISetBindChannelController = {
    uiPrefab = "UISetBindChannelController.prefab"
  },
  UISetBindChannelTipsController = {
    uiPrefab = "UISetBindChannelTipsController.prefab"
  },
  UISetBindMailController = {
    uiPrefab = "UISetBindMailController.prefab"
  },
  UISetBindMailChangePasswordController = {
    uiPrefab = "UISetBindMailChangePasswordController.prefab"
  },
  UIMazeController = {
    uiPrefab = "UIMaze.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMMaze
    }
  },
  UIRugueLikeRestRoomController = {
    uiPrefab = "UIRugueLikeRestRoomController.prefab",
    maskType = MaskType.MT_None
  },
  UIRugueLikeChooseCardController = {
    uiPrefab = "UIRugueLikeChooseCardController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIRugueLikeBattleResultController = {
    uiPrefab = "UIRugueLikeBattleResultController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {},
      UISetParamOnShowComponent = {
        [UIComponentParamType.KeepVoice] = true
      },
      UISwitchBGMComponent = CriAudioIDConst.BGMBattleSuccess
    }
  },
  UIRugueLikeDefeatedController = {
    uiPrefab = "UIRugueLikeDefeatedController.prefab",
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMBattleFail
    }
  },
  UIRugueLikeBackpackController = {
    uiPrefab = "UIRugueLikeBackpackController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIRugueLikeResetMsgBoxController = {
    uiPrefab = "UIRugueLikeResetMsgBoxController.prefab",
    maskType = MaskType.MT_None
  },
  UIHelpController = {
    uiPrefab = "UIHelpController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIRugueLikeLastStageTipController = {
    uiPrefab = "UIRugueLikeLastStageTipController.prefab"
  },
  UIResEntryController = {
    uiPrefab = "UIResEntryController.prefab",
    maskType = MaskType.MT_None
  },
  UIResDetailController = {
    uiPrefab = "UIResDetailController.prefab",
    uiComponents = {
      UITransitionComponent = {},
      UISwitchBGMComponent = CriAudioIDConst.BGMDiscovery
    }
  },
  UIShopController = {
    uiPrefab = "UIShopController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMShop
    }
  },
  UIPayLawTipsController = {
    uiPrefab = "UIPayLawTipsController.prefab"
  },
  UIPayLawContentController = {
    uiPrefab = "UIPayLawContentController.prefab"
  },
  UIShopConfirmNormalController = {
    uiPrefab = "UIShopConfirmNormalController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIShopConfirmDetailController = {
    uiPrefab = "UIShopConfirmDetailController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIShopPetDetailController = {
    uiPrefab = "UIShopPetDetailController.prefab"
  },
  UIShopGiftPackDetail = {
    uiPrefab = "UIShopGiftPackDetail.prefab",
    maskType = MaskType.MT_None
  },
  UIShopCurrency1To2 = {
    uiPrefab = "UIShopCurrency1To2.prefab",
    maskType = MaskType.MT_MoreBlackMask
  },
  UIShopRechargeGain = {
    uiPrefab = "UIShopRechargeGain.prefab",
    maskType = MaskType.MT_None
  },
  UIItemTips = {
    uiPrefab = "UIItemTips.prefab",
    maskType = MaskType.MT_None
  },
  UIQuestAchievementPointAwardsController = {
    uiPrefab = "UIQuestAchievementPointAwardsController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIQuestAwardsInfoController = {
    uiPrefab = "UIQuestAwardsInfoController.prefab"
  },
  UIQuestController = {
    uiPrefab = "UIQuestController.prefab",
    maskType = MaskType.MT_None
  },
  UIQuestAchievementFinishList = {
    uiPrefab = "UIQuestAchievementFinishList.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UIGuidePopController = {
    uiPrefab = "UIGuidePopController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIGuideCircleController = {
    uiPrefab = "UIGuideCircleController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISetParamOnShowComponent = {
        [UIComponentParamType.KeepVoice] = true
      }
    }
  },
  UIGuideCircleModelController = {
    uiPrefab = "UIGuideCircleModelController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISetParamOnShowComponent = {
        [UIComponentParamType.KeepVoice] = true
      }
    }
  },
  UIGuideAttrController = {
    uiPrefab = "UIGuideAttrController.prefab",
    maskType = MaskType.MT_None
  },
  UIGuideVideoController = {
    uiPrefab = "UIGuideVideoController.prefab",
    maskType = MaskType.MT_None
  },
  UIGuideFailedController = {
    uiPrefab = "UIGuideFailedController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIGuideModelController = {
    uiPrefab = "UIGuideModelController.prefab"
  },
  UIDrawCardController = {
    uiPrefab = "UIDrawCard.prefab"
  },
  UIDrawCardAwardPoolDetailController = {
    uiPrefab = "UIDrawCardAwardPoolDetail.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIDrawCardMultipleShowController = {
    uiPrefab = "UIDrawCardMultipleShow.prefab",
    maskType = MaskType.MT_None
  },
  UIDrawCardConfirmController = {
    uiPrefab = "UIDrawCardConfirm.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIDrawCardAnimController = {
    uiPrefab = "UIDrawCardAnim.prefab",
    maskType = MaskType.MT_None
  },
  UIUnObtainSixPetController = {
    uiPrefab = "UIUnObtainSixPetController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIDrawCardAwardConversionForOtherController = {
    uiPrefab = "UIDrawCardAwardConversionForOtherController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIFunctionLockTipsController = {
    uiPrefab = "UIFunctionLockTipsController.prefab"
  },
  UITopTipsController = {
    uiPrefab = "UITopTipsController.prefab",
    maskType = MaskType.MT_None
  },
  UISelectInfoEmptyController = {
    uiPrefab = "UISelectInfoEmptyController.prefab",
    maskType = MaskType.MT_None
  },
  UINoticeController = {
    uiPrefab = "UINoticeController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {},
      UISetParamOnShowComponent = {
        [UIComponentParamType.KeepVoice] = true
      }
    }
  },
  UILoginNoticeController = {
    uiPrefab = "UILoginNoticeController.prefab",
    maskType = MaskType.MT_None
  },
  UIChooseAssistantController = {
    uiPrefab = "UIChooseAssistantController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIRestrainTips = {
    uiPrefab = "UIRestrainTips.prefab",
    maskType = MaskType.MT_LessBlackMask
  },
  UIThreeStarTips = {
    uiPrefab = "UIThreeStarTips.prefab",
    maskType = MaskType.MT_LessBlackMask
  },
  UIRelicInfoController = {
    uiPrefab = "UIRelicInfoController.prefab",
    maskType = MaskType.MT_None
  },
  UIGradeSkillPanelController = {
    uiPrefab = "UIGradeSkillPanelController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIBookEntryController = {
    uiPrefab = "UIBookEntryController.prefab",
    maskType = MaskType.MT_MoreBlackMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIBookCGPreviewController = {
    uiPrefab = "UIBookCGPreviewController.prefab",
    maskType = MaskType.MT_MoreBlackMask
  },
  UIBookRoleEntryController = {
    uiPrefab = "UIBookRoleEntryController.prefab",
    maskType = MaskType.MT_MoreBlackMask
  },
  UIBookRoleRelationController = {
    uiPrefab = "UIBookRoleRelationController.prefab",
    maskType = MaskType.MT_MoreBlackMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIBookRoleRelationShowController = {
    uiPrefab = "UIBookRoleRelationShowController.prefab",
    maskType = MaskType.MT_MoreBlackMask
  },
  UIBookRoleMapController = {
    uiPrefab = "UIBookRoleMapController.prefab",
    maskType = MaskType.MT_MoreBlackMask
  },
  UIPlayerInfoController = {
    uiPrefab = "UIPlayerInfoController.prefab",
    hideUnderLayer = HideUnderLayerType.Auto_Hide,
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIPlayerInfoBg = {
    uiPrefab = "UIPlayerInfoBg.prefab",
    maskType = MaskType.MT_None
  },
  UIPlayerInfoShare = {
    uiPrefab = "UIPlayerInfoShare.prefab",
    maskType = MaskType.MT_None
  },
  UIChangeNameController = {
    uiPrefab = "UIChangeNameController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIChangeSignController = {
    uiPrefab = "UIChangeSignController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIChangeTitleController = {
    uiPrefab = "UIChangeTitleController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIChangeEmblazonryController = {
    uiPrefab = "UIChangeEmblazonryController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIChangeHeadController = {
    uiPrefab = "UIChangeHeadController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UITowerController = {
    uiPrefab = "UITower.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {},
      UISwitchBGMComponent = CriAudioIDConst.BGMTower
    }
  },
  UITowerRecordController = {
    uiPrefab = "UITowerRecord.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UITowerLayerController = {
    uiPrefab = "UITowerLayer.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMTower
    }
  },
  UIWeChatController = {
    uiPrefab = "UIWeChatController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIWeChatChangeNameController = {
    uiPrefab = "UIWeChatChangeNameController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIWeChatJumpController = {
    uiPrefab = "UIWeChatJumpController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIDemoPayController = {
    uiPrefab = "UIDemoPayController.prefab",
    maskType = MaskType.MT_None
  },
  UIPayTokenInputTest = {
    uiPrefab = "UIPayTokenInputTest.prefab",
    maskType = MaskType.MT_None
  },
  UIStageTestController = {
    uiPrefab = "UIStageTest.prefab",
    maskType = MaskType.MT_None
  },
  UICutsceneTestController = {
    uiPrefab = "UICutsceneTest.prefab",
    maskType = MaskType.MT_None
  },
  UIAircraftSendGiftController = {
    uiPrefab = "UIAircraftSendGiftController.prefab",
    maskType = MaskType.MT_None
  },
  UISkillHrefInfo = {
    uiPrefab = "UISkillHrefInfo.prefab",
    maskType = MaskType.MT_None
  },
  UIPetEquipController = {
    uiPrefab = "UIPetEquipController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIPetEquipIntrController = {
    uiPrefab = "UIPetEquipIntrController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIPetEquipUpLevelController = {
    uiPrefab = "UIPetEquipUpLevelController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIPetEquipUpLvInfoController = {
    uiPrefab = "UIPetEquipUpLvInfoController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHelpPetManageController = {
    uiPrefab = "UIHelpPetManageController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIHelpPetInfoController = {
    uiPrefab = "UIHelpPetInfoController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIHelpPetSelectController = {
    uiPrefab = "UIHelpPetSelectController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UILuaLeak = {
    uiPrefab = "UIResLeak.prefab"
  },
  UIDispatchMapController = {
    uiPrefab = "UIDispatchMapController.prefab"
  },
  UIDispatchDetailController = {
    uiPrefab = "UIDispatchDetailController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIBookController = {
    uiPrefab = "UIBookController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIBookInfoController = {
    uiPrefab = "UIBookInfoController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIDispatchSelectPetController = {
    uiPrefab = "UIDispatchSelectPetController.prefab"
  },
  UIDispatchGiveUpController = {
    uiPrefab = "UIDispatchGiveUpController.prefab"
  },
  UISignInController = {
    uiPrefab = "UISignInController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {},
      UISetParamOnShowComponent = {
        [UIComponentParamType.KeepVoice] = true
      }
    }
  },
  UIChooseMainBgController = {
    uiPrefab = "UIChooseMainBgController.prefab",
    maskType = MaskType.MT_None
  },
  UIAlbumController = {
    uiPrefab = "UIAlbum.prefab"
  },
  UICampaignShopController = {
    uiPrefab = "UICampaignShopController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMEveSinsaShop
    }
  },
  UICampaignShopConfirmDetailController = {
    uiPrefab = "UICampaignShopConfirmDetailController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UICampaignShopConfirmNormalController = {
    uiPrefab = "UICampaignShopConfirmNormalController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityGiftPackDetail = {
    uiPrefab = "UIActivityGiftPackDetail.prefab",
    maskType = MaskType.MT_None
  },
  UIActivityEveSinsaMainController = {
    uiPrefab = "UIActivityEveSinsaMainController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMEveSinsa
    }
  },
  UIActivityEveSinsaTaskController = {
    uiPrefab = "UIActivityEveSinsaTaskController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityEveSinsaLevelAController = {
    uiPrefab = "UIActivityEveSinsaLevelAController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMEveSinsa
    }
  },
  UIActivityEveSinsaLevelBController = {
    uiPrefab = "UIActivityEveSinsaLevelBController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {},
      UISwitchBGMComponent = CriAudioIDConst.BGMEveSinsa
    }
  },
  UIActivityStage = {
    uiPrefab = "UIStage.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityPlotEnter = {
    uiPrefab = "UIPlotEnter.prefab",
    maskType = MaskType.MT_LessBlackMask
  },
  UITrailLevelBuffTips = {
    uiPrefab = "UITrailLevelBuffTips.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UITrailLevelBuffDes = {
    uiPrefab = "UITrailLevelBuffDes.prefab"
  },
  UITrailLevelController = {
    uiPrefab = "UITrailLevelController.prefab"
  },
  UITrailLevelRewardController = {
    uiPrefab = "UITrailLevelRewardController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UITrailLevelDetail = {
    uiPrefab = "UITrailLevelDetail.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UITalePetList = {
    uiPrefab = "UITalePetList.prefab"
  },
  UITalePetMissionController = {
    uiPrefab = "UITalePetMissionController.prefab"
  },
  UIConveneDesc = {
    uiPrefab = "UIConveneDesc.prefab"
  },
  UISwitchPetPro = {
    uiPrefab = "UISwitchPetPro.prefab"
  },
  UIMissionSubmitItem = {
    uiPrefab = "UIMissionSubmitItem.prefab"
  },
  UITrailLevelBuffIntroduce = {
    uiPrefab = "UITrailLevelBuffIntroduce.prefab"
  },
  UIEducationMain = {
    uiPrefab = "UIEducationMain.prefab"
  },
  UIEducationUp = {
    uiPrefab = "UIEducationUp.prefab",
    maskType = MaskType.MT_None
  },
  UIEducationUpPreview = {
    uiPrefab = "UIEducationUpPreview.prefab",
    maskType = MaskType.MT_None
  },
  UIEducationOne = {
    uiPrefab = "UIEducationOne.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityTotalLoginAwardController = {
    uiPrefab = "UIActivityTotalLoginAwardController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISetParamOnShowComponent = {
        [UIComponentParamType.KeepVoice] = true
      }
    }
  },
  UIAircraftRoomUnLockTipsController = {
    uiPrefab = "UIAircraftRoomUnLockTipsController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIGetPhyPointController = {
    uiPrefab = "UIGetPhyPointController.prefab",
    maskType = MaskType.MT_None
  },
  UIGetPhyPointTipsController = {
    uiPrefab = "UIGetPhyPointTipsController.prefab",
    maskType = MaskType.MT_None
  },
  UIActivityIntroController = {
    uiPrefab = "UIActivityIntroController.prefab",
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIIntroLoader = {
    uiPrefab = "UIIntroLoader.prefab"
  },
  UISerialAutoFightInfo = {
    uiPrefab = "UISerialAutoFightInfo.prefab",
    maskType = MaskType.MT_MoreBlackMask
  },
  UISerialAutoFightOption = {
    uiPrefab = "UISerialAutoFightOption.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISerialAutoFightSweepResult = {
    uiPrefab = "UISerialAutoFightSweepResult.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISerialAutoFightOptionNew = {
    uiPrefab = "UISerialAutoFightOptionNew.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISerialAutoFightSweepResultNew = {
    uiPrefab = "UISerialAutoFightSweepResultNew.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISetAutoFightIntroduce = {
    uiPrefab = "UISetAutoFightIntroduce.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UITempSignInController = {
    uiPrefab = "UITempSignInController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISetParamOnShowComponent = {
        [UIComponentParamType.KeepVoice] = true
      }
    }
  },
  UISakuraEntryController = {
    uiPrefab = "UISakuraEntryController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {},
      UISwitchBGMComponent = CriAudioIDConst.BGMSakura
    }
  },
  UISakuraController = {
    uiPrefab = "UISakuraController.prefab",
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UISakuraDrawShopController = {
    uiPrefab = "UISakuraDrawShopController.prefab"
  },
  UISakuraDrawShopTipsController = {
    uiPrefab = "UISakuraDrawShopTipsController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISakuraTaskController = {
    uiPrefab = "UISakuraTaskController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISakuraTaskControllerWrapper = {
    uiPrefab = "UISakuraTaskController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISummer1 = {
    uiPrefab = "UISummer1.prefab",
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMSummer1
    }
  },
  UISummer1Intro = {
    uiPrefab = "UISummer1Intro.prefab",
    maskType = MaskType.MT_LessBlackMask
  },
  UIBattleTaleBuffDesc = {
    uiPrefab = "UIBattleTaleBuffDesc.prefab",
    maskType = MaskType.MT_None
  },
  UIBossCounter = {
    uiPrefab = "UIBossCounter.prefab",
    maskType = MaskType.MT_None
  },
  UIBattleAutoTest = {
    uiPrefab = "UIBattleAutoTest.prefab",
    maskType = MaskType.MT_None
  },
  UISummerActivityTwoMainController = {
    uiPrefab = "UISummerActivityTwoMainController.prefab",
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMSummer1Hard
    }
  },
  UISummerActivityTwoScoreController = {
    uiPrefab = "UISummerActivityTwoScoreController.prefab",
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UISummerActivityTwoLevelController = {
    uiPrefab = "UISummerActivityTwoLevelController.prefab",
    uiComponents = {
      UITransitionComponent = {},
      UISwitchBGMComponent = CriAudioIDConst.BGMSummer1Hard
    }
  },
  UISummerActivityTwoLevelDetail = {
    uiPrefab = "UISummerActivityTwoLevelDetail.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISummerActivityTwoNormalLevelDetail = {
    uiPrefab = "UISummerActivityTwoNormalLevelDetail.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISummerActivityTwoSelectEntryController = {
    uiPrefab = "UISummerActivityTwoSelectEntryController.prefab"
  },
  UISummerActivityTwoEntryController = {
    uiPrefab = "UISummerActivityTwoEntryController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIPetSkinsMainController = {
    uiPrefab = "UIPetSkinsMainController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIXH1SimpleLevel = {
    uiPrefab = "UIXH1SimpleLevel.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMSummer1
    }
  },
  UIXH1HardLevel = {
    uiPrefab = "UIXH1HardLevel.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {},
      UISwitchBGMComponent = CriAudioIDConst.BGMSummer1Hard
    }
  },
  UIXH1Stage = {
    uiPrefab = "UIXH1Stage.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIXH1PointDetail = {
    uiPrefab = "UIXH1PointDetail.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIMiniGameStageController = {
    uiPrefab = "UIMiniGameStageController.prefab",
    maskType = MaskType.MT_None
  },
  UIMiniGameController = {
    uiPrefab = "UIMiniGameController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMMiniGame
    }
  },
  UIPetSkinsGetCgController = {
    uiPrefab = "UIPetSkinsGetCgController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIPetSkinUnLockFileController = {
    uiPrefab = "UIPetSkinUnLockFileController.prefab",
    maskType = MaskType.MT_None
  },
  UISummerActivityTwoPlotDetailController = {
    uiPrefab = "UISummerActivityTwoPlotDetailController.prefab",
    maskType = MaskType.MT_None
  },
  UIXH1Shop = {
    uiPrefab = "UIXH1Shop.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityBattlePassMainController = {
    uiPrefab = "UIActivityBattlePassMainController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityBattlePassPreviewController = {
    uiPrefab = "UIActivityBattlePassPreviewController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIActivityBattlePassBuyController = {
    uiPrefab = "UIActivityBattlePassBuyController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIActivityBattlePassBuyLevelController = {
    uiPrefab = "UIActivityBattlePassBuyLevelController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIActivityBattlePassAwardController = {
    uiPrefab = "UIActivityBattlePassAwardController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIActivityBattlePassN5MainController = {
    uiPrefab = "UIActivityBattlePassN5MainController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityBattlePassN5PreviewController = {
    uiPrefab = "UIActivityBattlePassN5PreviewController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityBattlePassN5BuyController = {
    uiPrefab = "UIActivityBattlePassN5BuyController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityBattlePassN5BuyLevelController = {
    uiPrefab = "UIActivityBattlePassN5BuyLevelController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityBattlePassN5AwardController = {
    uiPrefab = "UIActivityBattlePassN5AwardController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIBattlePassCN1MainController = {
    uiPrefab = "UIBattlePassCN1MainController.prefab"
  },
  UIBattlePassCN1PreviewController = {
    uiPrefab = "UIBattlePassCN1PreviewController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIBattlePassCN1BuyLevelController = {
    uiPrefab = "UIBattlePassCN1BuyLevelController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIBattlePassCN1BuyGiftController = {
    uiPrefab = "UIBattlePassCN1BuyGiftController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIBattlePassCN1BuyGiftResultController = {
    uiPrefab = "UIBattlePassCN1BuyGiftResultController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIActivityOneAndHalfAnniversaryController = {
    uiPrefab = "UIActivityOneAndHalfAnniversaryController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityOneAndHalfAnniversaryVideoController = {
    uiPrefab = "UIActivityOneAndHalfAnniversaryVideoController.prefab",
    maskType = MaskType.MT_None
  },
  UIActivityReturnSystemMainController = {
    uiPrefab = "UIActivityReturnSystemMainController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityReturnSystemTipController = {
    uiPrefab = "UIActivityReturnSystemTipController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UICutsceneReviewController = {
    uiPrefab = "UICutsceneReview.prefab",
    maskType = MaskType.MT_None
  },
  UIActivityPetTryController = {
    uiPrefab = "UIActivityPetTryController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityReturnSystemIntro = {
    uiPrefab = "UIActivityReturnSystemIntro.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityReturnSystemGetItem = {
    uiPrefab = "UIActivityReturnSystemGetItem.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UICoreGamePerformanceController = {
    uiPrefab = "UICoreGamePerformance.prefab",
    maskType = MaskType.MT_None
  },
  UICoreGameSkillPerfController = {
    uiPrefab = "UICoreGameSkillPerf.prefab",
    maskType = MaskType.MT_None
  },
  UIPetSkinObtainController = {
    uiPrefab = "UIPetSkinObtainController.prefab",
    maskType = MaskType.MT_None
  },
  UIActivityGraveRobberMainController = {
    uiPrefab = "UIActivityGraveRobberMainController.prefab",
    maskType = MaskType.MT_None
  },
  UICutsceneReviewController = {
    uiPrefab = "UICutsceneReview.prefab",
    maskType = MaskType.MT_None
  },
  UIActivityPetTryController = {
    uiPrefab = "UIActivityPetTryController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityReturnSystemIntro = {
    uiPrefab = "UIActivityReturnSystemIntro.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityReturnSystemGetItem = {
    uiPrefab = "UIActivityReturnSystemGetItem.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIPetSkinObtainController = {
    uiPrefab = "UIPetSkinObtainController.prefab",
    maskType = MaskType.MT_None
  },
  UIActivityGraveRobberMainController = {
    uiPrefab = "UIActivityGraveRobberMainController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityNPlusSixBuildingMainController = {
    uiPrefab = "UIActivityNPlusSixBuildingMainController.prefab"
  },
  UIActivityNPlusSixRewardController = {
    uiPrefab = "UIActivityNPlusSixRewardController.prefab"
  },
  UIActivityNPlusSixBuildingTipsController = {
    uiPrefab = "UIActivityNPlusSixBuildingTipsController.prefab",
    maskType = MaskType.MT_None
  },
  UIActivityNPlusSixMainController = {
    uiPrefab = "UIActivityNPlusSixMainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN6
    }
  },
  UIActivityNPlusSixEventCompleteController = {
    uiPrefab = "UIActivityNPlusSixEventCompleteController.prefab"
  },
  UINP6Level = {
    uiPrefab = "UINP6Level.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN6
    }
  },
  UIN5MainController = {
    uiPrefab = "UIN5MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN5
    }
  },
  UIActivityN5SimpleLevel = {
    uiPrefab = "UIActivityN5SimpleLevel.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN5
    }
  },
  UIActivityN5Stage = {
    uiPrefab = "UIActivityN5Stage.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityN5PointDetail = {
    uiPrefab = "UIActivityN5PointDetail.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIN5StoryController = {
    uiPrefab = "UIN5StoryController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN5BattleFieldController = {
    uiPrefab = "UIN5BattleFieldController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN5
    }
  },
  UIN5BattleFieldStageInfo = {
    uiPrefab = "UIN5BattleFieldStageInfo.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIN5BattleFieldEnemyInfo = {
    uiPrefab = "UIN5BattleFieldEnemyInfo.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIN5BattleFieldBattleComplete = {
    uiPrefab = "UIN5BattleFieldBattleComplete.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN5ProgressController = {
    uiPrefab = "UIN5ProgressController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIN5Intro = {
    uiPrefab = "UIN5Intro.prefab",
    maskType = MaskType.MT_LessBlackMask
  },
  UILostLandMainController = {
    uiPrefab = "UILostLandMainController.prefab",
    maskType = MaskType.MT_None
  },
  UILostLandMissionInfoController = {
    uiPrefab = "UILostLandMissionInfoController.prefab",
    maskType = MaskType.MT_None
  },
  UILostLandAwardViewController = {
    uiPrefab = "UILostLandAwardViewController.prefab",
    maskType = MaskType.MT_None
  },
  UILostLandStageController = {
    uiPrefab = "UILostLandStageController.prefab",
    maskType = MaskType.MT_None
  },
  UILostLandWeekInfoController = {
    uiPrefab = "UILostLandWeekInfoController.prefab",
    maskType = MaskType.MT_None
  },
  UIAwakeDirectly = {
    uiPrefab = "UIAwakeDirectly.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityLevelStage = {
    uiPrefab = "UIActivityLevelStage.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityLevelStageNew = {
    uiPrefab = "UIActivityStageNew.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityHardStage = {
    uiPrefab = "UIActivityHardStage.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIWeekTowerController = {
    uiPrefab = "UIWeekTowerController.prefab",
    maskType = MaskType.MT_None
  },
  UIWeekTowerAwardsController = {
    uiPrefab = "UIWeekTowerAwardsController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIActivityN7MainController = {
    uiPrefab = "UIActivityN7MainController.prefab",
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN7
    }
  },
  UIN7Level = {
    uiPrefab = "UIN7Level.prefab",
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN7
    }
  },
  UIBlackFightMain = {
    uiPrefab = "UIBlackFightMain.prefab",
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN7
    }
  },
  UIBlackFightReputation = {
    uiPrefab = "UIBlackFightReputation.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIBlackFightPaper = {
    uiPrefab = "UIBlackFightPaper.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN7LevelDetailsController = {
    uiPrefab = "UIN7LevelDetailsController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN7
    }
  },
  UIN7EnemyDetailsController = {
    uiPrefab = "UIN7EnemyDetailsController.prefab"
  },
  UIActivityN7Intro = {
    uiPrefab = "UIActivityN7Intro.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityN8MainController = {
    uiPrefab = "UIActivityN8MainController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN8
    }
  },
  UIActivityN8LineMissionController = {
    uiPrefab = "UIActivityN8LineMissionController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN8
    }
  },
  UIActivityN8BattleSimulatorController = {
    uiPrefab = "UIActivityN8BattleSimulatorController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN8
    }
  },
  UIActivityN8PersonProgressController = {
    uiPrefab = "UIActivityN8PersonProgressController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityLevelStage = {
    uiPrefab = "UIActivityLevelStage.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIAwakeDirectly = {
    uiPrefab = "UIAwakeDirectly.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIEvePointDetail = {
    uiPrefab = "UIEvePointDetail.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityEveSinsaIntrController = {
    uiPrefab = "UIActivityEveSinsaIntrController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIWorldBossController = {
    uiPrefab = "UIWorldBossController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMDiscovery
    }
  },
  UIWorldBossDanDetailController = {
    uiPrefab = "UIWorldBossDanDetailController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIWorldBossDanLastRecordController = {
    uiPrefab = "UIWorldBossDanLastRecordController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIWorldBossRecordChoice = {
    uiPrefab = "UIWorldBossRecordChoice.prefab",
    maskType = MaskType.MT_None
  },
  UIWorldBossDanResult = {
    uiPrefab = "UIWorldBossDanResult.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIWorldBossDanDetailTipsController = {
    uiPrefab = "UIWorldBossDanDetailTipsController.prefab",
    maskType = MaskType.MT_None
  },
  UIGlobalBossController = {
    uiPrefab = "UIGlobalBossController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMDiscovery
    }
  },
  UIBlobalBossRecordChoice = {
    uiPrefab = "UIBlobalBossRecordChoice.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIGlobalBossResultController = {
    uiPrefab = "UIGlobalBossResultController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIWorldBossDiffSelectController = {
    uiPrefab = "UIWorldBossDiffSelectController.prefab",
    maskType = MaskType.MT_None
  },
  UISailing = {
    uiPrefab = "UISailing.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN5
    }
  },
  UISailingChapter = {
    uiPrefab = "UISailingChapter.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN5
    }
  },
  UIAircraftTactic = {
    uiPrefab = "UIAircraftTactic.prefab",
    maskType = MaskType.MT_None
  },
  UITacticTapeInfo = {
    uiPrefab = "UITacticTapeInfo.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIDataBaseMapController = {
    uiPrefab = "UIDataBaseMapController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIDataBaseController = {
    uiPrefab = "UIDataBaseController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UITopRankController = {
    uiPrefab = "UITopRankController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UITacticTapeProduceFree = {
    uiPrefab = "UITacticTapeProduceFree.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UITacticTapeProduceSpeedup = {
    uiPrefab = "UITacticTapeProduceSpeedup.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UITacticTapeObtain = {
    uiPrefab = "UITacticTapeObtain.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIMazeQuickFightController = {
    uiPrefab = "UIMazeQuickFightController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIAircraftTacticSwitch = {
    uiPrefab = "UIAircraftTacticSwitch.prefab",
    maskType = MaskType.MT_None
  },
  UIActivityN9MainController = {
    uiPrefab = "UIActivityN9MainController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN9
    }
  },
  UIActivityN9LineMissionController = {
    uiPrefab = "UIActivityN9LineMissionController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN9
    }
  },
  UIActivityN9ActionPointDetail = {
    uiPrefab = "UIActivityN9ActionPointDetail.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIN9SubjectMainController = {
    uiPrefab = "UIN9SubjectMainController.prefab",
    maskType = MaskType.MT_None
  },
  UIN9Intro = {
    uiPrefab = "UIN9Intro.prefab",
    maskType = MaskType.MT_LessBlackMask
  },
  UIN9HardLevel = {
    uiPrefab = "UIN9HardLevel.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {},
      UISwitchBGMComponent = CriAudioIDConst.BGMN9
    }
  },
  UIActivityShopControllerN9 = {
    uiPrefab = "UIN9ShopController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN9
    }
  },
  UIN9SubjectTestDetailController = {
    uiPrefab = "UIN9SubjectTestDetailController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIN9SubjectNormalDetailController = {
    uiPrefab = "UIN9SubjectNormalDetailController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIN9SubjecIntroduce = {
    uiPrefab = "UIN9SubjecIntroduce.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIChooseMainCgController = {
    uiPrefab = "UIChooseMainCgController.prefab",
    maskType = MaskType.MT_None
  },
  UIN9AnswerController = {
    uiPrefab = "UIN9AnswerController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMMiniGame
    }
  },
  UIN9ResultController = {
    uiPrefab = "UIN9ResultController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN9AnswerOnPauseController = {
    uiPrefab = "UIN9AnswerOnPauseController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN9AnswerControllerTest = {
    uiPrefab = "UIN9AnswerControllerTest.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN10MainController = {
    uiPrefab = "UIN10MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMMiniGame
    }
  },
  UIN10ShopController = {
    uiPrefab = "UIN10ShopController.prefab"
  },
  UIN10ShopTipsController = {
    uiPrefab = "UIN10ShopTipsController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN10IntroController = {
    uiPrefab = "UIN10IntroController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIN10TotalLoginAwardController = {
    uiPrefab = "UIN10TotalLoginAwardController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISetParamOnShowComponent = {
        [UIComponentParamType.KeepVoice] = true
      }
    }
  },
  UIAircraftTacticSwitch = {
    uiPrefab = "UIAircraftTacticSwitch.prefab",
    maskType = MaskType.MT_None
  },
  UIOpenGiftGetMatController = {
    uiPrefab = "UIOpenGiftGetMatController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityPetTryPlusController = {
    uiPrefab = "UIActivityPetTryPlusController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN11Main = {
    uiPrefab = "UIN11Main.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN11
    }
  },
  UIN11Shop = {
    uiPrefab = "UIN11Shop.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN11
    }
  },
  UIN11Intro = {
    uiPrefab = "UIN11Intro.prefab",
    maskType = MaskType.MT_None
  },
  UIN12MainController = {
    uiPrefab = "UIN12MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN12
    }
  },
  UIN12NormalLevel = {
    uiPrefab = "UIN12NormalLevel.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN12
    }
  },
  UIN12HardlLevel = {
    uiPrefab = "UIN12HardlLevel.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN12
    }
  },
  UIN12IntroController = {
    uiPrefab = "UIN12IntroController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIActivityN11LineMissionController = {
    uiPrefab = "UIActivityN11LineMissionController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN11
    }
  },
  UIActivtiyN11HardLevelController = {
    uiPrefab = "UIActivtiyN11HardLevelController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN11
    }
  },
  UIActivityN11ActionPointDetail = {
    uiPrefab = "UIActivityN11ActionPointDetail.prefab",
    maskType = MaskType.MT_None
  },
  UIN12HardlLevelInfo = {
    uiPrefab = "UIN12HardlLevelInfo.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN12
    }
  },
  UIN12EntrustStageController = {
    uiPrefab = "UIN12EntrustStageController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN12
    }
  },
  UIN12EntrustStageDetailController = {
    uiPrefab = "UIN12EntrustStageDetailController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN12EntrustStageIntroController = {
    uiPrefab = "UIN12EntrustStageIntroController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN12EntrustLevelController = {
    uiPrefab = "UIN12EntrustLevelController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN12
    }
  },
  UIN12MapBannerController = {
    uiPrefab = "UIN12MapBannerController.prefab",
    maskType = MaskType.MT_None
  },
  UIN12MapBoxController = {
    uiPrefab = "UIN12MapBoxController.prefab",
    maskType = MaskType.MT_None
  },
  UIN12MapExitsController = {
    uiPrefab = "UIN12MapExitsController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN12MapGetRewardsController = {
    uiPrefab = "UIN12MapGetRewardsController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN12MapCommonPopController = {
    uiPrefab = "UIN12MapCommonPopController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN12MapQuestController = {
    uiPrefab = "UIN12MapController_Quest.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN12MapStageController = {
    uiPrefab = "UIN12MapController_Stage.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN12MapStoryController = {
    uiPrefab = "UIN12MapController_Story.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN12ChallengesContorl = {
    uiPrefab = "UIN12ChallengesContorl.prefab",
    maskType = MaskType.MT_None
  },
  UIN12SynopsisController = {
    uiPrefab = "UIN12SynopsisController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN12IntegralController = {
    uiPrefab = "UIN12IntegralController.prefab",
    maskType = MaskType.MT_None
  },
  UIN12ChallengeTaskReward = {
    uiPrefab = "UIN12ChallengeTaskReward.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityDoubleDropIntroduce = {
    uiPrefab = "UIActivityDoubleDropIntroduce.prefab"
  },
  UIN12BattleAffix = {
    uiPrefab = "UIN12BattleAffix.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIQuestDailyExtraInfoController = {
    uiPrefab = "UIQuestDailyExtraInfoController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIN13BuildController = {
    uiPrefab = "UIN13BuildController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN13Build
    }
  },
  UIN13BuildConfirmController = {
    uiPrefab = "UIN13BuildConfirmController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIN13BuildPlotController = {
    uiPrefab = "UIN13BuildPlotController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN13BuildRewardController = {
    uiPrefab = "UIN13BuildRewardController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIN13MainController = {
    uiPrefab = "UIN13MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN13
    }
  },
  UIN13LineMissionController = {
    uiPrefab = "UIN13LineMissionController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN13
    }
  },
  UIN13IntroController = {
    uiPrefab = "UIN13IntroController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN14Main = {
    uiPrefab = "UIN14Main.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN13Build
    }
  },
  UIActivityN14LineMissionController = {
    uiPrefab = "UIActivityN14LineMissionController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN13Build
    }
  },
  UIActivityN14HardMissionController = {
    uiPrefab = "UIActivityN14HardMissionController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN13Build
    }
  },
  UIActivityN14Intro = {
    uiPrefab = "UIActivityN14Intro.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN14Shop = {
    uiPrefab = "UIN14Shop.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN13Build
    }
  },
  UIQuestDailyExtraInfoController = {
    uiPrefab = "UIQuestDailyExtraInfoController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIN14FishingGameStageController = {
    uiPrefab = "UIN14FishingGameStageController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN13Build
    }
  },
  UIN14Intro = {
    uiPrefab = "UIN14Intro.prefab",
    maskType = MaskType.MT_LessBlackMask
  },
  UIN14FishingGameController = {
    uiPrefab = "UIN14FishingGameController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMMiniGame
    }
  },
  UIActivityN14ActionPointDetail = {
    uiPrefab = "UIActivityN14ActionPointDetail.prefab",
    maskType = MaskType.MT_None
  },
  UIN15MainController = {
    uiPrefab = "UIN15MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN15
    }
  },
  UIN15LineMissionController = {
    uiPrefab = "UIN15LineMissionController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN15
    }
  },
  UIN15IntroController = {
    uiPrefab = "UIN15IntroController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN15RaffleController = {
    uiPrefab = "UIN15RaffleController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN15
    }
  },
  UIN15PoltController = {
    uiPrefab = "UIN15PoltController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN15RafflePopController = {
    uiPrefab = "UIN15RafflePopController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN15DrawIntroController = {
    uiPrefab = "UIN15DrawIntroController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN15ChessController = {
    uiPrefab = "UIN15ChessController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN15
    }
  },
  UIChessIntro = {
    uiPrefab = "UIChessIntro.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityN16MainController = {
    uiPrefab = "UIActivityN16MainController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN16
    }
  },
  UIActivityN16LineMissionController = {
    uiPrefab = "UIActivityN16LineMissionController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN16
    }
  },
  UIActivityN16ActionPointDetail = {
    uiPrefab = "UIActivityN16ActionPointDetail.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIN16SubjectMainController = {
    uiPrefab = "UIN16SubjectMainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN16
    }
  },
  UIN16Intro = {
    uiPrefab = "UIN16Intro.prefab",
    maskType = MaskType.MT_LessBlackMask
  },
  UIN16HardLevel = {
    uiPrefab = "UIN16HardLevel.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN16
    }
  },
  UIActivityShopControllerN16 = {
    uiPrefab = "UIN16ShopController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN16
    }
  },
  UIN16SubjectTestDetailController = {
    uiPrefab = "UIN16SubjectTestDetailController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIN16SubjectNormalDetailController = {
    uiPrefab = "UIN16SubjectNormalDetailController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIN16SubjecIntroduce = {
    uiPrefab = "UIN16SubjecIntroduce.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN16AnswerController = {
    uiPrefab = "UIN16AnswerController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMMiniGame
    }
  },
  UIN16ResultController = {
    uiPrefab = "UIN16ResultController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN16AnswerOnPauseController = {
    uiPrefab = "UIN16AnswerOnPauseController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN16AnswerControllerTest = {
    uiPrefab = "UIN16AnswerControllerTest.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN16Intro = {
    uiPrefab = "UIN16Intro.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityN16MainLobbyEntry = {
    uiPrefab = "UIActivityN16MainLobbyEntry.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN17MainController = {
    uiPrefab = "UIN17MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN17
    }
  },
  UIN17MainTipsController = {
    uiPrefab = "UIN17MainTipsController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN17
    }
  },
  UIN17DailyPlanController = {
    uiPrefab = "UIN17DailyPlanController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN17
    }
  },
  UIN17LotteryController = {
    uiPrefab = "UIN17LotteryController.prefab"
  },
  UIN17LotteryTipsController = {
    uiPrefab = "UIN17LotteryTipsController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN17
    }
  },
  UIN17IntroController = {
    uiPrefab = "UIN17IntroController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN17
    }
  },
  UIN17Intro2Controller = {
    uiPrefab = "UIN17Intro2Controller.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN17
    }
  },
  UIN17GetItemController = {
    uiPrefab = "UIN17GetItemController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {},
      UISwitchBGMComponent = CriAudioIDConst.BGMN17,
      UISetParamOnShowComponent = {
        [UIComponentParamType.KeepVoice] = true
      }
    }
  },
  UIN17MessageBoxController = {
    uiPrefab = "UIN17MessageBoxController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityAnniversaryLoginController = {
    uiPrefab = "AnniversaryLoginController.prefab",
    maskType = MaskType.MT_None
  },
  UISetAutoFightEnhanceWarning = {
    uiPrefab = "UISetAutoFightEnhanceWarning.prefab",
    maskType = MaskType.MT_None
  },
  UIHauteCoutureDrawController = {
    uiPrefab = "UIHauteCoutureDrawController.prefab",
    maskType = MaskType.MT_None
  },
  UIHauteCoutureDrawControllerKLReview2 = {
    uiPrefab = "UIHauteCoutureDrawController_KL_Review2.prefab",
    maskType = MaskType.MT_None
  },
  UIHauteCoutureDrawV2Controller = {
    uiPrefab = "UIHauteCoutureControllerTemplate.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMEveSinsaShop
    }
  },
  UIHauteCoutureDrawV2ReviewController = {
    uiPrefab = "UIHauteCoutureControllerTemplate.prefab",
    maskType = MaskType.MT_None
  },
  UIHauteCoutureDuplicateReward = {
    uiPrefab = "UIHauteCoutureDuplicateReward.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHauteCoutureDrawRulesV2Controller = {
    uiPrefab = "UIHauteCoutureControllerTemplate.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHauteCoutureDrawDynamicProbablityV2Controller = {
    uiPrefab = "UIHauteCoutureControllerTemplate.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHauteCoutureDrawGetItemV2Controller = {
    uiPrefab = "UIHauteCoutureControllerTemplate.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHauteCoutureDrawChargeV2Controller = {
    uiPrefab = "UIHauteCoutureControllerTemplate.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHauteCoutureDrawVideoV2Controller = {
    uiPrefab = "UIHauteCoutureControllerTemplate.prefab",
    maskType = MaskType.MT_None
  },
  UIActivitySummonGiftController = {
    uiPrefab = "UIActivitySummonGiftController.prefab",
    maskType = MaskType.MT_MoreBlackMask
  },
  UISimpleHauteCoutureDrawResController = {
    uiPrefab = "UISimpleHauteCoutureDrawResController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISimpleHauteCoutureVideoController = {
    uiPrefab = "UISimpleHauteCoutureVideoController.prefab",
    maskType = MaskType.MT_None
  },
  UISimpleHauteCoutureConfirm = {
    uiPrefab = "UISimpleHauteCoutureConfirm.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISimpleHauteCoutureGiftPackDetail = {
    uiPrefab = "UISimpleHauteCoutureGiftPackDetail.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISimpleHauteCoutureProbability = {
    uiPrefab = "UISimpleHauteCoutureProbability.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UISimpleHauteCoutureShop = {
    uiPrefab = "UISimpleHauteCoutureShop.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISimpleHauteCoutureMainController = {
    uiPrefab = "UISimpleHauteCoutureMainController.prefab",
    maskType = MaskType.MT_None
  },
  UISimpleHauteCouturePurchaseController = {
    uiPrefab = "UISimpleHauteCouturePurchaseController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UIN18MainController = {
    uiPrefab = "UIN18MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN18
    }
  },
  UIN18LineMissionController = {
    uiPrefab = "UIN18LineMissionController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN18
    }
  },
  UIN18HardMissionController = {
    uiPrefab = "UIN18HardMissionController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN18
    }
  },
  UIN18Intro = {
    uiPrefab = "UIN18Intro.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN18Intro2 = {
    uiPrefab = "UIN18Intro2.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN18Shop = {
    uiPrefab = "UIN18ShopController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN20AVGMain = {
    uiPrefab = "UIN20AVGMain.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN20
    }
  },
  UIN20AVGIntro = {
    uiPrefab = "UIN20AVGIntro.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN20AVGStory = {
    uiPrefab = "UIN20AVGStory.prefab",
    maskType = MaskType.MT_None
  },
  UIN20AVGEnding = {
    uiPrefab = "UIN20AVGEnding.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN20AVGGraph = {
    uiPrefab = "UIN20AVGGraph.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN20AVGNodeDetails = {
    uiPrefab = "UIN20AVGNodeDetails.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN20AVGCollection = {
    uiPrefab = "UIN20AVGCollection.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN20AVGReview = {
    uiPrefab = "UIN20AVGReview.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN22MedalEdit = {
    uiPrefab = "UIN22MedalEdit.prefab",
    maskType = MaskType.MT_None
  },
  UIN22MedalEditRotate = {
    uiPrefab = "UIN22MedalEditRotate.prefab",
    maskType = MaskType.MT_None
  },
  UIN22MedalFilter = {
    uiPrefab = "UIN22MedalFilter.prefab",
    maskType = MaskType.MT_None
  },
  UIN22MedalChangeBoard = {
    uiPrefab = "UIN22MedalChangeBoard.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN23Main = {
    uiPrefab = "UIN23Main.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN23
    }
  },
  UIN23Line = {
    uiPrefab = "UIN23Line.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN23
    }
  },
  UIN23Shop = {
    uiPrefab = "UIN23Shop.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN23
    }
  },
  UIN23Replay = {
    uiPrefab = "UIN23Replay.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UIN23Movie = {
    uiPrefab = "UIN23Movie.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN24Shop = {
    uiPrefab = "UIN24Shop.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN24
    }
  },
  UIN24ShopIntro = {
    uiPrefab = "UIN24ShopIntro.prefab",
    maskType = MaskType.MT_None
  },
  UIActivtiyN25HardLevelController = {
    uiPrefab = "UIN25HardLevelController.prefab",
    maskType = MaskType.MT_None
  },
  UIN25Line = {
    uiPrefab = "UIN25Line.prefab",
    maskType = MaskType.MT_None
  },
  UIN25Shop = {
    uiPrefab = "UIN25Shop.prefab",
    maskType = MaskType.MT_None
  },
  UIActivityN25MainController = {
    uiPrefab = "UIActivityN25MainController.prefab",
    maskType = MaskType.MT_None
  },
  UIN25VampireMain = {
    uiPrefab = "UIN25VampireMain.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN25Vampire
    }
  },
  UIN25VampireTalentTree = {
    uiPrefab = "UIN25VampireTalentTree.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN25Vampire
    }
  },
  UIN25VampireRoleSkill = {
    uiPrefab = "UIN25VampireRoleSkill.prefab",
    maskType = MaskType.MT_None
  },
  UIN25VampireTalentIntro = {
    uiPrefab = "UIN25VampireTalentIntro.prefab",
    maskType = MaskType.MT_None
  },
  UIN25VampireTips = {
    uiPrefab = "UIN25VampireTips.prefab",
    maskType = MaskType.MT_None
  },
  UIN25VampireTalentSkillTips = {
    uiPrefab = "UIN25VampireTalentSkillTips.prefab",
    maskType = MaskType.MT_None
  },
  UIN25VampireTalentItemTips = {
    uiPrefab = "UIN25VampireTalentItemTips.prefab",
    maskType = MaskType.MT_None
  },
  UIHauteCoutureDrawDynamicProbablityController = {
    uiPrefab = "UIHauteCoutureDrawDynamicProbablityController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHauteCoutureDrawRulesController = {
    uiPrefab = "UIHauteCoutureDrawRulesController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHauteCoutureDrawChargeController = {
    uiPrefab = "UIHauteCoutureDrawChargeController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISetAutoFightEnhanceWarning = {
    uiPrefab = "UISetAutoFightEnhanceWarning.prefab",
    maskType = MaskType.MT_None
  },
  UIHauteVideoController = {
    uiPrefab = "UIHauteVideoController.prefab",
    maskType = MaskType.MT_None
  },
  UIHauteCoutureGetItemController = {
    uiPrefab = "UIHauteCoutureGetItemController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIHauteCoutureDrawDuplicateRewardKL = {
    uiPrefab = "UIHauteCoutureDrawDuplicateReward.prefab",
    maskType = MaskType.MT_None
  },
  UIActivityPowerCostController = {
    uiPrefab = "UIActivityPowerCostController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISignInActBoxTipsController = {
    uiPrefab = "UISignInActBoxTipsController.prefab",
    maskType = MaskType.MT_None
  },
  UIHomePetInteract = {
    uiPrefab = "UIHomePetInteract.prefab",
    maskType = MaskType.MT_None
  },
  UIHomePetFollowList = {
    uiPrefab = "UIHomePetFollowList.prefab",
    maskType = MaskType.MT_None
  },
  UIHomePhotoController = {
    uiPrefab = "UIHomePhotoController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIHomePhotoInfoController = {
    uiPrefab = "UIHomePhotoInfoController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIHomeDomitory = {
    uiPrefab = "UIHomeDomitory.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomeStoryController = {
    uiPrefab = "UIHomeStoryController.prefab",
    maskType = MaskType.MT_None
  },
  UIHomelandBreed = {
    uiPrefab = "UIHomelandBreed.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomelandBreedItemSelect = {
    uiPrefab = "UIHomelandBreedItemSelect.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomelandBreedPreview = {
    uiPrefab = "UIHomelandBreedPreview.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomelandBreedResult = {
    uiPrefab = "UIHomelandBreedResult.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomelandBreedManualInfo = {
    uiPrefab = "UIHomelandBreedManualInfo.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomelandBreedDirective = {
    uiPrefab = "UIHomelandBreedDirective.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomelandTreeDye = {
    uiPrefab = "UIHomelandTreeDye.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomeDomitoryChangeName = {
    uiPrefab = "UIHomeDomitoryChangeName.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomeDomitorySettle = {
    uiPrefab = "UIHomeDomitorySettle.prefab",
    maskType = MaskType.MT_None
  },
  UIHomeDomitoryAffinityRule = {
    uiPrefab = "UIHomeDomitoryAffinityRule.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomePetStoryReview = {
    uiPrefab = "UIHomePetStoryReview.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIStoryViewer3D = {
    uiPrefab = "UIStoryViewer3D.prefab",
    maskType = MaskType.MT_None
  },
  UIFindTreasureInteractMain = {
    uiPrefab = "UIFindTreasureInteractMain.prefab",
    maskType = MaskType.MT_None
  },
  UIActivityBetweenTheChaptersController = {
    uiPrefab = "UIActivityBetweenTheChaptersController.prefab",
    maskType = MaskType.MT_None
  },
  UIFindTreasureDetail = {
    uiPrefab = "UIFindTreasureDetail.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIFindTreasureStartGame = {
    uiPrefab = "UIFindTreasureStartGame.prefab",
    maskType = MaskType.MT_None
  },
  UIFindTreasureMain = {
    uiPrefab = "UIFindTreasureMain.prefab",
    maskType = MaskType.MT_None
  },
  UIFindTreasureFailure = {
    uiPrefab = "UIFindTreasureFailure.prefab",
    maskType = MaskType.MT_None
  },
  UIFindTreasureSuccess = {
    uiPrefab = "UIFindTreasureSuccess.prefab",
    maskType = MaskType.MT_None
  },
  UIHomeHelpController = {
    uiPrefab = "UIHomeHelpController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomeShowAwards = {
    uiPrefab = "UIHomeShowAwards.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIHomeLandDiaryContentsController = {
    uiPrefab = "UIHomeLandDiaryContentsController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIHomeLandDiaryController = {
    uiPrefab = "UIHomeLandDiaryController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIHomeVisitFriends = {
    uiPrefab = "UIHomeVisitFriends.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomeStorehouse = {
    uiPrefab = "UIHomeStorehouse.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIHomeVisitGetGift = {
    uiPrefab = "UIHomeVisitGetGift.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIHomeVisitSpeedup = {
    uiPrefab = "UIHomeVisitSpeedup.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIHomelandTask = {
    uiPrefab = "UIHomelandTask.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomelandTaskFinishEffect = {
    uiPrefab = "UIHomelandTaskFinishEffect.prefab",
    maskType = MaskType.MT_None
  },
  UIItemExChangeController = {
    uiPrefab = "UIItemExChangeController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomeGiftSelector = {
    uiPrefab = "UIHomeGiftSelector.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIHomelandDecompose = {
    uiPrefab = "UIHomelandDecompose.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomelandAccelerate = {
    uiPrefab = "UIHomelandAccelerate.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIForgeOneKeyUnlock = {
    uiPrefab = "UIForgeOneKeyUnlock.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIDiffStage = {
    uiPrefab = "UIDiffStage.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UICN14N43BlackRecordController = {
    uiPrefab = "UICN14N43BlackRecordController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIHomelandFixBuilding = {
    uiPrefab = "UIHomelandFixBuilding.prefab",
    maskType = MaskType.MT_None
  },
  UIHomePetFollow = {
    uiPrefab = "UIHomePetFollowController.prefab",
    maskType = MaskType.MT_None
  },
  UIStageWordTips = {
    uiPrefab = "UIStageWordTips.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIStageElemTips = {
    uiPrefab = "UIStageElemTips.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISailingWordTips = {
    uiPrefab = "UISailingWordTips.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISailingElementTips = {
    uiPrefab = "UISailingElementTips.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISailingBattleResultTips = {
    uiPrefab = "UISailingBattleResultTips.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN19MainController = {
    uiPrefab = "UIN19MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN19
    }
  },
  UIN19LineMissionController = {
    uiPrefab = "UIN19LineMissionController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN19
    }
  },
  UIN19HardLevelController = {
    uiPrefab = "UIN19HardLevelController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN19
    }
  },
  UIN19P5Controller = {
    uiPrefab = "UIN19P5Controller.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN19P5
    }
  },
  UIN19P5Tip = {
    uiPrefab = "UIN19P5Tip.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN19P5SignInController = {
    uiPrefab = "UIN19P5SignInController.prefab",
    maskType = MaskType.MT_None
  },
  UIN19P5AwardController = {
    uiPrefab = "UIN19P5AwardController.prefab",
    maskType = MaskType.MT_None
  },
  UIN19P5IntrController = {
    uiPrefab = "UIN19P5IntrController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIN19P5ShowAwards = {
    uiPrefab = "UIN19P5ShowAwards.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIActivityN20MainController = {
    uiPrefab = "UIActivityN20MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN20
    }
  },
  UIActivityN20Intro = {
    uiPrefab = "UIActivityN20Intro.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityN20NormalLevel = {
    uiPrefab = "UIActivityN20NormalLevel.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN20
    }
  },
  UIActivityN20ActionPointDetail = {
    uiPrefab = "UIActivityN20ActionPointDetail.prefab",
    maskType = MaskType.MT_None
  },
  UIActivityN20HardLevel = {
    uiPrefab = "UIActivityN20HardLevel.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN20
    }
  },
  UIActivityN20Shop = {
    uiPrefab = "UIActivityN20Shop.prefab",
    maskType = MaskType.MT_None
  },
  UIHomeLandDiaryEnterController = {
    uiPrefab = "UIHomeLandDiaryEnterController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomelandStoryTaskController = {
    uiPrefab = "UIHomelandStoryTaskController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UICampainEnterController = {
    uiPrefab = "UICampainEnterController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomelandStoryTaskSimpleController = {
    uiPrefab = "UIHomelandStoryTaskSimpleController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomelandStoryTaskActionPointDetail = {
    uiPrefab = "UIHomelandStoryTaskActionPointDetail.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UICriVideoController = {
    uiPrefab = "UICriVideoController.prefab",
    maskType = MaskType.MT_None
  },
  UIExtraSelect = {
    uiPrefab = "UIExtraSelect.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIReviewUnlockTip = {
    uiPrefab = "UIReviewUnlockTip.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityReview = {
    uiPrefab = "UIActivityReview.prefab",
    maskType = MaskType.MT_None
  },
  UIReviewDownloadTip = {
    uiPrefab = "UIReviewDownloadTip.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityEveSinsaMainController_Review = {
    uiPrefab = "UIActivityEveSinsaMainController_Review.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMEveSinsa
    }
  },
  UIActivityEveSinsaLevelAController_Review = {
    uiPrefab = "UIActivityEveSinsaLevelAController_Review.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMEveSinsa
    }
  },
  UIActivityEveSinsaLevelBController_Review = {
    uiPrefab = "UIActivityEveSinsaLevelBController_Review.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {},
      UISwitchBGMComponent = CriAudioIDConst.BGMEveSinsa
    }
  },
  UIReviewProgressAwardDetail = {
    uiPrefab = "UIReviewProgressAwardDetail.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISakuraController_Review = {
    uiPrefab = "UISakuraController_Review.prefab",
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UISakuraEntryController_Review = {
    uiPrefab = "UISakuraEntryController_Review.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {},
      UISwitchBGMComponent = CriAudioIDConst.BGMSakura
    }
  },
  UISummer1Review = {
    uiPrefab = "UISummer1Review.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {},
      UISwitchBGMComponent = CriAudioIDConst.BGMSummer1
    }
  },
  UIXH1SimpleLevelReview = {
    uiPrefab = "UIXH1SimpleLevelReview.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {},
      UISwitchBGMComponent = CriAudioIDConst.BGMSummer1
    }
  },
  UIXH1HardLevelReview = {
    uiPrefab = "UIXH1HardLevelReview.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {},
      UISwitchBGMComponent = CriAudioIDConst.BGMSummer1Hard
    }
  },
  UISummer1RewardDetailRewivw = {
    uiPrefab = "UISummer1RewardDetailRewivw.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {},
      UISwitchBGMComponent = CriAudioIDConst.BGMSummer1
    }
  },
  UISummer2MainControllerReview = {
    uiPrefab = "UISummer2MainControllerReview.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {},
      UISwitchBGMComponent = CriAudioIDConst.BGMSummer1Hard
    }
  },
  UIN5MainController_Review = {
    uiPrefab = "UIN5MainController_Review.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN5
    }
  },
  UIActivityN5SimpleLevelReview = {
    uiPrefab = "UIActivityN5SimpleLevel_Review.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN5
    }
  },
  UIN5ReviewProgressAwardDetail = {
    uiPrefab = "UIReviewProgressAwardDetail_N5.prefab",
    maskType = MaskType.MT_None
  },
  UIN7MainReview = {
    uiPrefab = "UIN7MainReview.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN7
    }
  },
  UIN7LevelReview = {
    uiPrefab = "UIN7LevelReview.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN7
    }
  },
  UIN7AwardProgressReview = {
    uiPrefab = "UIN7AwardProgressReview.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN7
    }
  },
  UIBlackFightPaperReview = {
    uiPrefab = "UIBlackFightPaperReview.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN7
    }
  },
  UIActivityN8LineMissionController_Review = {
    uiPrefab = "UIActivityN8LineMissionController_Review.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN8
    }
  },
  UIActivityN8MainController_Review = {
    uiPrefab = "UIActivityN8MainController_Review.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN8
    }
  },
  UIActivityN9MainController_Review = {
    uiPrefab = "UIActivityN9MainController_Review.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN9
    }
  },
  UIActivityN9LineMissionController_Review = {
    uiPrefab = "UIActivityN9LineMissionController_Review.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN9
    }
  },
  UIN18MainController_Review = {
    uiPrefab = "UIN18MainController_Review.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN9
    }
  },
  UIN18LineMissionController_Review = {
    uiPrefab = "UIN18LineMissionController_Review.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN9
    }
  },
  UIHomelandAlbum = {
    uiPrefab = "UIHomelandAlbum.prefab"
  },
  UIN20MiniGameStageController = {
    uiPrefab = "UIN20MiniGameStageController.prefab",
    maskType = MaskType.MT_None
  },
  UIN20MiniGameController = {
    uiPrefab = "UIN20MiniGameController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMMiniGame
    }
  },
  UIN20MiniGameHelp = {
    uiPrefab = "UIN20MiniGameHelp.prefab",
    maskType = MaskType.MT_None
  },
  UIActivityN21CCMainController = {
    uiPrefab = "UIActivityN21CCMainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN21
    }
  },
  UIActivityN21CCIntro = {
    uiPrefab = "UIActivityN21CCIntro.prefab",
    maskType = MaskType.MT_None
  },
  UIActivityN21CCLevelDetail = {
    uiPrefab = "UIActivityN21CCLevelDetail.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN21
    }
  },
  UIActivityN21CCShowCardController = {
    uiPrefab = "UIActivityN21CCShowCardController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomelandAquarium = {
    uiPrefab = "UIHomelandAquarium.prefab",
    maskType = MaskType.MT_None
  },
  UIN21LineMissionController = {
    uiPrefab = "UIN21LineMissionController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN21
    }
  },
  UIN21Controller = {
    uiPrefab = "UIN21Controller.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN21
    }
  },
  UIN21IntrController = {
    uiPrefab = "UIN21IntrController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIN21ShopController = {
    uiPrefab = "UIN21ShopController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN21
    }
  },
  UIActivityN21CCAffixDetail = {
    uiPrefab = "UIActivityN21CCAffixDetail.prefab",
    maskType = MaskType.MT_None
  },
  UIActivityN21CCShop = {
    uiPrefab = "UIActivityN21CCShop.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN21
    }
  },
  UIHomePetInvite = {
    uiPrefab = "UIHomePetInvite.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomePetInviteEnable = {
    uiPrefab = "UIHomePetInviteEnable.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIShopHomelandSet = {
    uiPrefab = "UIShopHomelandSet.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIShopHomelandParts = {
    uiPrefab = "UIShopHomelandParts.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIShopHomelandPrecious = {
    uiPrefab = "UIShopHomelandPrecious.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIShopHomelandGetCoin = {
    uiPrefab = "UIShopHomelandGetCoin.prefab",
    maskType = MaskType.MT_MoreBlackMask
  },
  UIShopHomelandPreview = {
    uiPrefab = "UIShopHomelandPreview.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIMedalMainController = {
    uiPrefab = "UIMedalMainController.prefab",
    maskType = MaskType.MT_None
  },
  UIMedalListController = {
    uiPrefab = "UIMedalListController.prefab",
    maskType = MaskType.MT_None
  },
  UIMedalGroupTipsController = {
    uiPrefab = "UIMedalGroupTipsController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UIMedalGroupListController = {
    uiPrefab = "UIMedalGroupListController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIMedalTipsController = {
    uiPrefab = "UIMedalTipsController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIMedalTipsHomelandController = {
    uiPrefab = "UIMedalTipsHomelandController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIMedalCardDetailController = {
    uiPrefab = "UIMedalCardDetailController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISailingLevelDetail = {
    uiPrefab = "UISailingLevelDetail.prefab",
    maskType = MaskType.MT_None
  },
  UIMedalBgListController = {
    uiPrefab = "UIMedalBgListController.prefab",
    maskType = MaskType.MT_None
  },
  UIMedalGroupApply = {
    uiPrefab = "UIMedalGroupApply.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UISailingLevelResetTeam = {
    uiPrefab = "UISailingLevelResetTeam.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISailingRewardsController = {
    uiPrefab = "UISailingRewardsController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIMedalCard_New = {
    uiPrefab = "UIMedalCard_New.prefab",
    maskType = MaskType.MT_None
  },
  UIActivityN22MainController = {
    uiPrefab = "UIN22MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN22
    }
  },
  UIActivityN22LineMissionController = {
    uiPrefab = "UIN22LineMissionController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN22
    }
  },
  UIActivtiyN22HardLevelController = {
    uiPrefab = "UIN22HardLevelController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN22
    }
  },
  UIActivityN22Intro = {
    uiPrefab = "UIN22Intro.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivtiyN22ShopController = {
    uiPrefab = "UIN22ShopController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN12EntrustStageController = {
    uiPrefab = "UIN12EntrustStageController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN12
    }
  },
  UIN22EntrustStageController = {
    uiPrefab = "UIN22EntrustStageController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN22
    }
  },
  UIN22EntrustStageDetailController = {
    uiPrefab = "UIN22EntrustStageDetailController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN22EntrustLevelController = {
    uiPrefab = "UIN22EntrustLevelController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN22
    }
  },
  UIN22EntrustMsgPopController = {
    uiPrefab = "UIN22Entrust_MsgPopController.prefab",
    maskType = MaskType.MT_None
  },
  UIN22EntrustRewardsController = {
    uiPrefab = "UIN22Entrust_RewardsController.prefab",
    maskType = MaskType.MT_None
  },
  UIN22EntrustEventController = {
    uiPrefab = "UIN22EntrustEventController.prefab",
    maskType = MaskType.MT_None
  },
  UIHomelandMoviePrepareMainController = {
    uiPrefab = "UIHomelandMoviePrepareMainController.prefab",
    maskType = MaskType.MT_None
  },
  UIHomelandMovieIntroduceController = {
    uiPrefab = "UIHomelandMovieIntroduceController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomelandMovieTaskIntroduceController = {
    uiPrefab = "UIHomelandMovieTaskIntroduceController.prefab",
    maskType = MaskType.MT_None
  },
  UIHomelandMovieMainController = {
    uiPrefab = "UIHomelandMovieMainController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomelandMovieActorController = {
    uiPrefab = "UIHomelandMovieActorController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomelandAnonymousMovieController = {
    uiPrefab = "UIHomelandAnonymousMovieController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIHomelandAnonymousPopController = {
    uiPrefab = "UIHomelandAnonymousPopController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIHomelandMoviePlaybackController = {
    uiPrefab = "UIHomelandMoviePlaybackController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomelandMovieExplainController = {
    uiPrefab = "UIHomelandMovieExplainController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UIHomelandMovieSaveName = {
    uiPrefab = "UIHomelandMovieSaveName.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomelandMovieClosingController = {
    uiPrefab = "UIHomelandMovieClosingController.prefab",
    maskType = MaskType.MT_None
  },
  UIHomeMovieStoryController = {
    uiPrefab = "UIHomeMovieStoryController.prefab",
    maskType = MaskType.MT_None
  },
  UIHomelandMovieActionController = {
    uiPrefab = "UIHomelandMovieActionController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomelandMovieSaveReplaceController = {
    uiPrefab = "UIHomelandMovieSaveReplaceController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIMiniMazeChoosePartnerController = {
    uiPrefab = "UIMiniMazeChoosePartnerController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIMiniMazeChooseRelicController = {
    uiPrefab = "UIMiniMazeChooseRelicController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityN24MainController = {
    uiPrefab = "UIActivityN24MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN24
    }
  },
  UIHauteCoutureDraw_Review = {
    uiPrefab = "UIHauteCoutureDraw_Review.prefab",
    maskType = MaskType.MT_None
  },
  UIHauteCoutureDrawDuplicateReward = {
    uiPrefab = "UIHauteCoutureDrawDuplicateReward.prefab",
    maskType = MaskType.MT_None
  },
  UIHauteCoutureDrawChargeController_Re = {
    uiPrefab = "UIHauteCoutureDrawChargeController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHauteCoutureDrawChargeController_Review2 = {
    uiPrefab = "UIHauteCoutureDrawChargeController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIHomelandFishMatchEnd = {
    uiPrefab = "UIHomelandFishMatchEnd.prefab",
    maskType = MaskType.MT_None
  },
  UIFeatureScanController = {
    uiPrefab = "UIFeatureScanController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN24SpecialTask = {
    uiPrefab = "UIN24SpecialTask.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN25IdolLogin = {
    uiPrefab = "UIN25IdolLogin.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMMiniGame
    }
  },
  UIN25IdolBreakLoad = {
    uiPrefab = "UIN25IdolBreakLoad.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN25IdolBreakTips = {
    uiPrefab = "UIN25IdolBreakTips.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN25IdolLoading = {
    uiPrefab = "UIN25IdolLoading.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN25IdolSumUp = {
    uiPrefab = "UIN25IdolSumUp.prefab",
    maskType = MaskType.MT_None
  },
  UIN25IdolEndCG = {
    uiPrefab = "UIN25IdolEndCG.prefab",
    maskType = MaskType.MT_None
  },
  UIN25IdolCollection = {
    uiPrefab = "UIN25IdolCollection.prefab",
    maskType = MaskType.MT_None
  },
  UIN25IdolGetItem = {
    uiPrefab = "UIN25IdolGetItem.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {},
      UISetParamOnShowComponent = {
        [UIComponentParamType.KeepVoice] = true
      }
    }
  },
  UIN25IdolGame = {
    uiPrefab = "UIN25Idol_Game.prefab",
    maskType = MaskType.MT_None
  },
  UIN25IdolGamePuppy = {
    uiPrefab = "UIN25Idol_Game_Puppy.prefab",
    maskType = MaskType.MT_None
  },
  UIN25IdolGameTraining = {
    uiPrefab = "UIN25Idol_Game_Training.prefab",
    maskType = MaskType.MT_None
  },
  UIN6MainController_Review = {
    uiPrefab = "UIN6MainController_Review.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN6
    }
  },
  UIActivityN6LineMissionReview = {
    uiPrefab = "UIActivityN6LineMissionReview.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN6
    }
  },
  UIActivityN6ReviewBuildingMainController = {
    uiPrefab = "UIActivityN6ReviewBuildingMainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN6
    }
  },
  UIActivityN6ReviewRewardController = {
    uiPrefab = "UIActivityNPlusSixRewardController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN6
    }
  },
  UIN25VampireTips = {
    uiPrefab = "UIN25VampireTips.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN25VampireLevel = {
    uiPrefab = "UIN25VampireLevel.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN25Vampire
    }
  },
  UIN25VampireChallengeTask = {
    uiPrefab = "UIN25VampireChallengeTask.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN25VampireChallengeTaskGain = {
    uiPrefab = "UIN25VampireChallengeTaskGain.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN25IdolAct = {
    uiPrefab = "UIN25Idol_Act.prefab",
    maskType = MaskType.MT_None
  },
  UIN25IdolActResult = {
    uiPrefab = "UIN25Idol_ActResult.prefab",
    maskType = MaskType.MT_None
  },
  UIN25IdolApController = {
    uiPrefab = "UIN25Idol_Ap.prefab",
    maskType = MaskType.MT_None
  },
  UIN25IdolApResult = {
    uiPrefab = "UIN25Idol_ApResult.prefab",
    maskType = MaskType.MT_None
  },
  UIN25IdolConcertEnter = {
    uiPrefab = "UIN25Idol_ConcertEnter.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN25IdolConcert = {
    uiPrefab = "UIN25Idol_Concert.prefab",
    maskType = MaskType.MT_None
  },
  UIN25IdolConcertResult = {
    uiPrefab = "UIN25Idol_ConcertResult.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN25NewYear = {
    uiPrefab = "UIN25NewYear.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN25NewYearAwards = {
    uiPrefab = "UIN25NewYearAwards.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIN25IdolStoryController = {
    uiPrefab = "UIN25IdolStoryController.prefab",
    maskType = MaskType.MT_None
  },
  UIN25IdolNotOpenNextDay = {
    uiPrefab = "UIN25Idol_NotOpenNextDay.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityN26MainController = {
    uiPrefab = "UIActivityN26MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN26
    }
  },
  UIN26Line = {
    uiPrefab = "UIN26Line.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN26
    }
  },
  UIN26HardLevel = {
    uiPrefab = "UIN26HardLevel.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN26
    }
  },
  UIActivityN26Shop = {
    uiPrefab = "UIActivityN26Shop.prefab",
    maskType = MaskType.MT_None
  },
  UIN26Movie = {
    uiPrefab = "UIN26Movie.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN0CookMatRequireController = {
    uiPrefab = "UIN0CookMatRequireController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN0CookBookController = {
    uiPrefab = "UIN0CookBookController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN0CookMakeController = {
    uiPrefab = "UIN0CookMakeController.prefab",
    maskType = MaskType.MT_None
  },
  UIN0CookMakeSuccController = {
    uiPrefab = "UIN0CookMakeSuccController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN0CookMakeFailedController = {
    uiPrefab = "UIN0CookMakeFailedController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN27PostInnerGameController = {
    uiPrefab = "UIN27PostInnerGameController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMMiniGame
    }
  },
  UIActivityN27HardLevelMain = {
    uiPrefab = "UIActivityN27HardLevelMain.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN27
    }
  },
  UIActivityN27DiffLevelDetail = {
    uiPrefab = "UIActivityN27DiffLevelDetail.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIActivityDiffLevelDetail = {
    uiPrefab = "UIActivityDiffLevelDetail.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIEliminateController = {
    uiPrefab = "UIEliminateController.prefab",
    maskType = MaskType.MT_None
  },
  UIEliminateSupportCampController = {
    uiPrefab = "UIEliminateSupportCampController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIEliminateFettersController = {
    uiPrefab = "UIEliminateFettersController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIEliminateLevelController = {
    uiPrefab = "UIEliminateLevelController.prefab",
    maskType = MaskType.MT_None
  },
  UIEliminateAwardController = {
    uiPrefab = "UIEliminateAwardController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIEliminateDiffController = {
    uiPrefab = "UIEliminateDiffController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIEliminateResultController = {
    uiPrefab = "UIEliminateResultController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISetParamOnShowComponent = {
        [UIComponentParamType.KeepVoice] = true
      },
      UISwitchBGMComponent = CriAudioIDConst.BGMBattleSuccess
    }
  },
  UIEliminateBookController = {
    uiPrefab = "UIEliminateBookController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIPopStarStage = {
    uiPrefab = "UIPopStarStage.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIEliminateBattleResultController = {
    uiPrefab = "UIEliminateBattleResultController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIEliminateChooseCardController = {
    uiPrefab = "UIEliminateChooseCardController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIEliminateChooseSkillController = {
    uiPrefab = "UIEliminateChooseSkillController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN27LotteryMain = {
    uiPrefab = "UIN27LotteryMain.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMEveSinsaShop
    }
  },
  UIN27LotteryTips = {
    uiPrefab = "UIN27LotteryTips.prefab",
    maskType = MaskType.MT_None
  },
  UIN27LotteryPlot = {
    uiPrefab = "UIN27LotteryPlot.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN27LotteryUnlockPool = {
    uiPrefab = "UIN27LotteryUnlockPool.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN27LotteryGetItem = {
    uiPrefab = "UIN27LotteryGetItem.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {},
      UISetParamOnShowComponent = {
        [UIComponentParamType.KeepVoice] = true
      }
    }
  },
  UIN27PostGameClosingController = {
    uiPrefab = "UIN27PostGameClosingController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN27MiniGameController = {
    uiPrefab = "UIN27MiniGameController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN27MiniGame
    }
  },
  UIActivityValentineEndController = {
    uiPrefab = "UIActivityValentineEndController.prefab",
    maskType = MaskType.MT_None
  },
  UIActivityValentineMailboxController = {
    uiPrefab = "UIActivityValentineMailboxController.prefab",
    maskType = MaskType.MT_None
  },
  UIActivityValentineMainController = {
    uiPrefab = "UIActivityValentineMainController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityValentineGetController = {
    uiPrefab = "UIActivityValentineGetController.prefab",
    maskType = MaskType.MT_None
  },
  UIActivityValentineLetterController = {
    uiPrefab = "UIActivityValentineLetterController.prefab",
    maskType = MaskType.MT_None
  },
  UIN27Controller = {
    uiPrefab = "UIN27Controller.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {},
      UISwitchBGMComponent = CriAudioIDConst.BGMN27
    }
  },
  UIN27LineMissionController = {
    uiPrefab = "UIN27LineMissionController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {},
      UISwitchBGMComponent = CriAudioIDConst.BGMN27
    }
  },
  UIN27IntrController = {
    uiPrefab = "UIN27IntrController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIActivityValentineOpenLetterController = {
    uiPrefab = "UIActivityValentineOpenLetterController.prefab",
    maskType = MaskType.MT_None
  },
  UIActivityValentineSendLetterController = {
    uiPrefab = "UIActivityValentineSendLetterController.prefab",
    maskType = MaskType.MT_None
  },
  UIActivityN28MainController = {
    uiPrefab = "UIActivityN28MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN28
    }
  },
  UIN28GronruPlatform = {
    uiPrefab = "UIN28GronruPlatform.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.N28BounceBgmUI
    }
  },
  UIN28GronruGameForumDetails = {
    uiPrefab = "UIN28GronruGameForumDetails.prefab",
    maskType = MaskType.MT_None
  },
  UIN28ErrandController = {
    uiPrefab = "UIN28ErrandController.prefab",
    maskType = MaskType.MT_None
  },
  UIN28ErrandIntr = {
    uiPrefab = "UIN28ErrandIntr.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UIN28GronruGameFlash = {
    uiPrefab = "UIN28GronruGameFlash.prefab",
    maskType = MaskType.MT_None
  },
  UIN28GronruGameSelectPlayer = {
    uiPrefab = "UIN28GronruGameSelectPlayer.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.N28BoucneBgm
    }
  },
  UIN28GronruGameLevel = {
    uiPrefab = "UIN28GronruGameLevel.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.N28BoucneBgm
    }
  },
  UIN28GronruGameRewards = {
    uiPrefab = "UIN28GronruGameRewards.prefab",
    maskType = MaskType.MT_None
  },
  UIN28AVGMain = {
    uiPrefab = "UIN28AVGMain.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN20
    }
  },
  UIN28AVGIntro = {
    uiPrefab = "UIN28AVGIntro.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN28AVGStory = {
    uiPrefab = "UIN28AVGStory.prefab",
    maskType = MaskType.MT_None
  },
  UIN28AVGEnding = {
    uiPrefab = "UIN28AVGEnding.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN28AVGGraph = {
    uiPrefab = "UIN28AVGGraph.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN28AVGNodeDetails = {
    uiPrefab = "UIN28AVGNodeDetails.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN28AVGCollection = {
    uiPrefab = "UIN28AVGCollection.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN28AVGReview = {
    uiPrefab = "UIN28AVGReview.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN28AVGStoryEvidenceBook = {
    uiPrefab = "UIN28AVGStoryEvidenceBook.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityN28Shop = {
    uiPrefab = "UIActivityN28Shop.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN28HardLevel = {
    uiPrefab = "UIN28HardLevel.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN28
    }
  },
  UIN28Line = {
    uiPrefab = "UIN28Line.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN28
    }
  },
  UIBounceMainController = {
    uiPrefab = "UIBounceMainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.N28BounceFightBgm
    }
  },
  UIBounceMainController = {
    uiPrefab = "UIBounceMainController.prefab",
    maskType = MaskType.MT_None
  },
  UIN29ChessController = {
    uiPrefab = "UIN29ChessController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN15
    }
  },
  UIN29ChessIntro = {
    uiPrefab = "UIN29ChessIntro.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityN29MainController = {
    uiPrefab = "UIActivityN29MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN29
    }
  },
  UIActivityN29DetectiveMapController = {
    uiPrefab = "UIActivityN29DetectiveMapController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN22
    }
  },
  UIActivityN29DetectiveNewwayController = {
    uiPrefab = "UIActivityN29DetectiveNewwayController.prefab",
    maskType = MaskType.MT_None
  },
  UIActivityN29DetectiveWayController = {
    uiPrefab = "UIActivityN29DetectiveWayController.prefab",
    maskType = MaskType.MT_None
  },
  UIActivityN29DetectiveBagController = {
    uiPrefab = "UIActivityN29DetectiveBagController.prefab",
    maskType = MaskType.MT_None
  },
  UIN29DetectiveLogin = {
    uiPrefab = "UIN29DetectiveLogin.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN22
    }
  },
  UIN29DetectiveArchiveLoad = {
    uiPrefab = "UIN29DetectiveArchiveLoad.prefab",
    maskType = MaskType.MT_None
  },
  UIN29DetectiveBreakLoad = {
    uiPrefab = "UIN29DetectiveBreakLoad.prefab",
    maskType = MaskType.MT_None
  },
  UIN29DetectiveBreakTips = {
    uiPrefab = "UIN29DetectiveBreakTips.prefab",
    maskType = MaskType.MT_None
  },
  UIN29DetectiveReasoning = {
    uiPrefab = "UIN29DetectiveReasoning.prefab",
    maskType = MaskType.MT_None
  },
  UIN29DetectiveReasoningClueDetails = {
    uiPrefab = "UIN29DetectiveReasoningClueDetails.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN29DetectiveFragmentPopup = {
    uiPrefab = "UIN29DetectiveFragmentPopup.prefab",
    maskType = MaskType.MT_None
  },
  UIN29DetectiveCollection = {
    uiPrefab = "UIN29DetectiveCollection.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityN29HardLevelMain = {
    uiPrefab = "UIActivityN29HardLevelMain.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN22
    }
  },
  UIActivityN11MainController_Review = {
    uiPrefab = "UIActivityN11ReviewMain.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN11
    }
  },
  UIActivityN11LineMissionController_Review = {
    uiPrefab = "UIActivityN11ReviewLineMissionController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN11
    }
  },
  UIN29DetectivePersonController = {
    uiPrefab = "UIN29DetectivePersonController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN22
    }
  },
  UIN29DetectiveCluePopController = {
    uiPrefab = "UIN29DetectiveCluePopController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN22
    }
  },
  UIN29DetectiveSuspectController = {
    uiPrefab = "UIN29DetectiveSuspectController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN22
    }
  },
  UIN29DetectiveReasoningPopController = {
    uiPrefab = "UIN29DetectiveReasoningPopController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN22
    }
  },
  UIQuestDailyWeekAwards = {
    uiPrefab = "UIQuestDailyWeekAwards.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActiveVarInfo = {
    uiPrefab = "UIActiveVarInfo.prefab",
    maskType = MaskType.MT_None
  },
  UIActivityN29LineLevel = {
    uiPrefab = "UIActivityN29LineLevel.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN29
    }
  },
  UIN29Shop = {
    uiPrefab = "UIN29Shop.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN29
    }
  },
  UIN29ShopIntro = {
    uiPrefab = "UIN29ShopIntro.prefab",
    maskType = MaskType.MT_None
  },
  UIBackPackUseBox = {
    uiPrefab = "UIBackPackUseBox.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityPowerCostController2 = {
    uiPrefab = "UIActivityPowerCostController2.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityN30MainController = {
    uiPrefab = "UIActivityN30MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN30
    }
  },
  UIN30ShopController = {
    uiPrefab = "UIN30ShopController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN30
    }
  },
  UIN12MainController_Review = {
    uiPrefab = "UIN12MainReviewController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN12
    }
  },
  UIN12IntegralController_Review = {
    uiPrefab = "UIN12IntegralReviewController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIN30Entrust = {
    uiPrefab = "UIN30EntrustMain.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN30
    }
  },
  UIN30EntrustStage = {
    uiPrefab = "UIN30EntrustStage.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN30EntrustLine = {
    uiPrefab = "UIN30EntrustLine.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN30
    }
  },
  UIN30EntrustFinishPopup = {
    uiPrefab = "UIN30EntrustFinishPopup.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN30EntrustEvent = {
    uiPrefab = "UIN30EntrustEvent.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN30EntrustItemInfo = {
    uiPrefab = "UIN30EntrustItemInfo.prefab",
    maskType = MaskType.MT_None
  },
  UIN31SecondAnniversaryAwards = {
    uiPrefab = "UIN31SecondAnniversaryAwards.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIWorldBossViewTeam = {
    uiPrefab = "UIWorldBossViewTeam.prefab",
    maskType = MaskType.MT_None
  },
  UIWorldBossQuest = {
    uiPrefab = "UIWorldBossQuest.prefab",
    maskType = MaskType.MT_None
  },
  UICommonItemInfo = {
    uiPrefab = "UICommonItemInfo.prefab",
    maskType = MaskType.MT_None
  },
  UIWorldBossLegendDan = {
    uiPrefab = "UIWorldBossLegendDan.prefab",
    maskType = MaskType.MT_None
  },
  UIN31HardLevel = {
    uiPrefab = "UIN31HardLevel.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN31
    }
  },
  UIN31Line = {
    uiPrefab = "UIN31Line.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN31
    }
  },
  UIActivityN31MainController = {
    uiPrefab = "UIActivityN31MainController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN31
    }
  },
  UIActivityN31Shop = {
    uiPrefab = "UIActivityN31Shop.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN31
    }
  },
  UIPopStarNormalLevelDetail = {
    uiPrefab = "UIPopStarNormalLevelDetail.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIPopStarChallengeLevelDetail = {
    uiPrefab = "UIPopStarChallengeLevelDetail.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIPopStarTeam = {
    uiPrefab = "UIPopStarTeam.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIPopStarTeamSuggest = {
    uiPrefab = "UIPopStarTeamSuggest.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIN13MainControllerReview = {
    uiPrefab = "UIN13MainControllerReview.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN13
    }
  },
  UIN13LineMissionControllerReview = {
    uiPrefab = "UIN13LineMissionControllerReview.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN13
    }
  },
  UIN13BuildControllerReview = {
    uiPrefab = "UIN13BuildControllerReview.prefab",
    maskType = MaskType.MT_BlurMask,
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN13Build
    }
  },
  UIN13BuildPlotControllerReview = {
    uiPrefab = "UIN13BuildPlotControllerReview.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN32MultiLineMain = {
    uiPrefab = "UIN32MultiLineMain.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN32
    }
  },
  UIN32MultiLineMapController = {
    uiPrefab = "UIN32MultiLineMapController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN32
    }
  },
  UIN32MultiLinePetUnlock = {
    uiPrefab = "UIN32MultiLinePetUnlock.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN32MultiLineOverTips = {
    uiPrefab = "UIN32MultiLineOverTips.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN32MultiLineFightDetails = {
    uiPrefab = "UIN32MultiLineFightDetails.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN32MultiLinePlotDetails = {
    uiPrefab = "UIN32MultiLinePlotDetails.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN32MultiLineDialogueDetails = {
    uiPrefab = "UIN32MultiLineDialogueDetails.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN32MultiLineDialogue = {
    uiPrefab = "UIN32MultiLineDialogue.prefab",
    maskType = MaskType.MT_None
  },
  UIActivityN32MainController = {
    uiPrefab = "UIActivityN32MainController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN32
    }
  },
  UIN32ShopController = {
    uiPrefab = "UIN32ShopController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN32
    }
  },
  UIActivityN32PeridalesLevelMain = {
    uiPrefab = "UIActivityN32PeridalesLevelMain.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN32
    }
  },
  UIActivityN32HardLevelMain = {
    uiPrefab = "UIActivityN32HardLevelMain.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN32
    }
  },
  UIActiveTaskAwardShowController = {
    uiPrefab = "UIActiveTaskAwardShowController.prefab",
    maskType = MaskType.MT_None
  },
  UIN14MainReview = {
    uiPrefab = "UIN14MainReview.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN13Build
    }
  },
  UIActivityN14LineMissionControllerReview = {
    uiPrefab = "UIActivityN14LineMissionControllerReview.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN13Build
    }
  },
  UIUpLevelAddQuickBox = {
    uiPrefab = "UIUpLevelAddQuickBox.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIMsgBoxWithAssets = {
    uiPrefab = "UIMsgBoxWithAssets.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN32MultiLineArchive = {
    uiPrefab = "UIN32MultiLineArchive.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UITowerPassAward = {
    uiPrefab = "UITowerPassAward.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN33EightPetsStage = {
    uiPrefab = "UIN33EightPetsStage.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN33EightPetsTeams = {
    uiPrefab = "UIN33EightPetsTeams.prefab",
    maskType = MaskType.MT_None
  },
  UIActivityN33MainController = {
    uiPrefab = "UIActivityN33MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN33
    }
  },
  UIActivityN33LevelController = {
    uiPrefab = "UIActivityN33LevelController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN33
    }
  },
  UIActivityN33LevelDetail = {
    uiPrefab = "UIActivityN33LevelDetail.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityN33LevelList = {
    uiPrefab = "UIActivityN33LevelList.prefab",
    maskType = MaskType.MT_None
  },
  UIActivityN33DateMainController = {
    uiPrefab = "UIActivityN33DateMainController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN33
    }
  },
  UIActivityN33BuildingInfo = {
    uiPrefab = "UIActivityN33BuildingInfo.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN33
    }
  },
  UIActivityN33ArchUpgradeReward = {
    uiPrefab = "UIActivityN33ArchUpgradeReward.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN33
    }
  },
  UIActivityN33DatePetController = {
    uiPrefab = "UIActivityN33DatePetController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityN33DateManualController = {
    uiPrefab = "UIActivityN33DateManualController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityN33DateInviteController = {
    uiPrefab = "UIActivityN33DateInviteController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN33ShopController = {
    uiPrefab = "UIN33ShopController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMMiniGame
    }
  },
  UIN33LotteryGetItem = {
    uiPrefab = "UIN33LotteryGetItem.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {},
      UISetParamOnShowComponent = {
        [UIComponentParamType.KeepVoice] = true
      }
    }
  },
  UIN15MainControllerReview = {
    uiPrefab = "UIN15MainControllerReview.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN15
    }
  },
  UIN15LineMissionControllerReview = {
    uiPrefab = "UIN15LineMissionControllerReview.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN15
    }
  },
  UISeasonExploreMainController = {
    uiPrefab = "UISeasonExploreMainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = SeasonCriAudio.BGMMain
    }
  },
  UISeasonPreviewController = {
    uiPrefab = "UISeasonPreviewController.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonCollectionController = {
    uiPrefab = "UISeasonCollectionController.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMusicCollectionController = {
    uiPrefab = "UISeasonMusicCollectionController.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonCgCollectionController = {
    uiPrefab = "UISeasonCgCollectionController.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonCgDetailController = {
    uiPrefab = "UISeasonCgDetailController.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonRareCollectionController = {
    uiPrefab = "UISeasonRareCollectionController.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMain = {
    uiPrefab = "UISeasonMain.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = SeasonCriAudio.BGMMap
    }
  },
  UISeasonLevelStage = {
    uiPrefab = "UISeasonLevelStage.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonShowAwards = {
    uiPrefab = "UISeasonShowAwards.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UISeasonItemTips = {
    uiPrefab = "UISeasonItemTips.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonShowCollectionAward = {
    uiPrefab = "UISeasonShowCollectionAward.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UISeasonHelperController = {
    uiPrefab = "UISeasonHelperController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UISeasonStageDiffTips = {
    uiPrefab = "UISeasonStageDiffTips.prefab",
    maskType = MaskType.MT_LessBlackMask
  },
  UISeasonBuffMainInfo = {
    uiPrefab = "UISeasonBuffMainInfo.prefab",
    maskType = MaskType.MT_LessBlackMask,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UISeasonBuffMainTips = {
    uiPrefab = "UISeasonBuffMainTips.prefab",
    maskType = MaskType.MT_LessBlackMask
  },
  UISeasonStageDiffTips = {
    uiPrefab = "UISeasonStageDiffTips.prefab",
    maskType = MaskType.MT_LessBlackMask
  },
  UISeasonS1Collages = {
    uiPrefab = "UISeasonS1Collages.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonBuffLevelUp = {
    uiPrefab = "UISeasonBuffLevelUp.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISetParamOnShowComponent = {
        [UIComponentParamType.KeepVoice] = true
      },
      UISimpleTransitionComponent = {}
    }
  },
  UISeasonBuffInnerGameInfo = {
    uiPrefab = "UISeasonBuffInnerGameInfo.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonTaskListController = {
    uiPrefab = "UISeasonTaskListController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISeasonQuestController = {
    uiPrefab = "UISeasonQuestController.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonQuestDetail = {
    uiPrefab = "UISeasonQuestDetail.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonBackTrack = {
    uiPrefab = "UISeasonBackTrack.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISeasonBackTrackPop = {
    uiPrefab = "UISeasonBackTrackPop.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISeasonSkinConfirmNormalController = {
    uiPrefab = "UISeasonSkinConfirmNormalController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIS1MainController = {
    uiPrefab = "UIS1MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = SeasonCriAudio.BGMS1
    }
  },
  UIS1ExchangeController = {
    uiPrefab = "UIS1ExchangeController.prefab",
    maskType = MaskType.MT_None
  },
  UIS1ExchangeConfirm = {
    uiPrefab = "UIS1ExchangeConfirm.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UISeasonPlotEnter = {
    uiPrefab = "UISeasonPlotEnter.prefab",
    maskType = MaskType.MT_LessBlackMask
  },
  UISeasonBubble = {
    uiPrefab = "UISeasonBubble.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonTransitions = {
    uiPrefab = "UISeasonTransitions.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonTransitionAnimations = {
    uiPrefab = "UISeasonTransitionAnimations.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonActionPointTip = {
    uiPrefab = "UISeasonActionPointTip.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonFinalPlotShare = {
    uiPrefab = "UISeasonFinalPlotShare.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISeasonStoryController = {
    uiPrefab = "UISeasonStoryController.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonStoryReviewController = {
    uiPrefab = "UISeasonStoryReviewController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISeasonStorySkipController = {
    uiPrefab = "UISeasonStorySkipController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIRecruit = {
    uiPrefab = "UIRecruit.prefab",
    hideUnderLayer = HideUnderLayerType.Manual_Hide,
    maskType = MaskType.MT_None
  },
  UIRecruitConfirm = {
    uiPrefab = "UIRecruitConfirm.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIDrawCardAwardController = {
    uiPrefab = "UIDrawCardAwardController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIRecruitWish = {
    uiPrefab = "UIRecruitWish.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIRecruitWishSelection = {
    uiPrefab = "UIRecruitWishSelection.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UICriVideoController = {
    uiPrefab = "UICriVideoController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UICriVideoControllerNowrap = {
    uiPrefab = "UICriVideoController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN34DispatchMain = {
    uiPrefab = "UIN34DispatchMain.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN30
    }
  },
  UIN34DispatchComplete = {
    uiPrefab = "UIN34DispatchComplete.prefab",
    maskType = MaskType.MT_None
  },
  UIN34DispatchDialogueOpen = {
    uiPrefab = "UIN34DispatchDialogueOpen.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN34DispatchAllOver = {
    uiPrefab = "UIN34DispatchAllOver.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityN34TaskMainController = {
    uiPrefab = "UIActivityN34TaskMainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN34
    }
  },
  UIActivityN34MainController = {
    uiPrefab = "UIActivityN34MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN34
    }
  },
  UIActivityN34TaskInfomationMainController = {
    uiPrefab = "UIActivityN34TaskInfomationMainController.prefab",
    maskType = MaskType.MT_None
  },
  UIN34TaskDelegatePerson = {
    uiPrefab = "UIN34TaskDelegatePerson.prefab",
    maskType = MaskType.MT_None
  },
  UIN34DispatchTerminalMainControlller = {
    uiPrefab = "UIN34DispatchTerminalMainControlller.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN34DispatchTerminalToast = {
    uiPrefab = "UIN34DispatchTerminalToast.prefab",
    maskType = MaskType.MT_None
  },
  UIN34DispatchAwardShowControlller = {
    uiPrefab = "UIN34DispatchAwardShowControlller.prefab",
    maskType = MaskType.MT_None
  },
  UIActivityN34TaskInfomationRewardPreview = {
    uiPrefab = "UIActivityN34TaskInfomationRewardPreview.prefab",
    maskType = MaskType.MT_None
  },
  UIN34DelegatePersonTips = {
    uiPrefab = "UIN34DelegatePersonTips.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIActivityN16ReviewMainController = {
    uiPrefab = "UIActivityN16ReviewMainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN16
    }
  },
  UIActivityN16ReviewLineMissionController = {
    uiPrefab = "UIActivityN16ReviewLineMissionController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN16
    }
  },
  UIActivityLevelRecordController = {
    uiPrefab = "UIActivityLevelRecordController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIActivityN34TaskInfomationPasteTips = {
    uiPrefab = "UIActivityN34TaskInfomationPasteTips.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIActivityN34TaskInfomationAwards = {
    uiPrefab = "UIActivityN34TaskInfomationAwards.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIActivityN34TaskInfomationRewardPreviewTip = {
    uiPrefab = "UIActivityN34TaskInfomationRewardPreviewTip.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIS2MainController = {
    uiPrefab = "UIS2MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = SeasonCriAudio.BGMS1
    }
  },
  UIS2ExchangeController = {
    uiPrefab = "UIS2ExchangeController.prefab",
    maskType = MaskType.MT_None
  },
  UIS2ExchangeConfirm = {
    uiPrefab = "UIS2ExchangeConfirm.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UISeasonBalanceEvidenceController = {
    uiPrefab = "UISeasonBalanceEvidenceController.prefab"
  },
  UISeasonBalanceQAController = {
    uiPrefab = "UISeasonBalanceQAController.prefab"
  },
  UISeasonBalanceWeightController = {
    uiPrefab = "UISeasonBalanceWeightController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UISeasonShowEvidenceAward = {
    uiPrefab = "UISeasonShowEvidenceAward.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UISeasonS2Collages = {
    uiPrefab = "UISeasonS2Collages.prefab"
  },
  UISeasonMainS2 = {
    uiPrefab = "UISeasonMainS2.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = SeasonCriAudio.BGMMapS2
    }
  },
  UISeasonLevelStageS2 = {
    uiPrefab = "UISeasonLevelStageS2.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonTaskLevelStageS2 = {
    uiPrefab = "UISeasonTaskLevelStageS2.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonTaskLevelStageS3 = {
    uiPrefab = "UISeasonTaskLevelStageS3.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonHelperControllerS2 = {
    uiPrefab = "UISeasonHelperControllerS2.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UISeasonBuffMainInfoS2 = {
    uiPrefab = "UISeasonBuffMainInfoS2.prefab",
    maskType = MaskType.MT_LessBlackMask,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UISeasonBuffLevelUpS2 = {
    uiPrefab = "UISeasonBuffLevelUpS2.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISetParamOnShowComponent = {
        [UIComponentParamType.KeepVoice] = true
      },
      UISimpleTransitionComponent = {}
    }
  },
  UISeasonBuffMainTipsS2 = {
    uiPrefab = "UISeasonBuffMainTipsS2.prefab",
    maskType = MaskType.MT_LessBlackMask
  },
  UISeasonActionPointTipS2 = {
    uiPrefab = "UISeasonActionPointTipS2.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonShowCollectionAwardS2 = {
    uiPrefab = "UISeasonShowCollectionAwardS2.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UISeasonShowAwardsS2 = {
    uiPrefab = "UISeasonShowAwardsS2.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIS3MainController = {
    uiPrefab = "UIS3MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = SeasonCriAudio.BGMS1
    }
  },
  UIS3HelperController = {
    uiPrefab = "UIS3HelperController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UIS3ExchangeController = {
    uiPrefab = "UIS3ExchangeController.prefab",
    maskType = MaskType.MT_None
  },
  UIS3ExchangeConfirm = {
    uiPrefab = "UIS3ExchangeConfirm.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UISeasonMainS3 = {
    uiPrefab = "UISeasonMainS3.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = SeasonCriAudio.BGMMapS3
    }
  },
  UISeasonBuildControllerS3 = {
    uiPrefab = "UISeasonBuildControllerS3.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonActionPointTipS3 = {
    uiPrefab = "UISeasonActionPointTipS3.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonS3Collages = {
    uiPrefab = "UISeasonS3Collages.prefab"
  },
  UISeasonLevelStageS3 = {
    uiPrefab = "UISeasonLevelStageS3.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonBuffLevelUpS3 = {
    uiPrefab = "UISeasonBuffLevelUpS3.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISetParamOnShowComponent = {
        [UIComponentParamType.KeepVoice] = true
      },
      UISimpleTransitionComponent = {}
    }
  },
  UISeasonBuffMainInfoS3 = {
    uiPrefab = "UISeasonBuffMainInfoS3.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UISeasonBuffMainTipsS3 = {
    uiPrefab = "UISeasonBuffMainTipsS3.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISeasonShowNormalAwardS3 = {
    uiPrefab = "UISeasonShowNormalAwardS3.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UISeasonShowCollectionAwardS3 = {
    uiPrefab = "UISeasonShowCollectionAwardS3.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UISeasonShowAwardsS3 = {
    uiPrefab = "UISeasonShowAwardsS3.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UISeasonStoryS3 = {
    uiPrefab = "UISeasonStoryS3.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonStoryReviewS3 = {
    uiPrefab = "UISeasonStoryReviewS3.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISeasonStorySkipS3 = {
    uiPrefab = "UISeasonStorySkipS3.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UIS4MainController = {
    uiPrefab = "UIS4MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = SeasonCriAudio.BGMS1
    }
  },
  UIS4ExchangeController = {
    uiPrefab = "UIS4ExchangeController.prefab",
    maskType = MaskType.MT_None
  },
  UIS4ExchangeConfirm = {
    uiPrefab = "UIS4ExchangeConfirm.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UISeasonS4Collages = {
    uiPrefab = "UISeasonS4Collages.prefab"
  },
  UIS4HelperController = {
    uiPrefab = "UIS4HelperController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UISeasonMainS4 = {
    uiPrefab = "UISeasonMainS4.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = SeasonCriAudio.BGMMapS4
    }
  },
  UISeasonLevelStageS4 = {
    uiPrefab = "UISeasonLevelStageS4.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonActionPointTipS4 = {
    uiPrefab = "UISeasonActionPointTipS4.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonBuffLevelUpS4 = {
    uiPrefab = "UISeasonBuffLevelUpS4.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISetParamOnShowComponent = {
        [UIComponentParamType.KeepVoice] = true
      },
      UISimpleTransitionComponent = {}
    }
  },
  UISeasonBuffMainInfoS4 = {
    uiPrefab = "UISeasonBuffMainInfoS4.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UISeasonBuffMainTipsS4 = {
    uiPrefab = "UISeasonBuffMainTipsS4.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISeasonShowAwardsS4 = {
    uiPrefab = "UISeasonShowAwardsS4.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UISeasonShowNormalAwardS4 = {
    uiPrefab = "UISeasonShowNormalAwardS4.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UIS4TradeMainController = {
    uiPrefab = "UIS4TradeMainController.prefab",
    maskType = MaskType.MT_None
  },
  UIS4DiaryController = {
    uiPrefab = "UIS4DiaryController.prefab",
    maskType = MaskType.MT_None
  },
  UIS4ShowEventController = {
    uiPrefab = "UIS4ShowEventController.prefab",
    maskType = MaskType.MT_None
  },
  UIS4TradeCrewController = {
    uiPrefab = "UIS4TradeCrewController.prefab",
    maskType = MaskType.MT_None
  },
  UIS4TradeCrewGetController = {
    uiPrefab = "UIS4TradeCrewGetController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIS4TradeGameChoiceController = {
    uiPrefab = "UIS4TradeGameChoiceController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIS4TradeGameMainController = {
    uiPrefab = "UIS4TradeGameMainController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIS4TradeGameResultController = {
    uiPrefab = "UIS4TradeGameResultController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIS4LevelUpController = {
    uiPrefab = "UIS4LevelUpController.prefab",
    maskType = MaskType.MT_None
  },
  UIS4ProgressController = {
    uiPrefab = "UIS4ProgressController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIS4StartGameEnsureController = {
    uiPrefab = "UIS4StartGameEnsureController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISeasonMainS5 = {
    uiPrefab = "UISeasonMainS5.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = SeasonCriAudio.BGMMapS5
    }
  },
  UIS5MainController = {
    uiPrefab = "UIS5MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = SeasonCriAudio.BGMMapS5
    }
  },
  UISeasonExchangeController = {
    uiPrefab = "UISeasonExchangeController.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonExchangeConfirm = {
    uiPrefab = "UISeasonExchangeConfirm.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UISeasonSeasonCollages = {
    uiPrefab = "UISeasonSeasonCollages.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIS5HelperController = {
    uiPrefab = "UIS5HelperController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UISeasonLevelStageS5 = {
    uiPrefab = "UISeasonLevelStageS5.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonActionPointTipS5 = {
    uiPrefab = "UISeasonActionPointTipS5.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonBuffLevelUpS5 = {
    uiPrefab = "UISeasonBuffLevelUpS5.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISetParamOnShowComponent = {
        [UIComponentParamType.KeepVoice] = true
      },
      UISimpleTransitionComponent = {}
    }
  },
  UISeasonBuffMainInfoS5 = {
    uiPrefab = "UISeasonBuffMainInfoS5.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UISeasonBuffMainTipsS5 = {
    uiPrefab = "UISeasonBuffMainTipsS5.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISeasonShowAwardsS5 = {
    uiPrefab = "UISeasonShowAwardsS5.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UISeasonShowNormalAwardS5 = {
    uiPrefab = "UISeasonShowNormalAwardS5.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UISeasonConfirm2 = {
    uiPrefab = "UISeasonConfirm2.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISeasonOnceMission = {
    uiPrefab = "UISeasonOnceMission.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonOnceMissionStage = {
    uiPrefab = "UISeasonOnceMissionStage.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISeasonOnceMissionController = {
    uiPrefab = "UISeasonOnceMissionController.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMainS6 = {
    uiPrefab = "UISeasonMainS6.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = SeasonCriAudio.BGMMapS6
    }
  },
  UIS6MainController = {
    uiPrefab = "UIS6MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = SeasonCriAudio.BGMMapS6
    }
  },
  UIS6HelperController = {
    uiPrefab = "UIS6HelperController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UISeasonLevelStageS6 = {
    uiPrefab = "UISeasonLevelStageS6.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonActionPointTipS6 = {
    uiPrefab = "UISeasonActionPointTipS6.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonBuffLevelUpS6 = {
    uiPrefab = "UISeasonBuffLevelUpS6.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISetParamOnShowComponent = {
        [UIComponentParamType.KeepVoice] = true
      },
      UISimpleTransitionComponent = {}
    }
  },
  UISeasonBuffMainInfoS6 = {
    uiPrefab = "UISeasonBuffMainInfoS6.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UISeasonBuffMainTipsS6 = {
    uiPrefab = "UISeasonBuffMainTipsS6.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISeasonShowAwardsS6 = {
    uiPrefab = "UISeasonShowAwardsS6.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UISeasonShowNormalAwardS6 = {
    uiPrefab = "UISeasonShowNormalAwardS6.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UISeasonMainS7 = {
    uiPrefab = "UISeasonMainS7.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = SeasonCriAudio.BGMMapS7
    }
  },
  UIS7MainController = {
    uiPrefab = "UIS7MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = SeasonCriAudio.BGMMapS7
    }
  },
  UIS7HelperController = {
    uiPrefab = "UIS7HelperController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UISeasonLevelStageS7 = {
    uiPrefab = "UISeasonLevelStageS7.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonActionPointTipS7 = {
    uiPrefab = "UISeasonActionPointTipS7.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonBuffLevelUpS7 = {
    uiPrefab = "UISeasonBuffLevelUpS7.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISetParamOnShowComponent = {
        [UIComponentParamType.KeepVoice] = true
      },
      UISimpleTransitionComponent = {}
    }
  },
  UISeasonBuffMainInfoS7 = {
    uiPrefab = "UISeasonBuffMainInfoS7.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UISeasonBuffMainTipsS7 = {
    uiPrefab = "UISeasonBuffMainTipsS7.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISeasonShowAwardsS7 = {
    uiPrefab = "UISeasonShowAwardsS7.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UISeasonShowNormalAwardS7 = {
    uiPrefab = "UISeasonShowNormalAwardS7.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UISeasonMainS8 = {
    uiPrefab = "UISeasonMainS8.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = SeasonCriAudio.BGMMapS8
    }
  },
  UIS8MainController = {
    uiPrefab = "UIS8MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = SeasonCriAudio.BGMMapS8
    }
  },
  UIS8HelperController = {
    uiPrefab = "UIS8HelperController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UISeasonLevelStageS8 = {
    uiPrefab = "UISeasonLevelStageS8.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonActionPointTipS8 = {
    uiPrefab = "UISeasonActionPointTipS8.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonBuffLevelUpS8 = {
    uiPrefab = "UISeasonBuffLevelUpS8.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISetParamOnShowComponent = {
        [UIComponentParamType.KeepVoice] = true
      },
      UISimpleTransitionComponent = {}
    }
  },
  UISeasonBuffMainInfoS8 = {
    uiPrefab = "UISeasonBuffMainInfoS8.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UISeasonBuffMainTipsS8 = {
    uiPrefab = "UISeasonBuffMainTipsS8.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISeasonShowAwardsS8 = {
    uiPrefab = "UISeasonShowAwardsS8.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UISeasonShowNormalAwardS8 = {
    uiPrefab = "UISeasonShowNormalAwardS8.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UIActivityCN6N35MainController = {
    uiPrefab = "UIActivityCN6N35MainController.prefab",
    maskType = MaskType.MT_None
  },
  UIActivityCN6N35Shop = {
    uiPrefab = "UIActivityCN6N35Shop.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMCN6N35
    }
  },
  UICN6N35Hard = {
    uiPrefab = "UICN6N35Hard.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMCN6N35
    }
  },
  UICN6N35Line = {
    uiPrefab = "UICN6N35Line.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMCN6N35
    }
  },
  UIActivityCN6N35HardLevelMain = {
    uiPrefab = "UIActivityCN6N35HardLevelMain.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMCN6N35
    }
  },
  UI_CN6_N35_GameGetClothes = {
    uiPrefab = "UI_CN6_N35_GameGetClothes.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UI_CN6_N35_GameController = {
    uiPrefab = "UI_CN6_N35_GameController.prefab",
    maskType = MaskType.MT_None
  },
  UIDiscoveryGiftController = {
    uiPrefab = "UIDiscoveryGiftController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UICN7N36MainController = {
    uiPrefab = "UICN7N36MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMCN7N36
    }
  },
  UICN7N36TotalLoginAwardController = {
    uiPrefab = "UICN7N36TotalLoginAwardController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMCN7N36
    }
  },
  UICN7N36ShopController = {
    uiPrefab = "UICN7N36ShopController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMCN7N36
    }
  },
  UICN7N36Line = {
    uiPrefab = "UICN7N36Line.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMCN7N36
    }
  },
  UICN7N36IntroController = {
    uiPrefab = "UICN7N36IntroController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {},
      UISwitchBGMComponent = CriAudioIDConst.BGMCN7N36
    }
  },
  UICampaignCenterDanTangPreAwards = {
    uiPrefab = "UICampaignCenterDanTangPreAwards.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UICampaignCenterDanTangIntro = {
    uiPrefab = "UICampaignCenterDanTangIntro.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UICampaignCenterDanTangShare = {
    uiPrefab = "UICampaignCenterDanTangShare.prefab",
    maskTyp = MaskType.MT_None
  },
  UIXiaoLinJiaStoryController = {
    uiPrefab = "UIXiaoLinJiaStoryController.prefab",
    maskType = MaskType.MT_None
  },
  UIXiaoLinJiaMainController = {
    uiPrefab = "UIXiaoLinJiaMainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMMiniGame
    }
  },
  UIXiaoLinJiaCollectionController = {
    uiPrefab = "UIXiaoLinJiaCollectionController.prefab",
    maskType = MaskType.MT_None
  },
  UIXiaoLinJiaQuestionDBController = {
    uiPrefab = "UIXiaoLinJiaQuestionDBController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIXiaoLinJiaReview = {
    uiPrefab = "UIXiaoLinJiaReview.prefab",
    maskType = MaskType.MT_None
  },
  UIXiaoLinJiaIntroController = {
    uiPrefab = "UIXiaoLinJiaIntroController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIXiaoLinJiaRewardController = {
    uiPrefab = "UIXiaoLinJiaRewardController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIXiaoLinJiaGetCollectionController = {
    uiPrefab = "UIXiaoLinJiaGetCollectionController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UICN7N36ShopTipsController = {
    uiPrefab = "UICN7N36ShopTipsController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMCN7N36
    }
  },
  UICN7N36PostInnerGameController = {
    uiPrefab = "UICN7N36PostInnerGameController.prefab",
    maskType = MaskType.MT_None
  },
  UICN7N36PostGameClosingController = {
    uiPrefab = "UICN7N36PostGameClosingController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIFavourPetVote2Confirm = {
    uiPrefab = "UIFavourPetVote2Confirm.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIFavourPetVote2Detail = {
    uiPrefab = "UIFavourPetVote2Detail.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UICN7N36PostGameClosingTipsController = {
    uiPrefab = "UICN7N36PostGameClosingTipsController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIFavourPetQuestController = {
    uiPrefab = "UIFavourPetQuestController.prefab",
    maskType = MaskType.MT_None
  },
  UICommonConversionController = {
    uiPrefab = "UICommonConversionController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {},
      UISetParamOnShowComponent = {
        [UIComponentParamType.KeepVoice] = true
      }
    }
  },
  UIN37MainController = {
    uiPrefab = "UIN37MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN37
    }
  },
  UIN37LineMissionController = {
    uiPrefab = "UIN37LineMissionController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN37
    }
  },
  UIN37HardLevelMain = {
    uiPrefab = "UIN37HardLevelMain.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN37
    }
  },
  UIN37ExchangeController = {
    uiPrefab = "UIN37ExchangeController.prefab",
    maskType = MaskType.MT_None
  },
  UIBattleStatistics = {
    uiPrefab = "UIBattleStatistics.prefab",
    maskType = MaskType.MT_None
  },
  UIN38MainController = {
    uiPrefab = "UIN38MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN38
    }
  },
  UIN38Line = {
    uiPrefab = "UIN38Line.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN38
    }
  },
  UIN38HardLevel = {
    uiPrefab = "UIN38HardLevel.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN38
    }
  },
  UIN38Shop = {
    uiPrefab = "UIN38Shop.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonBackpack = {
    uiPrefab = "UISeasonBackpack.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonBackpackInfo = {
    uiPrefab = "UISeasonBackpackInfo.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivitySouthSeaCN9MainController = {
    uiPrefab = "UIActivitySouthSeaCN9MainController.prefab",
    maskType = MaskType.MT_None
  },
  UICN9MainGameController = {
    uiPrefab = "UICN9MainGameController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.SoundCN9Mie_BGM
    }
  },
  UIActivityCN9BookMain = {
    uiPrefab = "UIActivityCN9BookMain.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityCN9BookDetailPop = {
    uiPrefab = "UIActivityCN9BookDetailPop.prefab",
    maskType = MaskType.MT_None
  },
  UIActivityCN9LevelDetail = {
    uiPrefab = "UIActivityCN9LevelDetail.prefab",
    maskType = MaskType.MT_None
  },
  UIShopSailingAwardsView = {
    uiPrefab = "UIShopSailingAwardsView.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIShopSailingBuyTips = {
    uiPrefab = "UIShopSailingBuyTips.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIN39MainController = {
    uiPrefab = "UIN39MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN39
    }
  },
  UIN39LineMissionController = {
    uiPrefab = "UIN39LineMissionController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {},
      UISwitchBGMComponent = CriAudioIDConst.BGMN39
    }
  },
  UIN39ExchangeController = {
    uiPrefab = "UIN39ExchangeController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN39
    }
  },
  UIN39HardLevelMain = {
    uiPrefab = "UIN39HardLevelMain.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN39
    }
  },
  UIN39Intro = {
    uiPrefab = "UIN39Intro.prefab",
    maskType = MaskType.MT_None
  },
  UINExploreMainController = {
    uiPrefab = "UINExploreMainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN40
    }
  },
  UIN43MainController = {
    uiPrefab = "UIN43MainController.prefab",
    maskType = MaskType.MT_None
  },
  UICampaignTalentInnerInfo = {
    uiPrefab = "UICampaignTalentInnerInfo.prefab",
    maskType = MaskType.MT_None
  },
  UICN12N41MainController = {
    uiPrefab = "UICN12N41MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMCN12N41
    }
  },
  UICN12N41LineController = {
    uiPrefab = "UICN12N41LineController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMCN12N41
    }
  },
  UICN12N41HardController = {
    uiPrefab = "UICN12N41HardController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {},
      UISwitchBGMComponent = CriAudioIDConst.BGMCN12N41
    }
  },
  UIActivityNewYearLuckBagController = {
    uiPrefab = "UIActivityNewYearLuckBagController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UIActivityNewYearLuckBagAnimController = {
    uiPrefab = "UIActivityNewYearLuckBagAnimController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UILevelTestController = {
    uiPrefab = "UILevelTestController.prefab",
    maskType = MaskType.MT_None
  },
  UIEachTestController = {
    uiPrefab = "UIEachTestController.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonTalentLineMission = {
    uiPrefab = "UISeasonTalentLineMission.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonTalentLineStage = {
    uiPrefab = "UISeasonTalentLineStage.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonTalentTreeController = {
    uiPrefab = "UISeasonTalentTree.prefab",
    maskType = MaskType.MT_None
  },
  UICampaignTalentInnerInfo = {
    uiPrefab = "UICampaignTalentInnerInfo.prefab",
    maskType = MaskType.MT_None
  },
  UILuckLandMainGameController = {
    uiPrefab = "UILuckLandMainGameController.prefab",
    hideUnderLayer = HideUnderLayerType.Auto_Hide,
    maskType = MaskType.MT_BlurMask
  },
  UILuckLandGameEndPopUp = {
    uiPrefab = "UILuckLandGameEndPopUp.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UILuckLandResCalcuPopUp = {
    uiPrefab = "UILuckLandResCalcuPopUp.prefab",
    maskType = MaskType.MT_None
  },
  UILuckLandPetAtkPopUp = {
    uiPrefab = "UILuckLandPetAtkPopUp.prefab",
    maskType = MaskType.MT_None
  },
  UILuckLandGameSucPopUp = {
    uiPrefab = "UILuckLandGameSucPopUp.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UILuckLandSelectCardPopUp = {
    uiPrefab = "UILuckLandSelectCardPopUp.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UILuckLandCardDetailPopUp = {
    uiPrefab = "UILuckLandCardDetailPopUp.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UILuckLandLevel = {
    uiPrefab = "UILuckLandLevel.prefab",
    maskType = MaskType.MT_None
  },
  UILuckLandLevelInfo = {
    uiPrefab = "UILuckLandLevelInfo.prefab",
    maskType = MaskType.MT_None
  },
  UILuckLandRank = {
    uiPrefab = "UILuckLandRank.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UILuckLandCardBag = {
    uiPrefab = "UILuckLandCardBag.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UILuckLandBuildings = {
    uiPrefab = "UILuckLandBuildings.prefab",
    maskType = MaskType.MT_None
  },
  UILuckLandBuildingLevelUp = {
    uiPrefab = "UILuckLandBuildingLevelUp.prefab",
    maskType = MaskType.MT_None
  },
  UICollectCardAwardView = {
    uiPrefab = "UICollectCardAwardView.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UICollectCardPop = {
    uiPrefab = "UICollectCardPop.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UICollectCardSend = {
    uiPrefab = "UICollectCardSend.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UICollectCardInfo = {
    uiPrefab = "UICollectCardInfo.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UICollectCardOpen = {
    uiPrefab = "UICollectCardOpen.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UICollectCardIntr = {
    uiPrefab = "UICollectCardIntr.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UICollectCardReceive = {
    uiPrefab = "UICollectCardReceive.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UICollectCardShare = {
    uiPrefab = "UICollectCardShare.prefab",
    maskTyp = MaskType.MT_None
  },
  UIFeatureAutoBeadInfo = {
    uiPrefab = "UIFeatureAutoBeadInfo.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UICN14N43FrogGameGuide = {
    uiPrefab = "UICN14N43FrogGameGuide.prefab",
    maskType = MaskType.MT_None
  },
  UICN14N43FrogCollect = {
    uiPrefab = "UICN14N43FrogCollect.prefab",
    maskType = MaskType.MT_None
  },
  UICN14N43FrogIntro = {
    uiPrefab = "UICN14N43FrogIntro.prefab",
    maskType = MaskType.MT_None
  },
  UICN16N45SeaNoteEnter = {
    uiPrefab = "UICN16N45SeaNoteEnter.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UICN16N45SeaNoteLevelDetail = {
    uiPrefab = "UICN16N45SeaNoteLevelDetail.prefab",
    maskType = MaskType.MT_None
  },
  UICN16N45SeaNoteMainGameController = {
    uiPrefab = "UICN16N45SeaNoteMainGameController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.SoundCN9Mie_BGM
    }
  },
  UICN16N45SeaNoteRankingList = {
    uiPrefab = "UICN16N45SeaNoteRankingList.prefab",
    maskType = MaskType.MT_None
  },
  UIActivityAlice = {
    uiPrefab = "UIActivityAlice.prefab",
    maskType = MaskType.MT_None
  },
  UICommonLineMission = {
    uiPrefab = "UICommonLineMissionN22.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN23
    }
  },
  UICommonLineMissionAwards = {
    uiPrefab = "UICommonLineMissionAwards.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISimpleTransitionComponent = {fadeBlurMask = true}
    }
  },
  UICommonLineMissionIntro = {
    uiPrefab = "UICommonLineMissionIntroN22.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UICommonLineMissionN19 = {
    uiPrefab = "UICommonLineMissionN19.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN19
    }
  },
  UISendPetQuest = {
    uiPrefab = "UISendPetQuest.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMazeScene = {
    uiPrefab = "UISeasonMazeScene.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = SeasonCriAudio.BGMMapS5
    }
  },
  UISeasonMazeBead = {
    uiPrefab = "UISeasonMazeBead.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISeasonMazeBeadIntro = {
    uiPrefab = "UISeasonMazeBeadIntro.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMazeBeadAutoSyn = {
    uiPrefab = "UISeasonMazeBeadAutoSyn.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISeasonMazeBeadRewards = {
    uiPrefab = "UISeasonMazeBeadRewards.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISimpleTransitionComponent = {}
    }
  },
  UISeasonMazeRoomEmpty = {
    uiPrefab = "UISeasonMazeRoomEmpty.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMazeRoomBox = {
    uiPrefab = "UISeasonMazeRoomBox.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISeasonMazeRoomFlea = {
    uiPrefab = "UISeasonMazeRoomFlea.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISeasonMazeRoomFleaBeadBag = {
    uiPrefab = "UISeasonMazeRoomFleaBeadBag.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISeasonMazeRoomRound = {
    uiPrefab = "UISeasonMazeRoomRound.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMaze_Campsites_BuyTicket = {
    uiPrefab = "UISeasonMaze_Campsites_BuyTicket.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMaze_Campsites_Bank = {
    uiPrefab = "UISeasonMaze_Campsites_Bank.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISeasonMazeRoom_Campsites = {
    uiPrefab = "UISeasonMazeRoom_Campsites.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMazeRoom_Altar = {
    uiPrefab = "UISeasonMazeRoom_Altar.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISeasonMazeUpLv = {
    uiPrefab = "UISeasonMazeUpLv.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UISeasonMazeMsgBox = {
    uiPrefab = "UISeasonMazeMsgBox.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UISeasonMazeLvInfo = {
    uiPrefab = "UISeasonMazeLvInfo.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UISeasonMaze_Campsites_Smithy = {
    uiPrefab = "UISeasonMaze_Campsites_Smithy.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISeasonMaze_Campsites_Recruit = {
    uiPrefab = "UISeasonMaze_Campsites_Recruit.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMaze_Campsites_Medical = {
    uiPrefab = "UISeasonMaze_Campsites_Medical.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMazeRoomStage = {
    uiPrefab = "UISeasonMazeRoomStage.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISeasonMazeRoomMining = {
    uiPrefab = "UISeasonMazeRoomMining.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISeasonMazeRoomResources = {
    uiPrefab = "UISeasonMazeRoomResources.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMazeRoomRandomEvent = {
    uiPrefab = "UISeasonMazeRoomRandomEvent.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMazeRoomPopBox = {
    uiPrefab = "UISeasonMazeRoomPopBox.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMazeBackPackController = {
    uiPrefab = "UISeasonMazeBackPackController.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMazeRelicInfoController = {
    uiPrefab = "UISeasonMazeRelicInfoController.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMazeActionCardInfoController = {
    uiPrefab = "UISeasonMazeActionCardInfoController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISeasonMazeWorldBossDetailPopUp = {
    uiPrefab = "UISeasonMazeWorldBossDetailPopUp.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMazeWorldBossTipsPopUp = {
    uiPrefab = "UISeasonMazeWorldBossTipsPopUp.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISeasonMazeWorldBossRankingList = {
    uiPrefab = "UISeasonMazeWorldBossRankingList.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMazeEnterController = {
    uiPrefab = "UISeasonMazeEnterController.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMazeSelectRelicPopUp = {
    uiPrefab = "UISeasonMazeSelectRelicPopUp.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMazeSelectDifficultyPopup = {
    uiPrefab = "UISeasonMazeSelectDifficultyPopup.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMazeWorldBossSelectPopUp = {
    uiPrefab = "UISeasonMazeWorldBossSelectPopUp.prefab",
    maskType = MaskType.MT_None
  },
  UISMazeS1HelperController = {
    uiPrefab = "UISMazeS1HelperController.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMazePetsTeams = {
    uiPrefab = "UISeasonMazePetsTeams.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMazeTeamChangeController = {
    uiPrefab = "UISeasonMazeTeamChangeController.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMazePetsTeamsPrimary = {
    uiPrefab = "UISeasonMazePetsTeams.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMaze_Campsites_Life = {
    uiPrefab = "UISeasonMaze_Campsites_Life.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMaze_Campsites_Life_Select = {
    uiPrefab = "UISeasonMaze_Campsites_Life_Select.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMazeTeamChangeControllerPrimary = {
    uiPrefab = "UISeasonMazeTeamChangeController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISeasonMaze_Campsites_SmithyBuyRelic = {
    uiPrefab = "UISeasonMaze_Campsites_SmithyBuyRelic.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISeasonMaze_RelicHrefInfo = {
    uiPrefab = "UISeasonMaze_RelicHrefInfo.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMaze_Campsites_SmithyBuyItem = {
    uiPrefab = "UISeasonMaze_Campsites_SmithyBuyItem.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISeasonMazeCompleteResult = {
    uiPrefab = "UISeasonMazeCompleteResult.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMazeScoreTask = {
    uiPrefab = "UISeasonMazeScoreTask.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMazePickCard = {
    uiPrefab = "UISeasonMazePickCard.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMazeChooseMaxPet = {
    uiPrefab = "UISeasonMazeChooseMaxPet.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISeasonMazeCollage = {
    uiPrefab = "UISeasonMazeCollage.prefab",
    maskType = MaskType.MT_None
  },
  UIFeatureAutoBeadInfo = {
    uiPrefab = "UIFeatureAutoBeadInfo.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISeasonMazeBossAtkTip = {
    uiPrefab = "UISeasonMazeBossAtkTip.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMazeCardDecide = {
    uiPrefab = "UISeasonMazeCardDecide.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UITopTipsControllerSMaze = {
    uiPrefab = "UITopTipsControllerSMaze.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMazeRelicRdmCard = {
    uiPrefab = "UISeasonMazeRelicRdmCard.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UISeasonMazeRoom_DirectionalRecruit = {
    uiPrefab = "UISeasonMazeRoomDirectionalRecruit.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISeasonMazeBanPetController = {
    uiPrefab = "UISeasonMazeBanPetController.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMazeBanPetChangeController = {
    uiPrefab = "UISeasonMazeBanPetChangeController.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMazeRelicRewards = {
    uiPrefab = "UISeasonMazeRelicRewards.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISeasonMazePetRewards = {
    uiPrefab = "UISeasonMazePetRewards.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISeasonMazeRoomShop = {
    uiPrefab = "UISeasonMazeRoomShop.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMazeRoomBead = {
    uiPrefab = "UISeasonMazeRoomBead.prefab",
    maskType = MaskType.MT_None
  },
  UISeasonMazeRoomBeadBuy = {
    uiPrefab = "UISeasonMazeRoomBeadBuy.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UICN16N45MainController = {
    uiPrefab = "UICN16N45MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMEnterHomeland
    }
  },
  UICN16N45LineController = {
    uiPrefab = "UICN16N45LineController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMEnterHomeland
    }
  },
  UICN16N45HardLevel = {
    uiPrefab = "UICN16N45HardLevel.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMEnterHomeland
    }
  },
  UICN17N46FishingGameStageController = {
    uiPrefab = "UICN17N46FishingGameStageController.prefab",
    maskType = MaskType.MT_BlurMask,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMN13Build
    }
  },
  UICN17N46FishingGameController = {
    uiPrefab = "UICN17N46FishingGameController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMMiniGame
    }
  },
  UICN17N46FishingGameRankingList = {
    uiPrefab = "UICN17N46FishingGameRankingList.prefab",
    maskType = MaskType.MT_None
  },
  UIActivityCN13PerfectPuzzleEntryController = {
    uiPrefab = "UIActivityCN13PerfectPuzzleEntryController.prefab",
    maskType = MaskType.MT_None
  },
  UICN13PerfectPuzzleMainGameController = {
    uiPrefab = "UICN13PerfectPuzzleMainGameController.prefab",
    maskType = MaskType.MT_None
  },
  UICN13GetPiecePopUp = {
    uiPrefab = "UICN13GetPiecePopUp.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UICN13PuzzlePlanPopUp = {
    uiPrefab = "UICN13PuzzlePlanPopUp.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityN4CCLevelDetailController = {
    uiPrefab = "UIActivityN4CCLevelDetailController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIActivityN4LevelEffController = {
    uiPrefab = "UIActivityN4LevelEffController.prefab",
    maskType = MaskType.MT_None
  },
  UIActivityN4CCAffixDetail = {
    uiPrefab = "UIActivityN4CCAffixDetail.prefab",
    maskType = MaskType.MT_None
  },
  UIActivityN4CCAffixSelectController = {
    uiPrefab = "UIActivityN4CCAffixSelectController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UIN4CCTaskController = {
    uiPrefab = "UIN4CCTaskController.prefab",
    maskType = MaskType.MT_None
  },
  UICN17N46MainController = {
    uiPrefab = "UICN17N46MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.N28BounceFightBgm
    }
  },
  UICN17N46LineController = {
    uiPrefab = "UICN17N46LineController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.N28BounceFightBgm
    }
  },
  UICN17N46HardLevel = {
    uiPrefab = "UICN17N46HardLevel.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.N28BounceFightBgm
    }
  },
  UIFeatureTetrisInfo = {
    uiPrefab = "UIFeatureTetrisInfo.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UICN18N47MainController = {
    uiPrefab = "UICN18N47MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGM_CN18_N47
    }
  },
  UICN18N47LineController = {
    uiPrefab = "UICN18N47LineController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGM_CN18_N47
    }
  },
  UICN18N47HardLevel = {
    uiPrefab = "UICN18N47HardLevel.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGM_CN18_N47
    }
  },
  UIN48MainController = {
    uiPrefab = "UIN48MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGM_N48
    }
  },
  UIN48LineMissionController = {
    uiPrefab = "UIN48LineMissionController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGM_N48
    }
  },
  UIN48HardController = {
    uiPrefab = "UIN48HardController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGM_N48
    }
  },
  UIN48IntroController = {
    uiPrefab = "UIN48IntroController.prefab",
    maskType = MaskType.MT_None
  },
  UICN19N48MiniGameStageController = {
    uiPrefab = "UICN19N48MiniGameStageController.prefab",
    maskType = MaskType.MT_None
  },
  UICN19N48MiniGameController = {
    uiPrefab = "UICN19N48MiniGameController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMMiniGame
    }
  },
  UICN19N48MiniGameHelp = {
    uiPrefab = "UICN19N48MiniGameHelp.prefab",
    maskType = MaskType.MT_None
  },
  UICN20N49LineTalentController = {
    uiPrefab = "UICN20N49LineTalentController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMHauteCoutureGL
    }
  },
  UICN20N49MainController = {
    uiPrefab = "UICN20N49MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMHauteCoutureGL
    }
  },
  UICN20N49LineController = {
    uiPrefab = "UICN20N49LineController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMHauteCoutureGL
    }
  },
  UICN20N49TreeController = {
    uiPrefab = "UICN20N49TreeController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMHauteCoutureGL
    }
  },
  UICN20N49ActionPointDetail = {
    uiPrefab = "UICN20N49ActionPointDetail.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {}
  },
  UICN20N49LineTalentStage = {
    uiPrefab = "UICN20N49LineTalentStage.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UICN20N49SweepConditionTips = {
    uiPrefab = "UICN20N49SweepConditionTips.prefab",
    maskType = MaskType.MT_LessBlackMask
  },
  UICN20AlchemyMainController = {
    uiPrefab = "UICN20AlchemyMainController.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UICN20AlchemyIntro = {
    uiPrefab = "UICN20AlchemyIntro.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UICN20N49Ryza_Shop = {
    uiPrefab = "UICN20N49Ryza_Shop.prefab",
    maskType = MaskType.MT_None
  },
  UICN20N49Ryza_ShopList = {
    uiPrefab = "UICN20N49Ryza_ShopList.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UITransitionComponent = {}
    }
  },
  UICN20N49Ryza_ShopSell = {
    uiPrefab = "UICN20N49Ryza_ShopSell.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UICN20N49Ryza_ShopWarning = {
    uiPrefab = "UICN20N49Ryza_ShopWarning.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UICN20N49AlchemyShopLevelUP = {
    uiPrefab = "UICN20N49AlchemyShopLevelUP.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UICN20N49AlchemyShopLevelUPComplete = {
    uiPrefab = "UICN20N49AlchemyShopLevelUPComplete.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UICN20N49AlchemyShopRevenueLevelUpInfo = {
    uiPrefab = "UICN20N49AlchemyShopRevenueLevelUpInfo.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UICN21N50MainController = {
    uiPrefab = "UICN21N50MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGM_CN21_N50
    }
  },
  UICN21N50LineController = {
    uiPrefab = "UICN21N50LineController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGM_CN21_N50
    }
  },
  UICN21N50HardLevel = {
    uiPrefab = "UICN21N50HardLevel.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGM_CN21_N50
    }
  },
  UICN22N51MainController = {
    uiPrefab = "UICN22N51MainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGM_CN22_N51
    }
  },
  UICN22N51LineController = {
    uiPrefab = "UICN22N51LineController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGM_CN22_N51
    }
  },
  UICN22N51HardLevel = {
    uiPrefab = "UICN22N51HardLevel.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGM_CN22_N51
    }
  },
  UIFLTTMainController = {
    uiPrefab = "UIFLTTMainController.prefab",
    maskType = MaskType.MT_None,
    uiComponents = {
      UISwitchBGMComponent = CriAudioIDConst.BGMCN6N35
    }
  },
  UISaveQRTipNew = {
    uiPrefab = "UISaveQRTipNew.prefab",
    maskType = MaskType.MT_BlurMask
  },
  UISaveQRDetail = {
    uiPrefab = "UISaveQRDetail.prefab",
    maskType = MaskType.MT_None
  }
}
