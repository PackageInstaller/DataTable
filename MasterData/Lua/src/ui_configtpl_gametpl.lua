local this = class("gameTpl")

function TableIsNull(tdData)
  return tdData == nil or tdData.rowOffset == 0
end

function this:ctor()
  C_I18NManager.SetLuaConfigRefreshAction(handler(self, self.changeLanguage))
end

L_Config:setLocalizationProvider(function(langKey, paras)
  return L_Lang:get(langKey, paras)
end)
local m_languageConfig = {}
local CONFIG = {
  nestcoopLevelTpl = {
    config = "nestcoop_level",
    cls = "nestcoopLevelTpl"
  },
  nestcoopDifficultShowTpl = {
    config = "nestcoop_difficult_show",
    cls = "nestcoopDifficultShowTpl"
  },
  accessoryScoreTpl = {
    config = "accessory_score",
    cls = "accessoryScoreTpl"
  },
  accessoryRecommendTpl = {
    config = "accessory_recommend",
    cls = "accessoryRecommendTpl"
  },
  accessoryRecommendRarityTpl = {
    config = "accessory_recommend_rarity",
    cls = "accessoryRecommendRarityTpl"
  },
  accessoryCustomedTpl = {
    config = "accessory_customed",
    cls = "accessoryCustomedTpl"
  },
  accessoryProductTpl = {
    config = "accessory_product",
    cls = "accessoryProductTpl"
  },
  appLinkTpl = {config = "app_link", cls = "appLinkTpl"},
  kiboDuelSkillTpl = {
    config = "kibo_duel_skill",
    cls = "kiboDuelSkillTpl"
  },
  kiboDuelAreaTypeTpl = {
    config = "kibo_duel_area_type",
    cls = "kiboDuelAreaTypeTpl"
  },
  kiboDuelAreaLevelTpl = {
    config = "kibo_duel_area_level",
    cls = "kiboDuelAreaLevelTpl"
  },
  situationSceneTpl = {
    config = "situation_scene",
    cls = "situationSceneTpl"
  },
  rogueActivityTpl = {
    config = "rogue_activity",
    cls = "rogueActivityTpl"
  },
  gameEventsEntrustEnterTpl = {
    config = "game_events_entrust_enter",
    cls = "gameEventsEntrustEnterTpl"
  },
  gameEventsKiboDuelMapTpl = {
    config = "game_events_kibo_duel_map",
    cls = "gameEventsKiboDuelMapTpl"
  },
  situationTabTpl = {
    config = "situation_tab",
    cls = "situationTabTpl"
  },
  kiboDuelMapTpl = {
    config = "kibo_duel_map",
    cls = "kiboDuelMapTpl"
  },
  photographTypeTpl = {
    config = "photograph_type",
    cls = "photographTypeTpl"
  },
  photographTextTpl = {
    config = "photograph_text",
    cls = "photographTextTpl"
  },
  photographPicTpl = {
    config = "photograph_pic",
    cls = "photographPicTpl"
  },
  worldCollectingTypeTpl = {
    config = "world_collecting_type",
    cls = "worldCollectingTypeTpl"
  },
  worldCollectingTpl = {
    config = "world_collecting",
    cls = "worldCollectingTpl"
  },
  iconographyTypeTpl = {
    config = "iconography_type",
    cls = "iconographyTypeTpl"
  },
  iconographyTaskTpl = {
    config = "iconography_task",
    cls = "iconographyTaskTpl"
  },
  iconographyLevelTpl = {
    config = "iconography_level",
    cls = "iconographyLevelTpl"
  },
  talentRuneComposeTpl = {
    config = "talent_rune_compose",
    cls = "talentRuneComposeTpl"
  },
  kiboDuelTaskTpl = {
    config = "kibo_duel_task",
    cls = "kiboDuelTaskTpl"
  },
  trainTaskGroupTpl = {
    config = "train_task_group",
    cls = "trainTaskGroupTpl"
  },
  trainTaskTpl = {
    config = "train_task",
    cls = "trainTaskTpl"
  },
  kiboDuelKoTpl = {
    config = "kibo_duel_ko",
    cls = "kiboDuelKoTpl"
  },
  commonWorldRepairTpl = {
    config = "common_world_repair",
    cls = "commonWorldRepairTpl"
  },
  commonBannerTpl = {
    config = "common_banner",
    cls = "commonBannerTpl"
  },
  reasonItemnumChangeTpl = {
    config = "reason_itemnum_change",
    cls = "reasonItemnumChangeTpl"
  },
  itemRewardFormTpl = {
    config = "item_reward_form",
    cls = "itemRewardFormTpl"
  },
  worldEntityTipsTpl = {
    config = "world_entity_tips",
    cls = "worldEntityTipsTpl"
  },
  playercardDressTpl = {
    config = "playercard_dress",
    cls = "playercardDressTpl"
  },
  playercardDressListTpl = {
    config = "playercard_dress_list",
    cls = "playercardDressListTpl"
  },
  mediaPackTpl = {
    config = "media_pack",
    cls = "mediaPackTpl"
  },
  gameEventsNoviceTpl = {
    config = "game_events_novice",
    cls = "gameEventsNoviceTpl"
  },
  petSkillTpl = {
    config = "pet_skill",
    cls = "petSkillTpl"
  },
  petSkillTypeTpl = {
    config = "pet_skill_type",
    cls = "petSkillTypeTpl"
  },
  collectionToolTpl = {
    config = "collection_tool",
    cls = "collectionToolTpl"
  },
  collectionToolTypeTpl = {
    config = "collection_tool_type",
    cls = "collectionToolTypeTpl"
  },
  kiboDuelTagTpl = {
    config = "kibo_duel_tag",
    cls = "kiboDuelTagTpl"
  },
  exploreLevelTpl = {
    config = "explore_level",
    cls = "exploreLevelTpl"
  },
  exploreTpl = {config = "explore", cls = "exploreTpl"},
  uiTopBarTpl = {
    config = "ui_top_bar",
    cls = "uiTopBarTpl"
  },
  commonItemTypeTpl = {
    config = "common_item_type",
    cls = "commonItemTypeTpl"
  },
  frameTextureTpl = {
    config = "frame_texture",
    cls = "frameTextureTpl"
  },
  petRaceTpl = {config = "pet_race", cls = "petRaceTpl"},
  petInterimTpl = {
    config = "pet_interim",
    cls = "petInterimTpl"
  },
  accessoryInterimTpl = {
    config = "accessory_interim",
    cls = "accessoryInterimTpl"
  },
  introductionTpl = {
    config = "introduction",
    cls = "introductionTpl"
  },
  petFavorabilityTpl = {
    config = "pet_favorability",
    cls = "petFavorabilityTpl"
  },
  talentRuneTpl = {
    config = "talent_rune",
    cls = "talentRuneTpl"
  },
  talentRankTpl = {
    config = "talent_rank",
    cls = "talentRankTpl"
  },
  guideConditionTypeTpl = {
    config = "guide_condition_type",
    cls = "guideConditionTypeTpl"
  },
  trialPetTpl = {
    config = "trial_pet",
    cls = "trialPetTpl"
  },
  groupsTpl = {config = "groups", cls = "groupsTpl"},
  plotStartPerformanceTpl = {
    config = "plot_start_performance",
    cls = "plotStartPerformanceTpl"
  },
  fightProhibitTpl = {
    config = "fight_prohibit",
    cls = "fightProhibitTpl"
  },
  homeBuildingRemoteUpTpl = {
    config = "home_building_remoteup",
    cls = "homeBuildingRemoteUpTpl"
  },
  detailsTabTpl = {
    config = "details_tab",
    cls = "detailsTabTpl"
  },
  detailsTpl = {config = "details", cls = "detailsTpl"},
  mountSaddleTpl = {
    config = "mount_saddle",
    cls = "mountSaddleTpl"
  },
  battleTagTpl = {
    config = "battle_tag",
    cls = "battleTagTpl"
  },
  kiboDuelChapterTpl = {
    config = "kibo_duel_chapter",
    cls = "kiboDuelChapterTpl"
  },
  kiboDuelGroupTpl = {
    config = "kibo_duel_group",
    cls = "kiboDuelGroupTpl"
  },
  guideIconTpl = {
    config = "guide_icon",
    cls = "guideIconTpl"
  },
  petCatchItemTpl = {
    config = "pet_catchitem",
    cls = "petCatchItemTpl"
  },
  petCustomizedTpl = {
    config = "pet_customized",
    cls = "petCustomizedTpl"
  },
  dungeonGroupTpl = {
    config = "dungeon_group",
    cls = "dungeonGroupTpl"
  },
  charVoiceWordsPetTpl = {
    config = "char_voice_words_pet",
    cls = "charVoiceWordsPetTpl"
  },
  uiViewTpl = {config = "ui_view", cls = "uiViewTpl"},
  taskTargetTpl = {
    config = "task_target",
    cls = "taskTargetTpl"
  },
  taskStepTpl = {
    config = "task_step",
    cls = "taskStepTpl"
  },
  kiboDuelTpl = {
    config = "kibo_duel",
    cls = "kiboDuelTpl"
  },
  kiboDuelPvpTpl = {
    config = "kibo_duel_pvp",
    cls = "kiboDuelPvpTpl"
  },
  tutorialTypeTpl = {
    config = "tutorial_type",
    cls = "tutorialTypeTpl"
  },
  tutorialTpl = {
    config = "tutorial",
    cls = "tutorialTpl"
  },
  tutorialActivityTpl = {
    config = "tutorial_activity",
    cls = "tutorialActivityTpl"
  },
  commonPetSatietyTpl = {
    config = "common_pet_satiety",
    cls = "commonPetSatietyTpl"
  },
  worldItemTpl = {
    config = "world_item",
    cls = "worldItemTpl"
  },
  multiDungeonTpl = {
    config = "multi_dungeon",
    cls = "multiDungeonTpl"
  },
  multiDungeonGroupTpl = {
    config = "multi_dungeon_group",
    cls = "multiDungeonGroupTpl"
  },
  dungeonCrisisCrusadeTpl = {
    config = "dungeon_crisiscrusade",
    cls = "dungeonCrisisCrusadeTpl"
  },
  dungeonCrisisCrusadeDiffTagTpl = {
    config = "dungeon_crisiscrusade_info",
    cls = "dungeonCrisisCrusadeDiffTagTpl"
  },
  petVoiceWordsSystemTpl = {
    config = "pet_voice_words_system",
    cls = "petVoiceWordsSystemTpl"
  },
  taskConditionTpl = {
    config = "task_condition",
    cls = "taskConditionTpl"
  },
  taskTypeTpl = {
    config = "task_type",
    cls = "taskTypeTpl"
  },
  accessorySubParameterTpl = {
    config = "accessory_sub_parameter",
    cls = "accessorySubParameterTpl"
  },
  homeBuildingNumTpl = {
    config = "home_building_num",
    cls = "homeBuildingNumTpl"
  },
  charVoiceWordsBattleTpl = {
    config = "char_voice_words_battle",
    cls = "charVoiceWordsBattleTpl"
  },
  charVoiceHeroTabTpl = {
    config = "char_voice_hero_tab",
    cls = "charVoiceHeroTabTpl"
  },
  homeLevelShowTpl = {
    config = "home_level_show",
    cls = "homeLevelShowTpl"
  },
  guideConditionTpl = {
    config = "guide_condition",
    cls = "guideConditionTpl"
  },
  homeBuffCountTpl = {
    config = "home_buff_count",
    cls = "homeBuffCountTpl"
  },
  worldInteractTpl = {
    config = "world_interact",
    cls = "worldInteractTpl"
  },
  commonTabTpl = {
    config = "common_tab",
    cls = "commonTabTpl"
  },
  foodMaterialGroupTpl = {
    config = "food_material_group",
    cls = "foodMaterialGroupTpl"
  },
  foodGroupTpl = {
    config = "food_group",
    cls = "foodGroupTpl"
  },
  homeTechnologyTypeTpl = {
    config = "home_technology_type",
    cls = "homeTechnologyTypeTpl"
  },
  homeTechnologyTreeTpl = {
    config = "home_technology_tree",
    cls = "homeTechnologyTreeTpl"
  },
  homeTechnologyTabTpl = {
    config = "home_technology_tab",
    cls = "homeTechnologyTabTpl"
  },
  homeTechnologyLevelTpl = {
    config = "home_technology_level",
    cls = "homeTechnologyLevelTpl"
  },
  homeTechnologyTpl = {
    config = "home_technology",
    cls = "homeTechnologyTpl"
  },
  tipsGroupTpl = {
    config = "tips_group",
    cls = "tipsGroupTpl"
  },
  tipsTpl = {config = "tips", cls = "tipsTpl"},
  systemFiltercontentTpl = {
    config = "system_filtercontent",
    cls = "systemFiltercontentTpl"
  },
  homeDropTpl = {
    config = "home_drop",
    cls = "homeDropTpl"
  },
  homeRanchTpl = {
    config = "home_ranch",
    cls = "homeRanchTpl"
  },
  systemSorttypeTpl = {
    config = "system_sorttype",
    cls = "systemSorttypeTpl"
  },
  systemFiltertypeTpl = {
    config = "system_filtertype",
    cls = "systemFiltertypeTpl"
  },
  systemFilterTpl = {
    config = "system_filter",
    cls = "systemFilterTpl"
  },
  taskItemTpl = {
    config = "task_item",
    cls = "taskItemTpl"
  },
  homeBlockTpl = {
    config = "home_block",
    cls = "homeBlockTpl"
  },
  gameEventsTpl = {
    config = "game_events",
    cls = "gameEventsTpl"
  },
  gameEventsPartygameTpl = {
    config = "game_events_partygame",
    cls = "gameEventsPartygameTpl"
  },
  gameEventsKiboSurveyTpl = {
    config = "game_events_kibo_survey",
    cls = "gameEventsKiboSurveyTpl"
  },
  partygameSkillTpl = {
    config = "partygame_skill",
    cls = "partygameSkillTpl"
  },
  gameEventsDayAttendanceTpl = {
    config = "game_events_day_attendance",
    cls = "gameEventsDayAttendanceTpl"
  },
  commonItemBagTypeTpl = {
    config = "common_item_bag_type",
    cls = "commonItemBagTypeTpl"
  },
  commonItemUseTypeTpl = {
    config = "common_item_use_type",
    cls = "commonItemUseTypeTpl"
  },
  homeBuffTpl = {
    config = "home_buff",
    cls = "homeBuffTpl"
  },
  productsCollectionTypeTpl = {
    config = "products_collection_type",
    cls = "productsCollectionTypeTpl"
  },
  homeLaborCapacityTpl = {
    config = "home_labor_capacity",
    cls = "homeLaborCapacityTpl"
  },
  homeLaborTypeTpl = {
    config = "home_labor_type",
    cls = "homeLaborTypeTpl"
  },
  homeLaborTrainTpl = {
    config = "home_labor_train",
    cls = "homeLaborTrainTpl"
  },
  petAccessoryRarityProductTpl = {
    config = "pet_accessory_rarity_product",
    cls = "petAccessoryRarityProductTpl"
  },
  petLaborAccessoryExtraTpl = {
    config = "pet_labor_accessory_extra",
    cls = "petLaborAccessoryExtraTpl"
  },
  petLaborAccessoryExtraRateDescTpl = {
    config = "pet_labor_accessory_extra_rate_desc",
    cls = "petLaborAccessoryExtraRateDescTpl"
  },
  homeLaborTrainConditionTpl = {
    config = "home_labor_train_condition",
    cls = "homeLaborTrainConditionTpl"
  },
  homeLaborEfficiencyTpl = {
    config = "home_labor_efficiency",
    cls = "homeLaborEfficiencyTpl"
  },
  petLaborTrainExpTpl = {
    config = "home_labor_train_exp",
    cls = "petLaborTrainExpTpl"
  },
  petHomeTalentTpl = {
    config = "pet_home_talent",
    cls = "petHomeTalentTpl"
  },
  petHomeSizeTpl = {
    config = "pet_home_size",
    cls = "petHomeSizeTpl"
  },
  homeTalentTpl = {
    config = "home_talent",
    cls = "homeTalentTpl"
  },
  fishBaitTpl = {
    config = "fish_bait",
    cls = "fishBaitTpl"
  },
  photographGroupTpl = {
    config = "photograph_group",
    cls = "photographGroupTpl"
  },
  photographParamTpl = {
    config = "photograph_param",
    cls = "photographParamTpl"
  },
  formationTpl = {
    config = "formation",
    cls = "formationTpl"
  },
  commonItemChangeTpl = {
    config = "common_item_change",
    cls = "commonItemChangeTpl"
  },
  uiDecorateTpl = {
    config = "ui_decorate",
    cls = "uiDecorateTpl"
  },
  professionTpl = {
    config = "profession",
    cls = "professionTpl"
  },
  rarityTpl = {config = "rarity", cls = "rarityTpl"},
  petFeatureTpl = {
    config = "pet_feature",
    cls = "petFeatureTpl"
  },
  optionDataDisplayTpl = {
    config = "optionData_display",
    cls = "optionDataDisplayTpl"
  },
  staminaChestDropTpl = {
    config = "stamina_chest_drop",
    cls = "staminaChestDropTpl"
  },
  heroInterimTpl = {
    config = "hero_interim",
    cls = "heroInterimTpl"
  },
  petGradeTpl = {
    config = "pet_grade",
    cls = "petGradeTpl"
  },
  petDnagradeTpl = {
    config = "pet_dnagrade",
    cls = "petDnagradeTpl"
  },
  petAttributeinheritanceTpl = {
    config = "pet_attributeinheritance",
    cls = "petAttributeinheritanceTpl"
  },
  enemyPackTpl = {
    config = "enemy_pack",
    cls = "enemyPackTpl"
  },
  pamiLetterCategoryTpl = {
    config = "pami_letter_category",
    cls = "pamiLetterCategoryTpl"
  },
  pamiLetterGroupTpl = {
    config = "pami_letter_group",
    cls = "pamiLetterGroupTpl"
  },
  pamiLetterListTpl = {
    config = "pami_letter_list",
    cls = "pamiLetterListTpl"
  },
  pamiLetterReplyTpl = {
    config = "pami_letter_reply",
    cls = "pamiLetterReplyTpl"
  },
  pamiLetterTextTpl = {
    config = "pami_letter_text",
    cls = "pamiLetterTextTpl"
  },
  mapNodeTpl = {config = "map_node", cls = "mapNodeTpl"},
  homeDormSceneTpl = {
    config = "home_dorm_scene",
    cls = "homeDormSceneTpl"
  },
  productsCollectionTpl = {
    config = "products_collection",
    cls = "productsCollectionTpl"
  },
  resourceBarItemTpl = {
    config = "resource_bar_item",
    cls = "resourceBarItemTpl"
  },
  starManualTpl = {
    config = "star_manual",
    cls = "starManualTpl"
  },
  starManualLevelTpl = {
    config = "star_manual_level",
    cls = "starManualLevelTpl"
  },
  homeFieldtypeTpl = {
    config = "home_fieldtype",
    cls = "homeFieldtypeTpl"
  },
  homeFreeWorkPositionTpl = {
    config = "home_freeworkposition",
    cls = "homeFreeWorkPositionTpl"
  },
  homeCropTypeTpl = {
    config = "home_crop_type",
    cls = "homeCropTypeTpl"
  },
  homeSeedsTpl = {
    config = "home_seeds",
    cls = "homeSeedsTpl"
  },
  battleDamagetextTpl = {
    config = "battle_damagetext",
    cls = "battleDamagetextTpl"
  },
  gameActTpl = {config = "game_act", cls = "gameActTpl"},
  battleMessageUnitruleTpl = {
    config = "battle_message_unitrule",
    cls = "battleMessageUnitruleTpl"
  },
  dialogueBattleTpl = {
    config = "dialogue_battle",
    cls = "dialogueBattleTpl"
  },
  battleMessageTpl = {
    config = "battle_message",
    cls = "battleMessageTpl"
  },
  homeBuildingProductionTpl = {
    config = "home_building_production",
    cls = "homeBuildingProductionTpl"
  },
  dailyAttendanceTeamTpl = {
    config = "daily_attendance_team",
    cls = "dailyAttendanceTeamTpl"
  },
  dailyAttendanceTpl = {
    config = "daily_attendance",
    cls = "dailyAttendanceTpl"
  },
  homeScienceTpl = {
    config = "home_science",
    cls = "homeScienceTpl"
  },
  homeBuildingCollectionTpl = {
    config = "home_building_collection",
    cls = "homeBuildingCollectionTpl"
  },
  homeBuildingHomecollectionTpl = {
    config = "home_building_homecollection",
    cls = "homeBuildingHomecollectionTpl"
  },
  homeBuildingBuffWorldTpl = {
    config = "home_building_buff_world",
    cls = "homeBuildingBuffWorldTpl"
  },
  homeCollectionWorldTpl = {
    config = "home_collection_world",
    cls = "homeCollectionWorldTpl"
  },
  homeCollectionWorkLimitTpl = {
    config = "home_collection_worklimit",
    cls = "homeCollectionWorkLimitTpl"
  },
  skillsubLogicTpl = {
    config = "skillsub_logic",
    cls = "skillsubLogicTpl"
  },
  skillsubAttrupTpl = {
    config = "skillsub_attrup",
    cls = "skillsubAttrupTpl"
  },
  worldSpawnerTpl = {
    config = "world_spawner",
    cls = "worldSpawnerTpl"
  },
  exploreRewardTpl = {
    config = "explore_reward",
    cls = "exploreRewardTpl"
  },
  systemUnlockTpl = {
    config = "system_unlock",
    cls = "systemUnlockTpl"
  },
  stargiftTpl = {
    config = "stargift",
    cls = "stargiftTpl"
  },
  shopIapTpl = {config = "shop_iap", cls = "shopIapTpl"},
  poseTpl = {config = "pose", cls = "poseTpl"},
  playerTitleTpl = {
    config = "player_title",
    cls = "playerTitleTpl"
  },
  foodTypeTpl = {
    config = "food_type",
    cls = "foodTypeTpl"
  },
  fishRodTpl = {config = "fish_rod", cls = "fishRodTpl"},
  fishRodBuffTpl = {
    config = "fish_rod_buff",
    cls = "fishRodBuffTpl"
  },
  fishGroupTpl = {
    config = "fish_group",
    cls = "fishGroupTpl"
  },
  fishQteTpl = {config = "fish_qte", cls = "fishQteTpl"},
  fishPondTpl = {
    config = "fish_pond",
    cls = "fishPondTpl"
  },
  fishTpl = {config = "fish", cls = "fishTpl"},
  fishEventTpl = {
    config = "fish_event",
    cls = "fishEventTpl"
  },
  activityRewardTpl = {
    config = "activity_reward",
    cls = "activityRewardTpl"
  },
  activityTpl = {
    config = "activity",
    cls = "activityTpl"
  },
  worldAreaTpl = {
    config = "world_area",
    cls = "worldAreaTpl"
  },
  staminaTpl = {config = "stamina", cls = "staminaTpl"},
  dungeonRandomTpl = {
    config = "dungeon_random",
    cls = "dungeonRandomTpl"
  },
  worldPathNodeTpl = {
    config = "world_path_node",
    cls = "worldPathNodeTpl"
  },
  soulessenceRankTpl = {
    config = "soulessence_rank",
    cls = "soulessenceRankTpl"
  },
  randomNameTpl = {
    config = "random_name",
    cls = "randomNameTpl"
  },
  homeResourceTpl = {
    config = "home_resource",
    cls = "homeResourceTpl"
  },
  worldDifficultyTpl = {
    config = "world_difficulty",
    cls = "worldDifficultyTpl"
  },
  worldBuffTpl = {
    config = "world_buff",
    cls = "worldBuffTpl"
  },
  chatQuickTpl = {
    config = "chat_quick",
    cls = "chatQuickTpl"
  },
  chatEmojiGroupTpl = {
    config = "chat_emoji_group",
    cls = "chatEmojiGroupTpl"
  },
  chatEmojiTpl = {
    config = "chat_emoji",
    cls = "chatEmojiTpl"
  },
  chatBubbleTpl = {
    config = "chat_bubble",
    cls = "chatBubbleTpl"
  },
  chatBackgroundTpl = {
    config = "chat_bg",
    cls = "chatBackgroundTpl"
  },
  soulessenceValueTpl = {
    config = "soulessence_value",
    cls = "soulessenceValueTpl"
  },
  soulessenceTpl = {
    config = "soulessence",
    cls = "soulessenceTpl"
  },
  commonItemTypeIconTpl = {
    config = "common_item_type_icon",
    cls = "commonItemTypeIconTpl"
  },
  petFeedItemTpl = {
    config = "pet_feed_item",
    cls = "petFeedItemTpl"
  },
  gameClientTpl = {
    config = "game_client",
    cls = "gameClientTpl"
  },
  foodTpl = {config = "food", cls = "foodTpl"},
  dnaPoolTpl = {
    config = "pet_dnapool",
    cls = "dnaPoolTpl"
  },
  dnaDropTpl = {
    config = "pet_dnadrop",
    cls = "dnaDropTpl"
  },
  dnaTpl = {config = "pet_dna", cls = "dnaTpl"},
  petDnaTypeTpl = {
    config = "pet_dna_type",
    cls = "petDnaTypeTpl"
  },
  commonConditionTpl = {
    config = "common_condition",
    cls = "commonConditionTpl"
  },
  speciesTpl = {config = "species", cls = "speciesTpl"},
  guideGroupTpl = {
    config = "guide_group",
    cls = "guideGroupTpl"
  },
  guideTpl = {config = "guide", cls = "guideTpl"},
  guidePicTpl = {
    config = "guide_pic",
    cls = "guidePicTpl"
  },
  guideClickPathTpl = {
    config = "guide_click_path",
    cls = "guideClickPathTpl"
  },
  guideWordsTpl = {
    config = "guide_words",
    cls = "guideWordsTpl"
  },
  enemyTpl = {config = "enemy", cls = "enemyTpl"},
  dungeonEnemyTpl = {
    config = "dungeon_enemy",
    cls = "dungeonEnemyTpl"
  },
  charStoryTpl = {
    config = "char_story",
    cls = "charStoryTpl"
  },
  buffInfoTpl = {
    config = "buff_info",
    cls = "buffInfoTpl"
  },
  heroFavorabilityExpTpl = {
    config = "hero_favorability_exp",
    cls = "heroFavorabilityExpTpl"
  },
  heroFavorabilityGiftTpl = {
    config = "hero_favorability_gift",
    cls = "heroFavorabilityGiftTpl"
  },
  heroFavorabilityInfoTpl = {
    config = "hero_favorability_info",
    cls = "heroFavorabilityInfoTpl"
  },
  heroFavorabilityGiftType = {
    config = "hero_favorability_gift_type",
    cls = "heroFavorabilityGiftType"
  },
  charPlotTpl = {
    config = "char_plot",
    cls = "charPlotTpl"
  },
  dropTpl = {config = "drop", cls = "dropTpl"},
  battleInfoTpl = {
    config = "battle_info",
    cls = "battleInfoTpl"
  },
  homeBuildingGroupTpl = {
    config = "home_building_group",
    cls = "homeBuildingGroupTpl"
  },
  homeDecorationSeriesTpl = {
    config = "home_decoration_series",
    cls = "homeDecorationSeriesTpl"
  },
  accessorySubTpl = {
    config = "accessory_sub",
    cls = "accessorySubTpl"
  },
  accessorySetTpl = {
    config = "accessory_set",
    cls = "accessorySetTpl"
  },
  accessoryMainTpl = {
    config = "accessory_main",
    cls = "accessoryMainTpl"
  },
  accessoryLevelTpl = {
    config = "accessory_level",
    cls = "accessoryLevelTpl"
  },
  accessoryTpl = {
    config = "accessory",
    cls = "accessoryTpl"
  },
  petHobbyTpl = {
    config = "pet_hobby",
    cls = "petHobbyTpl"
  },
  petRankTpl = {config = "pet_rank", cls = "petRankTpl"},
  petRankVoiceTpl = {
    config = "pet_rank_voice",
    cls = "petRankVoiceTpl"
  },
  unitPropertyTpl = {
    config = "unit_property",
    cls = "unitPropertyTpl"
  },
  petLevelTpl = {
    config = "pet_level",
    cls = "petLevelTpl"
  },
  petLevelDecayTpl = {
    config = "pet_level_decay",
    cls = "petLevelDecayTpl"
  },
  petLearningAblityTpl = {
    config = "pet_learningtalent",
    cls = "petLearningAblityTpl"
  },
  petLearingEnumTpl = {
    config = "pet_learningenum",
    cls = "petLearingEnumTpl"
  },
  petTalentTpl = {
    config = "pet_talent",
    cls = "petTalentTpl"
  },
  petTalentUpgradeTpl = {
    config = "pet_talent_upgrade",
    cls = "petTalentUpgradeTpl"
  },
  petTpl = {config = "pet", cls = "petTpl"},
  petEggAppearanceTpl = {
    config = "pet_eggappearance",
    cls = "petEggAppearanceTpl"
  },
  petEggTpl = {config = "pet_egg", cls = "petEggTpl"},
  battleTpl = {config = "battle", cls = "battleTpl"},
  dungeonTpl = {config = "dungeon", cls = "dungeonTpl"},
  dungeonExpTpl = {
    config = "dungeon_exp",
    cls = "dungeonExpTpl"
  },
  optionDataClassTpl = {
    config = "optionData_class",
    cls = "optionDataClassTpl"
  },
  keyCodeTpl = {config = "keyCode", cls = "keyCodeTpl"},
  worldFilterTpl = {
    config = "world_filter",
    cls = "worldFilterTpl"
  },
  worldFilterMarkTpl = {
    config = "world_filter_mark",
    cls = "worldFilterMarkTpl"
  },
  worldMapEffectTpl = {
    config = "world_map_effect",
    cls = "worldMapEffectTpl"
  },
  worldCityTpl = {
    config = "world_city",
    cls = "worldCityTpl"
  },
  worldBorthposTpl = {
    config = "world_borthpos",
    cls = "worldBorthposTpl"
  },
  colorFormulaTpl = {
    config = "color_formula",
    cls = "colorFormulaTpl"
  },
  wardrobeAvatarTpl = {
    config = "wardrobe_avatar",
    cls = "wardrobeAvatarTpl"
  },
  wardrobeTpl = {
    config = "wardrobe",
    cls = "wardrobeTpl"
  },
  unitColliderTpl = {
    config = "unit_collider",
    cls = "unitColliderTpl"
  },
  unitTpl = {config = "unit", cls = "unitTpl"},
  templateValueTpl = {
    config = "template_value",
    cls = "templateValueTpl"
  },
  templateHeroTpl = {
    config = "template_hero",
    cls = "templateHeroTpl"
  },
  taskTpl = {config = "task", cls = "taskTpl"},
  skillLevelTpl = {
    config = "skill_level",
    cls = "skillLevelTpl"
  },
  skillTpl = {config = "skill", cls = "skillTpl"},
  shopTpl = {config = "shop", cls = "shopTpl"},
  shopGroupTpl = {
    config = "shop_group",
    cls = "shopGroupTpl"
  },
  productsTpl = {
    config = "products",
    cls = "productsTpl"
  },
  productsMaterialGroupTpl = {
    config = "products_material_group",
    cls = "productsMaterialGroupTpl"
  },
  productsMultiQualityTpl = {
    config = "products_multi_quality",
    cls = "productsMultiQualityTpl"
  },
  playerLevelTpl = {
    config = "player_level",
    cls = "playerLevelTpl"
  },
  optionDataTpl = {
    config = "optionData",
    cls = "optionDataTpl"
  },
  mailBonusCTpl = {
    config = "mail_bonus_c",
    cls = "mailBonusCTpl"
  },
  mailTpl = {config = "mail", cls = "mailTpl"},
  homeBuildingTypeTpl = {
    config = "home_building_type",
    cls = "homeBuildingTypeTpl"
  },
  heroLevelTpl = {
    config = "hero_level",
    cls = "heroLevelTpl"
  },
  heroGradeTpl = {
    config = "hero_grade",
    cls = "heroGradeTpl"
  },
  heroTpl = {config = "hero", cls = "heroTpl"},
  clothItemTpl = {
    config = "clothing_item",
    cls = "clothItemTpl"
  },
  heroClothingTpl = {
    config = "hero_clothing",
    cls = "heroClothingTpl"
  },
  goodsTpl = {config = "goods", cls = "goodsTpl"},
  goodsPurchaseTpl = {
    config = "goods_purchase",
    cls = "goodsPurchaseTpl"
  },
  errorCodeTpl = {
    config = "errorCode",
    cls = "errorCodeTpl"
  },
  domainTpl = {config = "domain", cls = "domainTpl"},
  currencyTpl = {
    config = "currency",
    cls = "currencyTpl"
  },
  commonItemTpl = {
    config = nil,
    cls = "commonItemTpl"
  },
  areaTpl = {config = "area", cls = "areaTpl"},
  achievementGroupTpl = {
    config = "achievement_group",
    cls = "achievementGroupTpl"
  },
  achievementTpl = {
    config = "achievement",
    cls = "achievementTpl"
  },
  achievementAwardTpl = {
    config = "achievement_award",
    cls = "achievementAwardTpl"
  },
  homeObj = {
    config = "home_object",
    cls = "homeObjTpl"
  },
  mountTpl = {config = "mount", cls = "mountTpl"},
  worldMapTpl = {
    config = nil,
    cls = "worldMapTpl"
  },
  gameConstTpl = {
    config = "game",
    cls = "gameConstTpl"
  },
  wordsTpl = {config = "words", cls = "wordsTpl"},
  optionDataTotalTpl = {
    config = "optionData_total",
    cls = "optionDataTotalTpl"
  },
  optionDataTotalMobileTpl = {
    config = "optionData_total_mobile",
    cls = "optionDataTotalMobileTpl"
  },
  homeBuildingTpl = {
    config = "home_building",
    cls = "homeBuildingTpl"
  },
  charDataTpl = {
    config = "char_data",
    cls = "charDataTpl"
  },
  charVoiceTpl = {
    config = "char_voice",
    cls = "charVoiceTpl"
  },
  soulessenceLevelTpl = {
    config = "soulessence_level",
    cls = "soulessenceLevelTpl"
  },
  towerTpl = {config = "tower", cls = "towerTpl"},
  towerBattleTpl = {
    config = "tower_battle",
    cls = "towerBattleTpl"
  },
  towerRewardTpl = {
    config = "tower_reward",
    cls = "towerRewardTpl"
  },
  deviceTpl = {config = nil, cls = "deviceTpl"},
  elementTypeTpl = {
    config = "element_type",
    cls = "elementTypeTpl"
  },
  photoTemplateTpl = {
    config = "photo_template",
    cls = "photoTemplateTpl"
  },
  photoSpaceCaseTpl = {
    config = "photo_space_case",
    cls = "photoSpaceCaseTpl"
  },
  rouletteTabTpl = {
    config = "roulette_tab",
    cls = "rouletteTabTpl"
  },
  noviceTaskTpl = {
    config = "novice_task",
    cls = "noviceTaskTpl"
  },
  noviceTaskGroupTpl = {
    config = "novice_task_group",
    cls = "noviceTaskGroupTpl"
  },
  activityTabTpl = {
    config = "activity_tab",
    cls = "activityTabTpl"
  },
  chargeSatietyTpl = {
    config = "charge_satiety",
    cls = "chargeSatietyTpl"
  },
  dungeonEntrustTpl = {
    config = "dungeon_entrust",
    cls = "dungeonEntrustTpl"
  },
  dungeonMaterialTpl = {
    config = "dungeon_material",
    cls = "dungeonMaterialTpl"
  },
  dungeonMaterialTypeTpl = {
    config = "dungeon_material_type",
    cls = "dungeonMaterialTypeTpl"
  },
  dungeonMaterialDiffTpl = {
    config = "dungeon_material_diff",
    cls = "dungeonMaterialDiffTpl"
  },
  dungeonEntrustDifficultyTpl = {
    config = "dungeon_entrust_difficulty",
    cls = "dungeonEntrustDifficultyTpl"
  },
  dungeonEntrustGroupTpl = {
    config = "dungeon_entrust_group",
    cls = "dungeonEntrustGroupTpl"
  },
  dungeonEntrustRewardTpl = {
    config = "dungeon_entrust_reward",
    cls = "dungeonEntrustRewardTpl"
  },
  commonJumpTpl = {
    config = "common_jump",
    cls = "commonJumpTpl"
  },
  dungeonEntrustTypeTpl = {
    config = "dungeon_entrust_type",
    cls = "dungeonEntrustTypeTpl"
  },
  dungeonEntrustTagTpl = {
    config = "dungeon_entrust_tag",
    cls = "dungeonEntrustTagTpl"
  },
  dungeonEntrustAreaTpl = {
    config = "dungeon_entrust_area",
    cls = "dungeonEntrustAreaTpl"
  },
  gameeventssubitemTpl = {
    config = "game_events_subitem",
    cls = "gameeventssubitemTpl"
  },
  homeDormFurnitureTpl = {
    config = "home_dorm_furniture",
    cls = "homeDormFurnitureTpl"
  },
  homeDormFurnitureRecommendTpl = {
    config = "shop_furniture_recommend",
    cls = "homeDormFurnitureRecommendTpl"
  },
  talentRankReward = {
    config = "talent_rank_reward",
    cls = "talentRankRewardTpl"
  },
  gameEventsKiboDuelTpl = {
    config = "game_events_kibo_duel",
    cls = "gameEventsKiboDuelTpl"
  },
  gameEventsRewardGroupTpl = {
    config = "game_events_reward_group",
    cls = "gameEventsRewardGroupTpl"
  },
  gameEventsRewardTpl = {
    config = "game_events_reward",
    cls = "gameEventsRewardTpl"
  },
  gameEventsDoubleDropTpl = {
    config = "game_events_double_drop",
    cls = "gameEventsDoubleDropTpl"
  },
  libraryBranchTpl = {
    config = "library_branch",
    cls = "libraryBranchTpl"
  },
  libraryCategoryTpl = {
    config = "library_category",
    cls = "libraryCategoryTpl"
  },
  librarySeriesTpl = {
    config = "library_series",
    cls = "librarySeriesTpl"
  },
  libraryReadingsTpl = {
    config = "library_readings",
    cls = "libraryReadingsTpl"
  },
  commonReportUserTpl = {
    config = "common_report_user",
    cls = "commonReportUserTpl"
  },
  commonPlayerInformationTpl = {
    config = "common_player_information",
    cls = "commonPlayerInformationTpl"
  },
  systemVoiceUnitruleTpl = {
    config = "system_voice_unitrule",
    cls = "systemVoiceUnitruleTpl"
  },
  situationObjectsTpl = {
    config = "situation_objects",
    cls = "situationObjectsTpl"
  },
  gameActivityTpl = {
    config = "game_activity",
    cls = "gameActivityTpl"
  },
  chatChannelListTpl = {
    config = "chat_channel_list",
    cls = "chatChannelListTpl"
  },
  chatListTpl = {
    config = "chat_list",
    cls = "chatListTpl"
  },
  smeltReturnTpl = {
    config = "smelt_return",
    cls = "smeltReturnTpl"
  },
  reputationLevelTpl = {
    config = "reputation_level",
    cls = "reputationLevelTpl"
  },
  gameActivityIntegralTpl = {
    config = "game_activity_integral",
    cls = "gameActivityIntegralTpl"
  },
  gameActivityPlayTpl = {
    config = "game_activity_play",
    cls = "gameActivityPlayTpl"
  },
  gameActivityLevelTpl = {
    config = "game_activity_level",
    cls = "gameActivityLevelTpl"
  },
  gameActivityLevelGroupTpl = {
    config = "game_activity_levelgroup",
    cls = "gameActivityLevelGroupTpl"
  },
  medicineTpl = {
    config = "medicine",
    cls = "medicineTpl"
  },
  worldDifficultyCityTpl = {
    config = "world_difficulty_city",
    cls = "worldDifficultyCityTpl"
  },
  illustratedhandbookMainTpl = {
    config = "illustratedhandbook_main",
    cls = "illustratedhandbookMainTpl"
  },
  mainBottomButtonsTpl = {
    config = "main_bottom_buttons",
    cls = "mainBottomButtonsTpl"
  },
  worldBreakableOverwriteTpl = {
    config = "world_breakable_overwrite",
    cls = "worldBreakableOverwriteTpl"
  },
  playableTypeTpl = {
    config = "playable_type",
    cls = "playableTypeTpl"
  },
  playableTpl = {
    config = "playable",
    cls = "playableTpl"
  },
  dungeonEntrustRewardChance = {
    config = "dungeon_entrust_rewardchance",
    cls = "dungeonEntrustRewardChanceTpl"
  },
  journeyTypeTpl = {
    config = "journey_type",
    cls = "journeyTypeTpl"
  },
  journeyTaskTpl = {
    config = "journey_task",
    cls = "journeyTaskTpl"
  },
  journeyGroupTpl = {
    config = "journey_group",
    cls = "journeyGroupTpl"
  },
  worldEnemyGroupTpl = {
    config = "world_enemy_group",
    cls = "worldEnemyGroupTpl"
  },
  worldEnemyGroupRandomTpl = {
    config = "world_enemy_group_random",
    cls = "worldEnemyGroupRandomTpl"
  },
  nestcoopShopShow = {
    config = "nestcoop_shop_show",
    cls = "nestcoopShopShow"
  },
  nestcoopSiteTpl = {
    config = "nestcoop_site",
    cls = "nestcoopSiteTpl"
  },
  charKiboTpl = {
    config = "char_kibo",
    cls = "charKiboTpl"
  },
  petSkinTpl = {config = "pet_skin", cls = "petSkinTpl"},
  homeDormItemTpl = {
    config = "home_dorm_item",
    cls = "homeDormItemTpl"
  },
  chatIsolateLangueTpl = {
    config = "chat_isolate_langue",
    cls = "chatIsolateLangueTpl"
  },
  accessoryQualityTpl = {
    config = "accessory_quality",
    cls = "accessoryQualityTpl"
  },
  petPixelTagTpl = {
    config = "pet_pixel_tag",
    cls = "petPixelTagTpl"
  },
  petStarSoulTpl = {
    config = "pet_starsoul",
    cls = "petStarSoulTpl"
  },
  formationPetSellTpl = {
    config = "formation_petSell",
    cls = "formationPetSellTpl"
  },
  gmCustomizedtextListTpl = {
    config = "gm_customizedtext_list",
    cls = "gmCustomizedtextListTpl"
  },
  dungeonWeeklyTpl = {
    config = "dungeon_weekly",
    cls = "dungeonWeeklyTpl"
  }
}

