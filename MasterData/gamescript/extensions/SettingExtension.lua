local SettingExtension = {}
SettingExtension = {
  FreeTrial = {
    models = {
      "FreeTrialModel"
    },
    controllers = {
      "FreeTrialController"
    },
    views = {
      "FreeTrialView"
    }
  },
  login = {
    models = {
      "LoginCharacterCreateModel",
      "LoginServerSelectModel"
    },
    controllers = {
      "LoginCharacterCreateController",
      "LoginServerSelectController"
    },
    views = {
      "LoginSetGenderView",
      "LoginSetNameView",
      "LoginServerSelectView"
    }
  },
  mail = {
    models = {"MailModel"},
    controllers = {
      "MailController"
    },
    views = {
      "MailView",
      "TreasureMailView"
    }
  },
  ArtCollection = {
    models = {
      "ArtCollectionModel",
      "ArtCollectionRewardModel"
    },
    controllers = {
      "ArtCollectionController"
    },
    views = {
      "ArtCollectionView",
      "ArtCollectionStoryView",
      "ArtCollectionCGView",
      "ArtCollectionOSTView",
      "OrganizationListView",
      "OrganizationDetailView",
      "CommonConceptView",
      "MainCGView",
      "CGBaseView",
      "SceneCGView",
      "CollectionActivityView",
      "ArtCollectionRewardView",
      "ArtCollectionLoginPVModifyView"
    }
  },
  task = {
    models = {
      "TaskModel",
      "TaskParentChildModel",
      "TaskHomeAchievementModel",
      "TaskDispatchModel"
    },
    controllers = {
      "TaskController",
      "TaskDispatchController"
    },
    views = {
      "TaskMainView",
      "TaskCareerView",
      "TaskSchoolView",
      "TaskHomeAchievementView",
      "TaskPlayerLevelView",
      "TaskDispatchView",
      "TaskDispatchAppointComp"
    }
  },
  bp = {
    models = {
      "BpModel",
      "BpTaskModel",
      "BpWeaponModel",
      "BpRewardModel",
      "BpExchangeLevelModel",
      "BpRechargeModel"
    },
    controllers = {
      "BpController"
    },
    views = {
      "BpMainView",
      "BpRechargeView",
      "BpReviewView",
      "BpRewardView",
      "BpTaskView",
      "BpWeaponView",
      "BpExchangeLevelView"
    }
  },
  guideNote = {
    models = {
      "GuideNoteModel"
    },
    controllers = {
      "GuideNoteController"
    },
    views = {
      "GuideNoteMainView",
      "GuideNoteTaskView",
      "GuideNoteDailyTaskView",
      "GuideNoteWeeklyTaskView",
      "GuideNoteAwakerStrengthView",
      "GuideNotePermTrainingView"
    }
  },
  stageInitialState = {
    models = {
      "StageInitialStateModel"
    },
    views = {
      "StageInitialStateDetailView"
    }
  },
  bag = {
    models = {
      "BagExtModel",
      "BagItemDetailsModel",
      "TrinketSortingModel"
    },
    controllers = {
      "BagController",
      "TrinketFilterController"
    },
    views = {"BagView"}
  },
  teamBuilding = {
    models = {
      "TeamTrinketModel",
      "TeamWeaponModel"
    },
    controllers = {
      "TeamTrinketControllers"
    },
    views = {
      "TeamWeaponEquipView",
      "TeamTrinketEquipView",
      "TrinketGroupDetailTipsView"
    }
  },
  trinkets = {
    models = {
      "TrinketModel",
      "AwakerTrinketExtModel",
      "EditTrinketSuitPlanModel",
      "TrinketBindModel"
    },
    controllers = {
      "AwakerTrinketController",
      "TrinketPlanEditController"
    },
    views = {
      "TrinketEquipedView",
      "TrinketSuitPlaneSavedView",
      "TrinketPlanEditView",
      "TrinketAutoRefineSuccessView",
      "TrinketAwakerBindView",
      "TrinketAwakerUnBindView",
      "TrinketBindConfirmView"
    }
  },
  weapons = {
    models = {
      "AwakerWeaponExtModel"
    },
    controllers = {
      "AwakerWeaponController"
    },
    views = {}
  },
  Emoji = {
    models = {"EmojiModel"},
    controllers = {
      "EmojiController"
    },
    views = {
      "EmojiView",
      "EmojiShowView"
    }
  },
  awakerTalent = {
    models = {
      "AwakerTalentExtModel"
    },
    controllers = {
      "AwakerTalentController"
    },
    views = {
      "AwakerPopupExchangeTipView"
    }
  },
  copy = {
    models = {
      "CopyExtModel",
      "CopyMainModel",
      "CopySubplotGroupModel",
      "CopySettleModel",
      "CopyVindicateModel",
      "CopyStageDetailModel",
      "CopyStoryGuideModel"
    },
    controllers = {
      "CopyController",
      "CopyStageDetailController"
    },
    views = {
      "CopyMainView",
      "CopyMainChapterView",
      "CopyLargeBranchView",
      "CopySmallBranchView",
      "SubplotGroupView",
      "CopySettleBaseView",
      "CopyVindicateView",
      "CopyAbyssSettleView",
      "CopyStageDetailView",
      "CopyStageAchievementView",
      "CopyRelicStrengthView",
      "SubplotAvgReviewView",
      "CopySpecialBranchView",
      "CopyStoryGuideView"
    }
  },
  copyReview = {
    models = {
      "CopyRecordsModel"
    },
    controllers = {
      "CopyRecordsController"
    },
    views = {}
  },
  activity = {
    models = {
      "ActivityDrawPrizeModel",
      "BonusCardModel"
    },
    controllers = {
      "ActivityDrawPrizeController",
      "ActivityController"
    },
    views = {
      "ActivityDrawPrizePoolView",
      "ActivityDrawPrizeMainView",
      "ActivityDrawPrizeResultView"
    }
  },
  donationbox = {
    models = {
      "DonationBoxModel"
    },
    controllers = {
      "DonationBoxController"
    },
    views = {
      "DonationBoxView"
    }
  },
  shop = {
    models = {
      "ShopExtModel",
      "DiamondShopModel",
      "ShopOneKeyPurchaseModel"
    },
    controllers = {
      "ShopController"
    },
    views = {
      "ShopViewBase",
      "ActivityShopView",
      "MainShopView",
      "DiamondShopView",
      "ShopOneKeyPurchaseView"
    }
  },
  alchemy = {
    models = {
      "AlchemyMainExtModel",
      "AlchemyExchangeExtModel",
      "AlchemyDecomposeBaseExtModel",
      "AlchemyCompositeExtModel",
      "AlchemyDecomposeTrinketExtModel",
      "AlchemyDecomposeWeaponExtModel",
      "AlchemyDecomposeItemExtModel"
    },
    controllers = {
      "AlchemyController"
    },
    views = {
      "AlchemyMainView",
      "AlchemyExchangeView",
      "AlchemyExchangeItemBagView",
      "AlchemyExchangeConfirmView",
      "AlchemyDecomposeBaseView",
      "AlchemyDecomposeConfirmView",
      "AlchemyCompositeView",
      "AlchemyCompositeConfirmView",
      "AlchemyDecomposeWeaponView",
      "AlchemyDecomposeTrinketView",
      "AlchemyDecomposeItemView"
    }
  },
  awaker = {
    models = {
      "AwakerVoiceModel",
      "AwakerSelectShowingModel"
    },
    controllers = {
      "AwakerVoiceController",
      "AwakerSelectShowingController"
    },
    views = {
      "AwakerPaintingView",
      "AwakerSelectShowingView"
    }
  },
  social = {
    models = {
      "SocialExtModel"
    },
    controllers = {
      "SocialController"
    },
    views = {
      "SocialRankView",
      "SocialAwakerChooseView"
    }
  },
  dungeons = {
    models = {
      "DungeonMainModel",
      "DungeonMaterialModel",
      "AbyssExtModel",
      "AbyssExtChallengeModel",
      "DailyChallengeModel",
      "SchoolTowerModel",
      "AssistFilterModel",
      "DungeonTaskDataModel"
    },
    controllers = {
      "DungeonMaterialController",
      "AbyssController",
      "DailyChallengeController",
      "SchoolTowerController"
    },
    views = {
      "DungeonsMainView",
      "DungeonMaterialView",
      "DungeonMaterailSubView",
      "DungeonsTrinketView",
      "DungeonMaterialCell",
      "AssistFilterListView",
      "DungeonBattleTeachingView",
      "AbyssView",
      "AbyssProgressRewardView",
      "AbyssChallengeView",
      "AbyssPassRecordView",
      "AbyssRankView",
      "DailyChallengeDifficultyView",
      "DailyChallengeView",
      "DailyWeekAchieveRewardView",
      "DailyWeekRewardView",
      "SchoolTowerView",
      "SchoolTowerDetailView",
      "UICompCustomDiff",
      "DungeonStatisticsView",
      "CopyBattleStatisticsView"
    }
  },
  awakerFilter = {
    models = {
      "AwakerFilterListModel"
    },
    controllers = {
      "AwakerFilterListController"
    },
    views = {
      "AwakerFilterListView"
    }
  },
  weekBoos = {
    models = {
      "WeekBossExtModel"
    },
    controllers = {
      "WeekBossController"
    },
    views = {
      "WeekBossView"
    }
  },
  storyReview = {
    models = {
      "StoryReviewModel"
    },
    controllers = {
      "StoryReviewController"
    }
  },
  public = {
    models = {
      "ItemUseSelectModel"
    },
    controllers = {
      "PublicUIController"
    },
    views = {
      "PropertiesTipsView",
      "AgeVerificationView",
      "RebirthChargeView",
      "PopAchievementTipsView",
      "InvestigatorLevelUpView",
      "CommonillustrateView",
      "PvpillustrateView",
      "ReqMaskView",
      "KeyMaskView",
      "ActiveSuccessView",
      "MarqueeView",
      "ItemUseSelectView",
      "FeatureUnlockView",
      "CommonCardKeyWorldDescView",
      "SimpleListView",
      "TimelineVideoUIAddView"
    }
  },
  pvpReplay = {
    models = {
      "PvpReplayDataModel"
    },
    controllers = {
      "PvpReplayController"
    },
    views = {
      "PvpReplayDataDetailView"
    }
  },
  pvpPassword = {
    models = {
      "PvpPasswordModel"
    },
    controllers = {
      "PvpPasswordController"
    },
    views = {
      "PvpPasswordCreateView",
      "PvpPasswordEnterView",
      "PvpPasswordJoinView",
      "PvpPasswordRoleListView",
      "PvpPasswordWaitingView"
    }
  },
  pvp = {
    models = {
      "PvpModel",
      "PvpDraftModel",
      "PvpMatchModel"
    },
    controllers = {
      "PvpController"
    },
    views = {
      "PvpDraftView"
    }
  },
  seasonRotation = {
    models = {
      "SeasonRotationModel",
      "DailyChallengeBoardEntryPanelModel"
    },
    controllers = {
      "SeasonRotationController"
    },
    views = {}
  },
  pvpCollection = {
    models = {
      "PvpCollectionModel"
    },
    controllers = {
      "PvpCollectionController"
    },
    views = {
      "PvpCollectionMainView"
    }
  },
  battle = {
    models = {
      "BattleVoiceModel"
    },
    controllers = {
      "BattleVoiceController",
      "BattleCardDisplayController"
    },
    views = {}
  },
  comment = {
    models = {
      "CommentModel"
    },
    controllers = {
      "CommentController"
    },
    views = {}
  },
  invitation = {
    models = {
      "InvitationCodeModel"
    },
    controllers = {
      "InvitationCodeController"
    },
    views = {
      "InvitationCodeView",
      "InvitationPlayerView"
    }
  },
  setting = {
    models = {
      "SettingModel"
    },
    controllers = {
      "SettingController"
    },
    views = {
      "SettingMainView",
      "SettingRedemptionCodeView",
      "SettingDropGroupView",
      "CommunityJumpView",
      "CommunityRatingTipsView",
      "GratitudeView"
    }
  },
  gm = {
    models = {"GmModel"},
    controllers = {
      "GmController"
    },
    views = {
      "GmView",
      "GmEntryView",
      "GmParamView",
      "GmParamEquipView",
      "GmAccountJsonRenameView"
    }
  },
  careerLevel = {
    models = {
      "CareerLevelModel"
    },
    controllers = {
      "CareerLevelController"
    },
    views = {}
  },
  stage = {
    models = {"StageModel"},
    controllers = {
      "StageController"
    },
    views = {}
  },
  newMap = {
    models = {"MapModel"},
    controllers = {
      "MapController"
    },
    views = {}
  },
  rank = {
    models = {"RankModel"},
    controllers = {
      "RankController"
    },
    views = {
      "RankWorldBossView"
    }
  },
  christmas = {
    models = {
      "ChristmasFreeChooseGiftModel"
    },
    controllers = {
      "ChristmasFreeChooseGiftController"
    },
    views = {
      "ChristmasFreeChooseGiftView"
    }
  },
  railWay = {
    models = {
      "RailWayModel"
    },
    controllers = {
      "RailWayController"
    },
    views = {
      "RailWayTaskView"
    }
  },
  RedDot = {
    models = {
      "RedDotModel"
    },
    controllers = {
      "RedDotController"
    },
    views = {}
  },
  NetworkProfiler = {
    models = {},
    controllers = {},
    views = {
      "NetworkProfilerView"
    }
  },
  summon = {
    models = {
      "SummonModel",
      "SummonCategorySelectModel"
    },
    controllers = {
      "SummonController",
      "SummonCategorySelectController"
    },
    views = {
      "SummonPriorityNotEnoughView"
    }
  },
  alertConfirm = {
    views = {
      "AlertConfirmView",
      "AlertConfirm2View",
      "AlertConfirm3View",
      "DailyTaskOverItemTipView",
      "ItemObtainedTipView"
    }
  },
  alertToolTips = {
    views = {
      "AlertToolTipsView",
      "AlertIconToolTipsView",
      "AlertIconToolBattleTipsView"
    }
  },
  featureBottomTips = {
    views = {
      "FeatureBottomTipsView"
    }
  },
  UIMask = {
    views = {"UIMaskView"}
  },
  popMsg = {
    views = {"PopMsgView"}
  },
  showReward = {
    views = {
      "ShowRewardView"
    }
  },
  levelUnlockRelic = {
    views = {
      "LevelUnlockRelicView"
    }
  },
  itemExpired = {
    models = {
      "ItemExpiredModel"
    },
    controllers = {
      "ItemExpiredController"
    },
    views = {
      "ItemExpiredView"
    }
  },
  replenishEnergy = {
    models = {
      "ReplenishEnergyModel"
    },
    controllers = {
      "ReplenishEnergyController"
    },
    views = {
      "ReplenishEnergyView"
    }
  },
  itemBuy = {
    views = {
      "ItemBuyView"
    }
  },
  itemDetails = {
    models = {
      "ItemDetailsModel"
    },
    controllers = {
      "ItemDetailsController"
    },
    views = {
      "ItemDetailsView"
    }
  },
  itemUse = {
    models = {
      "AwakerLevelUpItemUseAwakerModel",
      "AwakerLevelUpItemUseModel"
    },
    controllers = {
      "ItemUseController"
    },
    views = {
      "ItemUseView",
      "EnergyItemUseView",
      "AwakerLevelUpItemUseView"
    }
  },
  share = {
    controllers = {
      "ShareSummonController"
    },
    views = {
      "ShareSummonView",
      "ShareOneAwakerView",
      "ShareOneSkinView",
      "ShareOneWeaponView",
      "ShareTwoAwakerView",
      "ShareTwoWeaponView",
      "ShareAwakerAndWeaponView"
    }
  },
  Announcement = {
    models = {
      "AnnouncementModel"
    },
    controllers = {
      "AnnouncementController"
    },
    views = {
      "AnnouncementView"
    }
  },
  tutorialMain = {
    models = {
      "TutorialMainModel"
    },
    controllers = {
      "TutorialMainController"
    },
    views = {
      "TutorialMainView"
    }
  },
  tutorialSimple = {
    models = {
      "TutorialSimpleModel"
    },
    controllers = {
      "TutorialSimpleController"
    },
    views = {
      "TutorialSimpleView"
    }
  },
  tutorialPopTip = {
    models = {
      "TutorialPopTipModel"
    },
    controllers = {
      "TutorialPopTipController"
    },
    views = {
      "TutorialPopTipView"
    }
  },
  guide = {
    models = {"GuideModel"},
    controllers = {
      "GuideController"
    },
    views = {"GuideView"}
  },
  newbieGuide = {
    models = {
      "NewbieGuideModel"
    },
    controllers = {
      "NewbieGuideController"
    },
    views = {
      "NewbieGuideView",
      "NewbieGuideBattleView"
    }
  },
  FreeChoiceChest = {
    models = {
      "FreeChoiceChestDataModel"
    },
    controllers = {
      "FreeChoiceChestController"
    },
    views = {
      "FreeChoiceChestView"
    }
  },
  appearancePreview = {
    views = {
      "AppearancePreviewView"
    }
  },
  backTrack = {
    models = {
      "BackTrackSelectModel"
    },
    controllers = {
      "BackTrackController"
    },
    views = {
      "BackTrackSelectView",
      "BackTrackAwardPreviewView"
    }
  },
  KeeperSkill = {
    models = {
      "KeeperSkillModel"
    },
    controllers = {
      "KeeperSkillController"
    },
    views = {
      "KeeperSkillView",
      "KeeperSkillObtainView",
      "BattlePopupKeeperSkillTip",
      "WorldStageMainPanel"
    }
  }
}
return SettingExtension