function this:changeLanguage()
  for _, v in pairs(m_languageConfig) do
    v:onLanguageChange()
  end
end

function this:dispose()
  for _, v in pairs(CONFIG) do
    v.instance = nil
  end
end

local illegalConfigs = {}

local function getUseFastRead()
  return C_LuaManager.isUseFastReadConfig
end

local function useFastMode(tname)
  local useFast = getUseFastRead()
  if not useFast then
    return false
  end
  if string.isEmpty(tname) then
    return false
  end
  for k, v in ipairs(illegalConfigs) do
    if tname == v then
      return false
    end
  end
  return true
end

local function _getTpl(data)
  if data.instance == nil then
    local instance = require("ui.configTpl." .. data.cls).new()
    data.instance = setmetatable({}, {
      __index = function(t, k)
        if not data.isTplInit then
          L_ProfilerUtil.BeginSample("_getTpl TplInit")
          data.isTplInit = true
          local useFast = useFastMode(data.config)
          local dataTable
          if useFast then
            local function checkLoadConfig()
              data.luaConfig = data.config and L_Config:getConfigNew(data.config)
            end
            
            dataTable = setmetatable({}, {
              __index = function(t, k)
                checkLoadConfig()
                if not data.luaConfig then
                  errorf("config '%s' load failed, luaConfig is nil", data.config or "unknown")
                end
                return data.luaConfig:getLine(k)
              end,
              __newindex = function(t, k, v)
                errorf("attempt to modify a read-only talbe!", 2)
              end,
              __pairs = function(t, k)
                checkLoadConfig()
                local func, tt, tt2 = data.luaConfig.__pairs(data.luaConfig, k)
                return func, tt, tt2
              end,
              __len = function(t)
                checkLoadConfig()
                return data.luaConfig:getLen()
              end
            })
          else
            local function checkLoadConfig()
              data.luaConfig = data.config and L_Config:getConfig(data.config)
            end
            
            dataTable = setmetatable({}, {
              __index = function(t, k)
                checkLoadConfig()
                return data.luaConfig[k]
              end,
              __newindex = function(t, k, v)
                errorf("attempt to modify a read-only talbe!", 2)
              end,
              __pairs = function(t, k)
                checkLoadConfig()
                local func, tt, tt2 = getmetatable(data.luaConfig).__pairs(data.luaConfig, k)
                return func, tt, tt2
              end,
              __len = function(t)
                checkLoadConfig()
                return #data.luaConfig
              end
            })
          end
          instance:init(dataTable)
          L_ProfilerUtil.EndSample()
        end
        return instance[k]
      end
    })
    if instance.onLanguageChange then
      table.insert(m_languageConfig, data.instance)
    end
  end
  return data.instance
end

function this:getTplByCfgName(cfgName)
  if string.isEmpty(cfgName) then
    return
  end
  for _, v in pairs(CONFIG) do
    if v.config == cfgName then
      return _getTpl(v)
    end
  end
end

function this:_getConfig(tname)
  if string.isEmpty(tname) then
    return
  end
  local cfg = L_Config:getConfigNew(tname)
  if cfg == nil then
    return
  end
  return setmetatable({}, {
    __index = function(t, k)
      return cfg:getLine(k)
    end,
    __newindex = function(t, k, v)
      errorf("attempt to modify a read-only talbe!")
    end,
    __pairs = function(t, k)
      local func, tt, tt2 = cfg.__pairs(cfg, k)
      return func, tt, tt2
    end,
    __len = function(t)
      return cfg:getLen()
    end
  })
end

L_WordsTpl = _getTpl(CONFIG.wordsTpl)

function lfmt(key, params, backup)
  if L_WordsTpl:getRawValue(key) then
    return L_WordsTpl:getValue(key, params)
  else
    return L_Lang:fmt(backup, params)
  end
end

L_GameConstTpl = _getTpl(CONFIG.gameConstTpl)
L_GameClientTpl = _getTpl(CONFIG.gameClientTpl)
L_DeviceTpl = _getTpl(CONFIG.deviceTpl)
L_RarityTpl = _getTpl(CONFIG.rarityTpl)
L_DecorateTpl = _getTpl(CONFIG.uiDecorateTpl)

function this:getHomeObjTpl()
  return _getTpl(CONFIG.homeObj)
end

function this:getHomeBuildingTpl()
  return _getTpl(CONFIG.homeBuildingTpl)
end

function this:getMountTpl()
  return _getTpl(CONFIG.mountTpl)
end

function this:getWorldMapTpl()
  return _getTpl(CONFIG.worldMapTpl)
end

function this:getAchievementTpl()
  return _getTpl(CONFIG.achievementTpl)
end

function this:getAchievementAwardTpl()
  return _getTpl(CONFIG.achievementAwardTpl)
end

function this:getAchievementGroupTpl()
  return _getTpl(CONFIG.achievementGroupTpl)
end

function this:getAreaTpl()
  return _getTpl(CONFIG.areaTpl)
end

function this:getAppLinkTpl()
  return _getTpl(CONFIG.appLinkTpl)
end

function this:getBossTpl()
  return nil
end

function this:getCommonItemTpl()
  return _getTpl(CONFIG.commonItemTpl)
end

function this:getCurrencyTpl()
  return _getTpl(CONFIG.currencyTpl)
end

function this:getDomainTpl()
  return _getTpl(CONFIG.domainTpl)
end

function this:getErrorCodeTpl()
  return _getTpl(CONFIG.errorCodeTpl)
end

function this:getGoodsTpl()
  return _getTpl(CONFIG.goodsTpl)
end

function this:getGoodsPurchaseTpl()
  return _getTpl(CONFIG.goodsPurchaseTpl)
end

function this:getHeroTpl()
  return _getTpl(CONFIG.heroTpl)
end

function this:getClothItemTpl()
  return _getTpl(CONFIG.clothItemTpl)
end

function this:getHeroClothingTpl()
  return _getTpl(CONFIG.heroClothingTpl)
end

function this:getHeroGradeTpl()
  return _getTpl(CONFIG.heroGradeTpl)
end

function this:getHeroLevelTpl()
  return _getTpl(CONFIG.heroLevelTpl)
end

function this:getHomeBuildingTypeTpl()
  return _getTpl(CONFIG.homeBuildingTypeTpl)
end

function this:getMailTpl()
  return _getTpl(CONFIG.mailTpl)
end

function this:getMailBonusCTpl()
  return _getTpl(CONFIG.mailBonusCTpl)
end

function this:getMonsterTpl()
  return nil
end

function this:getOptionDataTpl()
  return _getTpl(CONFIG.optionDataTpl)
end

function this:getPlayerLevelTpl()
  return _getTpl(CONFIG.playerLevelTpl)
end

function this:getProductsTpl()
  return _getTpl(CONFIG.productsTpl)
end

function this:getProductsMaterialGroupTpl()
  return _getTpl(CONFIG.productsMaterialGroupTpl)
end

function this:getProductsMultiQualityTpl()
  return _getTpl(CONFIG.productsMultiQualityTpl)
end

function this:getShopTpl()
  return _getTpl(CONFIG.shopTpl)
end

function this:getSkillTpl()
  return _getTpl(CONFIG.skillTpl)
end

function this:getSkillLevelTpl()
  return _getTpl(CONFIG.skillLevelTpl)
end

function this:getSummonedTpl()
  return nil
end

function this:getTaskTpl()
  return _getTpl(CONFIG.taskTpl)
end

function this:getTemplateHeroTpl()
  return _getTpl(CONFIG.templateHeroTpl)
end

function this:getTemplateValueTpl()
  return _getTpl(CONFIG.templateValueTpl)
end

function this:getUnitTpl()
  return _getTpl(CONFIG.unitTpl)
end

function this:getUnitColliderTpl()
  return _getTpl(CONFIG.unitColliderTpl)
end

function this:getWardrobeTpl()
  return _getTpl(CONFIG.wardrobeTpl)
end

function this:getWardrobeAvatarTpl()
  return _getTpl(CONFIG.wardrobeAvatarTpl)
end

function this:getWorldBorthposTpl()
  return _getTpl(CONFIG.worldBorthposTpl)
end

function this:getWorldCityTpl()
  return _getTpl(CONFIG.worldCityTpl)
end

function this:getWorldFilterTpl()
  return _getTpl(CONFIG.worldFilterTpl)
end

function this:getWorldFilterMarkTpl()
  return _getTpl(CONFIG.worldFilterMarkTpl)
end

function this:getKeyCodeTpl()
  return _getTpl(CONFIG.keyCodeTpl)
end

function this:getOptionDataClassTpl()
  return _getTpl(CONFIG.optionDataClassTpl)
end

function this:getDungeonTpl()
  return _getTpl(CONFIG.dungeonTpl)
end

function this:getDungeonExpTpl()
  return _getTpl(CONFIG.dungeonExpTpl)
end

function this:getWorldMapEffectTpl()
  return _getTpl(CONFIG.worldMapEffectTpl)
end

function this:getBattleTpl()
  return _getTpl(CONFIG.battleTpl)
end

function this:getGameConstTpl()
  return _getTpl(CONFIG.gameConstTpl)
end

function this:getWordsTpl()
  return _getTpl(CONFIG.wordsTpl)
end

function this:getOptionDataTotalTpl()
  if L_DeviceTpl:getIsMobile() then
    return _getTpl(CONFIG.optionDataTotalMobileTpl)
  else
    return _getTpl(CONFIG.optionDataTotalTpl)
  end
end

function this:getPetEggTpl()
  return _getTpl(CONFIG.petEggTpl)
end

function this:getPetEggAppearanceTpl()
  return _getTpl(CONFIG.petEggAppearanceTpl)
end

function this:getPetTpl()
  return _getTpl(CONFIG.petTpl)
end

function this:getPetLearingEnumTpl()
  return _getTpl(CONFIG.petLearingEnumTpl)
end

function this:getPetTalentUpgradeTpl()
  return _getTpl(CONFIG.petTalentUpgradeTpl)
end

function this:getPetTalentTpl()
  return _getTpl(CONFIG.petTalentTpl)
end

function this:getPetLearningAblityTpl()
  return _getTpl(CONFIG.petLearningAblityTpl)
end

function this:getPetLevelTpl()
  return _getTpl(CONFIG.petLevelTpl)
end

function this:getPetLevelDecayTpl()
  return _getTpl(CONFIG.petLevelDecayTpl)
end

function this:getUnitPropertyTpl()
  return _getTpl(CONFIG.unitPropertyTpl)
end

function this:getPetRankTpl()
  return _getTpl(CONFIG.petRankTpl)
end

function this:getPetRankVoiceTpl()
  return _getTpl(CONFIG.petRankVoiceTpl)
end

function this:getPetHobbyTpl()
  return _getTpl(CONFIG.petHobbyTpl)
end

function this:getAccessoryTpl()
  return _getTpl(CONFIG.accessoryTpl)
end

function this:getAccessoryLevelTpl()
  return _getTpl(CONFIG.accessoryLevelTpl)
end

function this:getAccessoryMainTpl()
  return _getTpl(CONFIG.accessoryMainTpl)
end

function this:getAccessorySetTpl()
  return _getTpl(CONFIG.accessorySetTpl)
end

function this:getAccessorySubTpl()
  return _getTpl(CONFIG.accessorySubTpl)
end

function this:getAccessoryRecommendRarityTpl()
  return _getTpl(CONFIG.accessoryRecommendRarityTpl)
end

function this:getAccessoryCustomedTpl()
  return _getTpl(CONFIG.accessoryCustomedTpl)
end

function this:getHomeBuildingGroupTpl()
  return _getTpl(CONFIG.homeBuildingGroupTpl)
end

function this:getHomeDecorationSeriesTpl()
  return _getTpl(CONFIG.homeDecorationSeriesTpl)
end

function this:getBattleInfoTpl()
  return _getTpl(CONFIG.battleInfoTpl)
end

function this:getDropTpl()
  return _getTpl(CONFIG.dropTpl)
end

function this:getCharPlotTpl()
  return _getTpl(CONFIG.charPlotTpl)
end

function this:getHeroFavorabilityInfoTpl()
  return _getTpl(CONFIG.heroFavorabilityInfoTpl)
end

function this:getHeroFavorabilityGiftTpl()
  return _getTpl(CONFIG.heroFavorabilityGiftTpl)
end

function this:getHeroFavorabilityExpTpl()
  return _getTpl(CONFIG.heroFavorabilityExpTpl)
end

function this:getheroFavorabilityGiftType()
  return _getTpl(CONFIG.heroFavorabilityGiftType)
end

function this:getBuffInfoTpl()
  return _getTpl(CONFIG.buffInfoTpl)
end

function this:getCharDataTpl()
  return _getTpl(CONFIG.charDataTpl)
end

function this:getCharStoryTpl()
  return _getTpl(CONFIG.charStoryTpl)
end

function this:getCharVoiceTpl()
  return _getTpl(CONFIG.charVoiceTpl)
end

function this:getEnemyTpl()
  return _getTpl(CONFIG.enemyTpl)
end

function this:getDungeonEnemyTpl()
  return _getTpl(CONFIG.dungeonEnemyTpl)
end

function this:getGuideTpl()
  return _getTpl(CONFIG.guideTpl)
end

function this:getGuidePicTpl()
  return _getTpl(CONFIG.guidePicTpl)
end

function this:getGuideClickPathTpl()
  return _getTpl(CONFIG.guideClickPathTpl)
end

function this:getGuideWordsTpl()
  return _getTpl(CONFIG.guideWordsTpl)
end

function this:getGuideGroupTpl()
  return _getTpl(CONFIG.guideGroupTpl)
end

function this:getCommonConditionTpl()
  return _getTpl(CONFIG.commonConditionTpl)
end

function this:getSpeciesTpl()
  return _getTpl(CONFIG.speciesTpl)
end

function this:getDnaTpl()
  return _getTpl(CONFIG.dnaTpl)
end

function this:getPetDnaTypeTpl()
  return _getTpl(CONFIG.petDnaTypeTpl)
end

function this:getDnaDropTpl()
  return _getTpl(CONFIG.dnaDropTpl)
end

function this:getDnaPoolTpl()
  return _getTpl(CONFIG.dnaPoolTpl)
end

function this:getFoodTpl()
  return _getTpl(CONFIG.foodTpl)
end

function this:getGameClientTpl()
  return _getTpl(CONFIG.gameClientTpl)
end

function this:getPetCustomizedTpl()
  return _getTpl(CONFIG.petCustomizedTpl)
end

function this:getPetFeedItemTpl()
  return _getTpl(CONFIG.petFeedItemTpl)
end

function this:getCommonItemTypeIconTpl()
  return _getTpl(CONFIG.commonItemTypeIconTpl)
end

function this:getSoulessenceTpl()
  return _getTpl(CONFIG.soulessenceTpl)
end

function this:getSoulessenceValueTpl()
  return _getTpl(CONFIG.soulessenceValueTpl)
end

function this:getSoulessenceLevelTpl()
  return _getTpl(CONFIG.soulessenceLevelTpl)
end

function this:getChatEmojiTpl()
  return _getTpl(CONFIG.chatEmojiTpl)
end

function this:getChatEmojiGroupTpl()
  return _getTpl(CONFIG.chatEmojiGroupTpl)
end

function this:getChatQuickTpl()
  return _getTpl(CONFIG.chatQuickTpl)
end

function this:getWorldDifficultyTpl()
  return _getTpl(CONFIG.worldDifficultyTpl)
end

function this:getChatEmojiGroupTpl()
  return _getTpl(CONFIG.chatEmojiGroupTpl)
end

function this:getChatEmojiTpl()
  return _getTpl(CONFIG.chatEmojiTpl)
end

function this:getChatBubbleTpl()
  return _getTpl(CONFIG.chatBubbleTpl)
end

function this:getChatBackgroundTpl()
  return _getTpl(CONFIG.chatBackgroundTpl)
end

function this:getChatQuickTpl()
  return _getTpl(CONFIG.chatQuickTpl)
end

function this:getChatIsolateLangueTpl()
  return _getTpl(CONFIG.chatIsolateLangueTpl)
end

function this:getHomeResourceTpl()
  return _getTpl(CONFIG.homeResourceTpl)
end

function this:getRandomNameTpl()
  return _getTpl(CONFIG.randomNameTpl)
end

function this:getSoulessenceRankTpl()
  return _getTpl(CONFIG.soulessenceRankTpl)
end

function this:getAccessoryQualityTpl()
  return _getTpl(CONFIG.accessoryQualityTpl)
end

function this:getShopGroupTpl()
  return _getTpl(CONFIG.shopGroupTpl)
end

function this:getWorldPathNodeTpl()
  return _getTpl(CONFIG.worldPathNodeTpl)
end

function this:getWorldEnemyGroupTpl()
  return _getTpl(CONFIG.worldEnemyGroupTpl)
end

function this:getWorldEnemyGroupRandomTpl()
  return _getTpl(CONFIG.worldEnemyGroupRandomTpl)
end

function this:getNestcoopSiteTpl()
  return _getTpl(CONFIG.nestcoopSiteTpl)
end

function this:getDungeonRandomTpl()
  return _getTpl(CONFIG.dungeonRandomTpl)
end

function this:getStaminaTpl()
  return _getTpl(CONFIG.staminaTpl)
end

function this:getWorldAreaTpl()
  return _getTpl(CONFIG.worldAreaTpl)
end

function this:getFishTpl()
  return _getTpl(CONFIG.fishTpl)
end

function this:getFishPondTpl()
  return _getTpl(CONFIG.fishPondTpl)
end

function this:getFishQteTpl()
  return _getTpl(CONFIG.fishQteTpl)
end

function this:getFishGroupTpl()
  return _getTpl(CONFIG.fishGroupTpl)
end

function this:getFishEventTpl()
  return _getTpl(CONFIG.fishEventTpl)
end

function this:getActivityTpl()
  return _getTpl(CONFIG.activityTpl)
end

function this:getActivityRewardTpl()
  return _getTpl(CONFIG.activityRewardTpl)
end

function this:getFishRodTpl()
  return _getTpl(CONFIG.fishRodTpl)
end

function this:getFishRodBuffTpl()
  return _getTpl(CONFIG.fishRodBuffTpl)
end

function this:getFoodTypeTpl()
  return _getTpl(CONFIG.foodTypeTpl)
end

function this:getPlayerTitleTpl()
  return _getTpl(CONFIG.playerTitleTpl)
end

function this:getPoseTpl()
  return _getTpl(CONFIG.poseTpl)
end

function this:getShopIapTpl()
  return _getTpl(CONFIG.shopIapTpl)
end

function this:getStargiftTpl()
  return _getTpl(CONFIG.stargiftTpl)
end

function this:getSystemUnlockTpl()
  return _getTpl(CONFIG.systemUnlockTpl)
end

function this:getExploreRewardTpl()
  return _getTpl(CONFIG.exploreRewardTpl)
end

function this:getWorldSpawnerTpl()
  return _getTpl(CONFIG.worldSpawnerTpl)
end

function this:getSkillsubAttrupTpl()
  return _getTpl(CONFIG.skillsubAttrupTpl)
end

function this:getSkillsubLogicTpl()
  return _getTpl(CONFIG.skillsubLogicTpl)
end

function this:getDailyAttendanceTpl()
  return _getTpl(CONFIG.dailyAttendanceTpl)
end

function this:getDailyAttendanceTeamTpl()
  return _getTpl(CONFIG.dailyAttendanceTeamTpl)
end

function this:getHomeBuildingProductionTpl()
  return _getTpl(CONFIG.homeBuildingProductionTpl)
end

function this:getHomeScienceTpl()
  return _getTpl(CONFIG.homeScienceTpl)
end

function this:getBattleMessageTpl()
  return _getTpl(CONFIG.battleMessageTpl)
end

function this:getDialogueBattleTpl()
  return _getTpl(CONFIG.dialogueBattleTpl)
end

function this:getBattleMessageUnitruleTpl()
  return _getTpl(CONFIG.battleMessageUnitruleTpl)
end

function this:getGameActTpl()
  return _getTpl(CONFIG.gameActTpl)
end

function this:getBattleDamagetextTpl()
  return _getTpl(CONFIG.battleDamagetextTpl)
end

function this:getHomeSeedsTpl()
  return _getTpl(CONFIG.homeSeedsTpl)
end

function this:getHomeCropTypeTpl()
  return _getTpl(CONFIG.homeCropTypeTpl)
end

function this:getHomeFieldtypeTpl()
  return _getTpl(CONFIG.homeFieldtypeTpl)
end

function this:getHomeFreeWorkPositionTpl()
  return _getTpl(CONFIG.homeFreeWorkPositionTpl)
end

function this:getHomeCollectionWorldTpl()
  return _getTpl(CONFIG.homeCollectionWorldTpl)
end

function this:getHomeCollectionWorkLimitTpl()
  return _getTpl(CONFIG.homeCollectionWorkLimitTpl)
end

function this:getHomeBuildingCollectionTpl()
  return _getTpl(CONFIG.homeBuildingCollectionTpl)
end

function this:getHomeBuildingHomecollectionTpl()
  return _getTpl(CONFIG.homeBuildingHomecollectionTpl)
end

function this:getHomeBuildingBuffWorldTpl()
  return _getTpl(CONFIG.homeBuildingBuffWorldTpl)
end

function this:getStarManualTpl()
  return _getTpl(CONFIG.starManualTpl)
end

function this:getStarManualLevelTpl()
  return _getTpl(CONFIG.starManualLevelTpl)
end

function this:getResourceBarItemTpl()
  return _getTpl(CONFIG.resourceBarItemTpl)
end

function this:getProductsCollectionTpl()
  return _getTpl(CONFIG.productsCollectionTpl)
end

function this:getWorldBuffTpl()
  return _getTpl(CONFIG.worldBuffTpl)
end

function this:getTowerTpl()
  return _getTpl(CONFIG.towerTpl)
end

function this:getTowerBattleTpl()
  return _getTpl(CONFIG.towerBattleTpl)
end

function this:getTowerRewardTpl()
  return _getTpl(CONFIG.towerRewardTpl)
end

function this:getHomeDormSceneTpl()
  return _getTpl(CONFIG.homeDormSceneTpl)
end

function this:getMapNodeTpl()
  return _getTpl(CONFIG.mapNodeTpl)
end

function this:getEnemyPackTpl()
  return _getTpl(CONFIG.enemyPackTpl)
end

function this:getPamiLetterTextTpl()
  return _getTpl(CONFIG.pamiLetterTextTpl)
end

function this:getPamiLetterReplyTpl()
  return _getTpl(CONFIG.pamiLetterReplyTpl)
end

function this:getPamiLetterListTpl()
  return _getTpl(CONFIG.pamiLetterListTpl)
end

function this:getPamiLetterGroupTpl()
  return _getTpl(CONFIG.pamiLetterGroupTpl)
end

function this:getPamiLetterCategoryTpl()
  return _getTpl(CONFIG.pamiLetterCategoryTpl)
end

function this:getPetAttributeinheritanceTpl()
  return _getTpl(CONFIG.petAttributeinheritanceTpl)
end

function this:getPetDnagradeTpl()
  return _getTpl(CONFIG.petDnagradeTpl)
end

function this:getPetGradeTpl()
  return _getTpl(CONFIG.petGradeTpl)
end

function this:getStaminaChestDropTpl()
  return _getTpl(CONFIG.staminaChestDropTpl)
end

function this:getHeroInterimTpl()
  return _getTpl(CONFIG.heroInterimTpl)
end

function this:getOptionDataDisplayTpl()
  return _getTpl(CONFIG.optionDataDisplayTpl)
end

function this:getElementTypeTpl()
  return _getTpl(CONFIG.elementTypeTpl)
end

function this:getPetFeatureTpl()
  return _getTpl(CONFIG.petFeatureTpl)
end

function this:getProfessionTpl()
  return _getTpl(CONFIG.professionTpl)
end

function this:getUiDecorateTpl()
  return _getTpl(CONFIG.uiDecorateTpl)
end

function this:getCommonItemChangeTpl()
  return _getTpl(CONFIG.commonItemChangeTpl)
end

function this:getFormationTpl()
  return _getTpl(CONFIG.formationTpl)
end

function this:getFishBaitTpl()
  return _getTpl(CONFIG.fishBaitTpl)
end

function this:getFishBaitTpl()
  return _getTpl(CONFIG.fishBaitTpl)
end

function this:getPhotographParamTpl()
  return _getTpl(CONFIG.photographParamTpl)
end

function this:getPhotographGroupTpl()
  return _getTpl(CONFIG.photographGroupTpl)
end

function this:getPhotoTemplateTpl()
  return _getTpl(CONFIG.photoTemplateTpl)
end

function this:getRouletteTabTpl()
  return _getTpl(CONFIG.rouletteTabTpl)
end

function this:getPetHomeTalentTpl()
  return _getTpl(CONFIG.petHomeTalentTpl)
end

function this:getPetHomeSizeTpl()
  return _getTpl(CONFIG.petHomeSizeTpl)
end

function this:getHomeLaborCapacityTpl()
  return _getTpl(CONFIG.homeLaborCapacityTpl)
end

function this:getHomeLaborTypeTpl()
  return _getTpl(CONFIG.homeLaborTypeTpl)
end

function this:getHomeLaborTarinTpl()
  return _getTpl(CONFIG.homeLaborTrainTpl)
end

function this:getHomeLaborTrainConditionTpl()
  return _getTpl(CONFIG.homeLaborTrainConditionTpl)
end

function this:getHomeLaborEfficiencyTpl()
  return _getTpl(CONFIG.homeLaborEfficiencyTpl)
end

function this:getPetAccessoryRarityProductTpl()
  return _getTpl(CONFIG.petAccessoryRarityProductTpl)
end

function this:getPetLaborAccessoryExtraTpl()
  return _getTpl(CONFIG.petLaborAccessoryExtraTpl)
end

function this:getPetLaborAccessoryExtraRateDescTpl()
  return _getTpl(CONFIG.petLaborAccessoryExtraRateDescTpl)
end

function this:getPetLaborTrainExpTpl()
  return _getTpl(CONFIG.petLaborTrainExpTpl)
end

function this:getHomeTalentTpl()
  return _getTpl(CONFIG.homeTalentTpl)
end

function this:getProductsCollectionTypeTpl()
  return _getTpl(CONFIG.productsCollectionTypeTpl)
end

function this:getHomeBuffTpl()
  return _getTpl(CONFIG.homeBuffTpl)
end

function this:getCommonItemUseTypeTpl()
  return _getTpl(CONFIG.commonItemUseTypeTpl)
end

function this:getCommonItemBagTypeTpl()
  return _getTpl(CONFIG.commonItemBagTypeTpl)
end

function this:getGameEventsTpl()
  return _getTpl(CONFIG.gameEventsTpl)
end

function this:getGameEventsPartygameTpl()
  return _getTpl(CONFIG.gameEventsPartygameTpl)
end

function this:getGameEventsKiboSurveyTpl()
  return _getTpl(CONFIG.gameEventsKiboSurveyTpl)
end

function this:getPartygameSkillTpl()
  return _getTpl(CONFIG.partygameSkillTpl)
end

function this:getGameActivityTpl()
  return _getTpl(CONFIG.gameActivityTpl)
end

function this:getGameActivityPlayTpl()
  return _getTpl(CONFIG.gameActivityPlayTpl)
end

function this:getGameActivityLevelTpl()
  return _getTpl(CONFIG.gameActivityLevelTpl)
end

function this:getGameActivityLevelGroupTpl()
  return _getTpl(CONFIG.gameActivityLevelGroupTpl)
end

function this:getGameEventsDayAttendanceTpl()
  return _getTpl(CONFIG.gameEventsDayAttendanceTpl)
end

function this:getHomeBlockTpl()
  return _getTpl(CONFIG.homeBlockTpl)
end

function this:getTaskItemTpl()
  return _getTpl(CONFIG.taskItemTpl)
end

function this:getSystemFilterTpl()
  return _getTpl(CONFIG.systemFilterTpl)
end

function this:getSystemFiltertypeTpl()
  return _getTpl(CONFIG.systemFiltertypeTpl)
end

function this:getHomeRanchTpl()
  return _getTpl(CONFIG.homeRanchTpl)
end

function this:getHomeDropTpl()
  return _getTpl(CONFIG.homeDropTpl)
end

function this:getSystemSorttypeTpl()
  return _getTpl(CONFIG.systemSorttypeTpl)
end

function this:getSystemFiltercontentTpl()
  return _getTpl(CONFIG.systemFiltercontentTpl)
end

function this:getTipsTpl()
  return _getTpl(CONFIG.tipsTpl)
end

function this:getTipsGroupTpl()
  return _getTpl(CONFIG.tipsGroupTpl)
end

function this:getHomeTechnologyTpl()
  return _getTpl(CONFIG.homeTechnologyTpl)
end

function this:getHomeTechnologyLevelTpl()
  return _getTpl(CONFIG.homeTechnologyLevelTpl)
end

function this:getHomeTechnologyTabTpl()
  return _getTpl(CONFIG.homeTechnologyTabTpl)
end

function this:getHomeTechnologyTreeTpl()
  return _getTpl(CONFIG.homeTechnologyTreeTpl)
end

function this:getHomeTechnologyTypeTpl()
  return _getTpl(CONFIG.homeTechnologyTypeTpl)
end

function this:getFoodGroupTpl()
  return _getTpl(CONFIG.foodGroupTpl)
end

function this:getFoodMaterialGroupTpl()
  return _getTpl(CONFIG.foodMaterialGroupTpl)
end

function this:getCommonTabTpl()
  return _getTpl(CONFIG.commonTabTpl)
end

function this:getWorldInteractTpl()
  return _getTpl(CONFIG.worldInteractTpl)
end

function this:getHomeBuffCountTpl()
  return _getTpl(CONFIG.homeBuffCountTpl)
end

function this:getHomeLevelShowTpl()
  return _getTpl(CONFIG.homeLevelShowTpl)
end

function this:getGuideConditionTpl()
  return _getTpl(CONFIG.guideConditionTpl)
end

function this:getCharVoiceHeroTabTpl()
  return _getTpl(CONFIG.charVoiceHeroTabTpl)
end

function this:getCharVoiceWordsBattleTpl()
  return _getTpl(CONFIG.charVoiceWordsBattleTpl)
end

function this:getHomeBuildingNumTpl()
  return _getTpl(CONFIG.homeBuildingNumTpl)
end

function this:getTaskTypeTpl()
  return _getTpl(CONFIG.taskTypeTpl)
end

function this:getAccessorySubParameterTpl()
  return _getTpl(CONFIG.accessorySubParameterTpl)
end

function this:getTaskConditionTpl()
  return _getTpl(CONFIG.taskConditionTpl)
end

function this:getPetVoiceWordsSystemTpl()
  return _getTpl(CONFIG.petVoiceWordsSystemTpl)
end

function this:getMultiDungeonTpl()
  return _getTpl(CONFIG.multiDungeonTpl)
end

function this:getMultiDungeonGroupTpl()
  return _getTpl(CONFIG.multiDungeonGroupTpl)
end

function this:getDungeonCrisisCrusadeTpl()
  return _getTpl(CONFIG.dungeonCrisisCrusadeTpl)
end

function this:getDungeonCrisisCrusadeDiffTagTpl()
  return _getTpl(CONFIG.dungeonCrisisCrusadeDiffTagTpl)
end

function this:getWorldItemTpl()
  return _getTpl(CONFIG.worldItemTpl)
end

function this:getCommonPetSatietyTpl()
  return _getTpl(CONFIG.commonPetSatietyTpl)
end

function this:getTutorialTpl()
  return _getTpl(CONFIG.tutorialTpl)
end

function this:getTutorialTypeTpl()
  return _getTpl(CONFIG.tutorialTypeTpl)
end

function this:getTutorialActivityTpl()
  return _getTpl(CONFIG.tutorialActivityTpl)
end

function this:getKiboDuelTpl()
  return _getTpl(CONFIG.kiboDuelTpl)
end

function this:getKiboDuelPvpTpl()
  return _getTpl(CONFIG.kiboDuelPvpTpl)
end

function this:getKiboDuelMapTpl()
  return _getTpl(CONFIG.kiboDuelMapTpl)
end

function this:getTaskStepTpl()
  return _getTpl(CONFIG.taskStepTpl)
end

function this:getTaskTargetTpl()
  return _getTpl(CONFIG.taskTargetTpl)
end

function this:getCharVoiceWordsPetTpl()
  return _getTpl(CONFIG.charVoiceWordsPetTpl)
end

function this:getUiViewTpl()
  return _getTpl(CONFIG.uiViewTpl)
end

function this:getDungeonGroupTpl()
  return _getTpl(CONFIG.dungeonGroupTpl)
end

function this:getPetCatchItemTpl()
  return _getTpl(CONFIG.petCatchItemTpl)
end

function this:getGuideIconTpl()
  return _getTpl(CONFIG.guideIconTpl)
end

function this:getKiBoDuelChapterTpl()
  return _getTpl(CONFIG.kiboDuelChapterTpl)
end

function this:getKiBoDuelGroupTpl()
  return _getTpl(CONFIG.kiboDuelGroupTpl)
end

function this:getNoviceTaskTpl()
  return _getTpl(CONFIG.noviceTaskTpl)
end

function this:getNoviceTaskGroupTpl()
  return _getTpl(CONFIG.noviceTaskGroupTpl)
end

function this:getActivityTabTpl()
  return _getTpl(CONFIG.activityTabTpl)
end

function this:getChargeSatietyTpl()
  return _getTpl(CONFIG.chargeSatietyTpl)
end

function this:getBattleTagTpl()
  return _getTpl(CONFIG.battleTagTpl)
end

function this:getDetailsTpl()
  return _getTpl(CONFIG.detailsTpl)
end

function this:getDetailsTabTpl()
  return _getTpl(CONFIG.detailsTabTpl)
end

function this:getFightProhibitTpl()
  return _getTpl(CONFIG.fightProhibitTpl)
end

function this:getPlotStartPerformanceTpl()
  return _getTpl(CONFIG.plotStartPerformanceTpl)
end

function this:getHomeBuildingRemoteUpTpl()
  return _getTpl(CONFIG.homeBuildingRemoteUpTpl)
end

function this:getGroupsTpl()
  return _getTpl(CONFIG.groupsTpl)
end

function this:getTrialPetTpl()
  return _getTpl(CONFIG.trialPetTpl)
end

function this:getMountSaddleTpl()
  return _getTpl(CONFIG.mountSaddleTpl)
end

function this:getGuideConditionTypeTpl()
  return _getTpl(CONFIG.guideConditionTypeTpl)
end

function this:getPetFavorabilityTpl()
  return _getTpl(CONFIG.petFavorabilityTpl)
end

function this:getTalentRankTpl()
  return _getTpl(CONFIG.talentRankTpl)
end

function this:getTalentRuneTpl()
  return _getTpl(CONFIG.talentRuneTpl)
end

function this:getPetRaceTpl()
  return _getTpl(CONFIG.petRaceTpl)
end

function this:getIntroductionTpl()
  return _getTpl(CONFIG.introductionTpl)
end

function this:getFrameTextureTpl()
  return _getTpl(CONFIG.frameTextureTpl)
end

function this:getCommonItemTypeTpl()
  return _getTpl(CONFIG.commonItemTypeTpl)
end

function this:getExploreTpl()
  return _getTpl(CONFIG.exploreTpl)
end

function this:getPetInterimTpl()
  return _getTpl(CONFIG.petInterimTpl)
end

function this:getAccessoryInterimTpl()
  return _getTpl(CONFIG.accessoryInterimTpl)
end

function this:getExploreLevelTpl()
  return _getTpl(CONFIG.exploreLevelTpl)
end

function this:getUiTopBarTpl()
  return _getTpl(CONFIG.uiTopBarTpl)
end

function this:getCollectionToolTpl()
  return _getTpl(CONFIG.collectionToolTpl)
end

function this:getCollectionToolTypeTpl()
  return _getTpl(CONFIG.collectionToolTypeTpl)
end

function this:getKiboDuelTagTpl()
  return _getTpl(CONFIG.kiboDuelTagTpl)
end

function this:getPetSkillTpl()
  return _getTpl(CONFIG.petSkillTpl)
end

function this:getPetSkillTypeTpl()
  return _getTpl(CONFIG.petSkillTypeTpl)
end

function this:getGameEventsNoviceTpl()
  return _getTpl(CONFIG.gameEventsNoviceTpl)
end

function this:getMediaPackTplTpl()
  return _getTpl(CONFIG.mediaPackTpl)
end

function this:getPlayercardDressListTpl()
  return _getTpl(CONFIG.playercardDressListTpl)
end

function this:getPlayercardDressTpl()
  return _getTpl(CONFIG.playercardDressTpl)
end

function this:getItemRewardFormTpl()
  return _getTpl(CONFIG.itemRewardFormTpl)
end

function this:getReasonItemnumChangeTpl()
  return _getTpl(CONFIG.reasonItemnumChangeTpl)
end

function this:getWorldEntityTipsTpl()
  return _getTpl(CONFIG.worldEntityTipsTpl)
end

function this:getCommonBannerTpl()
  return _getTpl(CONFIG.commonBannerTpl)
end

function this:getCommonWorldRepairTpl()
  return _getTpl(CONFIG.commonWorldRepairTpl)
end

function this:getKiboDuelKoTpl()
  return _getTpl(CONFIG.kiboDuelKoTpl)
end

function this:getTrainTaskTpl()
  return _getTpl(CONFIG.trainTaskTpl)
end

function this:getDungeonEntrustTpl()
  return _getTpl(CONFIG.dungeonEntrustTpl)
end

function this:getDungeonMaterialTpl()
  return _getTpl(CONFIG.dungeonMaterialTpl)
end

function this:getDungeonMaterialTypeTpl()
  return _getTpl(CONFIG.dungeonMaterialTypeTpl)
end

function this:getDungeonMaterialDiffTpl()
  return _getTpl(CONFIG.dungeonMaterialDiffTpl)
end

function this:getDungeonEntrustDifficultyTpl()
  return _getTpl(CONFIG.dungeonEntrustDifficultyTpl)
end

function this:getDungeonEntrustGroupTpl()
  return _getTpl(CONFIG.dungeonEntrustGroupTpl)
end

function this:getDungeonEntrustRewardTpl()
  return _getTpl(CONFIG.dungeonEntrustRewardTpl)
end

function this:getDungeonEntrustTypeTpl()
  return _getTpl(CONFIG.dungeonEntrustTypeTpl)
end

function this:getDungeonEntrustTagTpl()
  return _getTpl(CONFIG.dungeonEntrustTagTpl)
end

function this:getDungeonEntrustAreaTpl()
  return _getTpl(CONFIG.dungeonEntrustAreaTpl)
end

function this:getTrainTaskTpl()
  return _getTpl(CONFIG.trainTaskTpl)
end

function this:getTrainTaskGroupTpl()
  return _getTpl(CONFIG.trainTaskGroupTpl)
end

function this:getCommonJumpTpl()
  return _getTpl(CONFIG.commonJumpTpl)
end

function this:getKiboDuelTaskTpl()
  return _getTpl(CONFIG.kiboDuelTaskTpl)
end

function this:getTalentRuneComposeTpl()
  return _getTpl(CONFIG.talentRuneComposeTpl)
end

function this:getIconographyLevelTpl()
  return _getTpl(CONFIG.iconographyLevelTpl)
end

function this:getIconographyTaskTpl()
  return _getTpl(CONFIG.iconographyTaskTpl)
end

function this:getIconographyTypeTpl()
  return _getTpl(CONFIG.iconographyTypeTpl)
end

function this:getPhotographPicTpl()
  return _getTpl(CONFIG.photographPicTpl)
end

function this:getPhotographTextTpl()
  return _getTpl(CONFIG.photographTextTpl)
end

function this:getPhotographTypeTpl()
  return _getTpl(CONFIG.photographTypeTpl)
end

function this:getWorldCollectingTpl()
  return _getTpl(CONFIG.worldCollectingTpl)
end

function this:getWorldCollectingTypeTpl()
  return _getTpl(CONFIG.worldCollectingTypeTpl)
end

function this:getKiboDuelMapTpl()
  return _getTpl(CONFIG.kiboDuelMapTpl)
end

function this:getGameeventssubitemTpl()
  return _getTpl(CONFIG.gameeventssubitemTpl)
end

function this:gethomeDormFurnitureTpl()
  return _getTpl(CONFIG.homeDormFurnitureTpl)
end

function this:gethomeDormFurnitureRecommendTpl()
  return _getTpl(CONFIG.homeDormFurnitureRecommendTpl)
end

function this:getGameEventsRewardTpl()
  return _getTpl(CONFIG.gameEventsRewardTpl)
end

function this:getGameEventsRewardGroupTpl()
  return _getTpl(CONFIG.gameEventsRewardGroupTpl)
end

function this:getTalentRankReward()
  return _getTpl(CONFIG.talentRankReward)
end

function this:getGameEventsKiboDuelTpl()
  return _getTpl(CONFIG.gameEventsKiboDuelTpl)
end

function this:getGameEventsDoubleDropTpl()
  return _getTpl(CONFIG.gameEventsDoubleDropTpl)
end

function this:getLibraryBranchTpl()
  return _getTpl(CONFIG.libraryBranchTpl)
end

function this:getLibraryCategoryTpl()
  return _getTpl(CONFIG.libraryCategoryTpl)
end

function this:getLibrarySeriesTpl()
  return _getTpl(CONFIG.librarySeriesTpl)
end

function this:getLibraryReadingsTpl()
  return _getTpl(CONFIG.libraryReadingsTpl)
end

function this:getWorldDifficultyCityTpl()
  return _getTpl(CONFIG.worldDifficultyCityTpl)
end

function this:getSmeltReturnTpl()
  return _getTpl(CONFIG.smeltReturnTpl)
end

function this:getReputationLevelTpl()
  return _getTpl(CONFIG.reputationLevelTpl)
end

function this:getPhotoSpaceCaseTpl()
  return _getTpl(CONFIG.photoSpaceCaseTpl)
end

function this:getSituationTabTpl()
  return _getTpl(CONFIG.situationTabTpl)
end

function this:getRogueActivityTpl()
  return _getTpl(CONFIG.rogueActivityTpl)
end

function this:getCommonReportUserTpl()
  return _getTpl(CONFIG.commonReportUserTpl)
end

function this:getGameEventsKiboDuelMapTpl()
  return _getTpl(CONFIG.gameEventsKiboDuelMapTpl)
end

function this:getGameEventsEntrustEnterTpl()
  return _getTpl(CONFIG.gameEventsEntrustEnterTpl)
end

function this:getCommonPlayerInformationTpl()
  return _getTpl(CONFIG.commonPlayerInformationTpl)
end

function this:getSystemVoiceUnitruleTpl()
  return _getTpl(CONFIG.systemVoiceUnitruleTpl)
end

function this:getSituationObjectsTpl()
  return _getTpl(CONFIG.situationObjectsTpl)
end

function this:geticonographyLevelTpl()
  return _getTpl(CONFIG.iconographyLevelTpl)
end

function this:getChatChannelListTpl()
  return _getTpl(CONFIG.chatChannelListTpl)
end

function this:getChatListTpl()
  return _getTpl(CONFIG.chatListTpl)
end

function this:getSituationSceneTpl()
  return _getTpl(CONFIG.situationSceneTpl)
end

function this:getGameActivityIntegralTpl()
  return _getTpl(CONFIG.gameActivityIntegralTpl)
end

function this:getMedicineTpl()
  return _getTpl(CONFIG.medicineTpl)
end

function this:getAccessoryScoreTpl()
  return _getTpl(CONFIG.accessoryScoreTpl)
end

function this:getAccessoryRecommendTpl()
  return _getTpl(CONFIG.accessoryRecommendTpl)
end

function this:getAccessoryProductTpl()
  return _getTpl(CONFIG.accessoryProductTpl)
end

function this:getKiboDuelAreaLevelTpl()
  return _getTpl(CONFIG.kiboDuelAreaLevelTpl)
end

function this:getKiboDuelAreaTypeTpl()
  return _getTpl(CONFIG.kiboDuelAreaTypeTpl)
end

function this:getKiboDuelSkillTpl()
  return _getTpl(CONFIG.kiboDuelSkillTpl)
end

function this:getIllustratedhandbookMainTpl()
  return _getTpl(CONFIG.illustratedhandbookMainTpl)
end

function this:getMainBottomButtonsTpl()
  return _getTpl(CONFIG.mainBottomButtonsTpl)
end

function this:getWorldBreakableOverwriteTpl()
  return _getTpl(CONFIG.worldBreakableOverwriteTpl)
end

function this:getPlayableTypeTpl()
  return _getTpl(CONFIG.playableTypeTpl)
end

function this:getPlayableTpl()
  return _getTpl(CONFIG.playableTpl)
end

function this:getDungeonEntrustRewardChance()
  return _getTpl(CONFIG.dungeonEntrustRewardChance)
end

function this:getJourneyTypeTpl()
  return _getTpl(CONFIG.journeyTypeTpl)
end

function this:getJourneyTaskTpl()
  return _getTpl(CONFIG.journeyTaskTpl)
end

function this:getJourneyGroupTpl()
  return _getTpl(CONFIG.journeyGroupTpl)
end

function this:getNestShopTpl()
  return _getTpl(CONFIG.nestcoopShopShow)
end

function this:getNestcoopDifficultShowTpl()
  return _getTpl(CONFIG.nestcoopDifficultShowTpl)
end

function this:getNestcoopLevelTpl()
  return _getTpl(CONFIG.nestcoopLevelTpl)
end

function this:getCharKiboTpl()
  return _getTpl(CONFIG.charKiboTpl)
end

function this:getPetSkinTpl()
  return _getTpl(CONFIG.petSkinTpl)
end

function this:getPetPixelTagTpl()
  return _getTpl(CONFIG.petPixelTagTpl)
end

function this:getPetStarSoulTpl()
  return _getTpl(CONFIG.petStarSoulTpl)
end

function this:getFormationPetSellTpl()
  return _getTpl(CONFIG.formationPetSellTpl)
end

function this:getHomeDormItemTpl()
  return _getTpl(CONFIG.homeDormItemTpl)
end

function this:getGmCustomizedtextListTpl()
  return _getTpl(CONFIG.gmCustomizedtextListTpl)
end

function this:getdungeonWeeklyTpl()
  return _getTpl(CONFIG.dungeonWeeklyTpl)
end

return this
