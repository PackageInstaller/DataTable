local key = {
  ID = 1,
  Title = 2,
  SubTitle = 3,
  Intro = 4,
  ShowAnim = 5,
  ShowAnimTime = 6,
  HideAnim = 7,
  HideAnimTime = 8,
  ExitVoice = 9
}
local common = {
  "uianim_UICN9SouthSeaIntro_in",
  "uianim_UICN9SouthSeaIntro_out",
  "str_nexplore_intro_title",
  "str_nexplore_intro_",
  "str_cn13_PerfectPuzzle_intro_title",
  "str_cn13_PerfectPuzzle_intro_"
}
local config = {
  UIN22Entrust_Intro = {
    "UIN22Entrust_Intro",
    "str_n22_entrust_stage_intro_title",
    nil,
    "str_n22_entrust_stage_intro_"
  },
  UIN23Intro = {
    "UIN23Intro",
    "str_n23_activity_intro_title",
    nil,
    "str_n23_activity_intro_"
  },
  UIN24Intro = {
    "UIN24Intro",
    "str_n24_activity_intro_title",
    nil,
    "str_n24_activity_intro_"
  },
  UIN24ShopIntro = {
    "UIN24ShopIntro",
    "str_n24_shop_intro_title",
    nil,
    "str_n24_shop_intro_"
  },
  UIN25Intro = {
    "UIN25Intro",
    "str_n25_activity_intro_title",
    nil,
    "str_n25_activity_intro_"
  },
  UIN25VampireMainIntro = {
    "UIN25VampireMainIntro",
    "str_n25_vampire_main_intro_title",
    nil,
    "str_n25_vampire_main_intro_"
  },
  UIN25VampireTalentIntro = {
    "UIN25VampireTalentIntro",
    "str_n25_vampire_talent_intro_title",
    nil,
    "str_n25_vampire_talent_intro_"
  },
  UIN25IdolLoginIntro = {
    "UIN25IdolLoginIntro",
    "str_n25_idol_y_login_intro_title",
    nil,
    "str_n25_idol_y_login_intro_"
  },
  UIN25IdolGameIntro = {
    "UIN25IdolGameIntro",
    "str_n25_idol_game_intro_title",
    nil,
    "str_n25_idol_game_intro_"
  },
  UIN26Intro = {
    "UIN26Intro",
    "str_n26_activity_intro_title",
    nil,
    "str_n26_activity_intro_"
  },
  UIN26CookIntro = {
    "UIN26CookIntro",
    "str_n26_activity_cook_intro_title",
    nil,
    "str_n26_activity_cook_intro_"
  },
  UIN27Intro = {
    "UIN27Intro",
    "str_n27_intro_title",
    nil,
    "str_n27_intro_"
  },
  UIN27LotteryIntro = {
    "UIN27LotteryIntro",
    "str_n27_lottery_intro_title",
    nil,
    "str_n27_lottery_intro_"
  },
  UIN27DiffLevelIntro = {
    "UIN27DiffLevelIntro",
    "str_n27_difflevel_intro_title",
    nil,
    "str_n27_difflevel_intro_"
  },
  UIActivityValentineIntro = {
    "UIActivityValentineIntro",
    "str_n27_valentine_y_letter_intro_title",
    nil,
    "str_n27_valentine_y_letter_intro_"
  },
  UIN27MiniGameIntro = {
    "UIN27MiniGameIntro",
    "str_n27_poststation_intro_title",
    nil,
    "str_n27_poststation_intro_"
  },
  UIN28Intro = {
    "UIN28Intro",
    "str_n28_activity_intro_title",
    nil,
    "str_n28_intro_"
  },
  UIN28GronruGameIntro = {
    "UIN28GronruGameIntro",
    "str_n28_gronru_minigame_activity_intro_title",
    nil,
    "str_n28_gronru_minigame_intro_",
    nil,
    nil,
    nil,
    nil,
    1668
  },
  UIN29DetectiveLoginIntro = {
    "UIN29DetectiveLoginIntro",
    "str_n29_detective_login_intro_title",
    nil,
    "str_n29_detective_login_intro_"
  },
  UIN29Intro = {
    "UIN29Intro",
    "str_n29_intro_title",
    nil,
    "str_n29_intro_"
  },
  UIN29DiffLevelIntro = {
    "UIN29DiffLevelIntro",
    "str_n29_difflevel_intro_title",
    nil,
    "str_n29_difflevel_intro_"
  },
  UIN29ShopIntro = {
    "UIN29ShopIntro",
    "str_n29_shop_intro_title",
    nil,
    "str_n29_shop_intro_"
  },
  UIN29DetectiveMapIntro = {
    "UIN29DetectiveMapIntro",
    "str_n29_detective_map_intro_title",
    nil,
    "str_n29_detective_map_intro_"
  },
  UIN30Intro = {
    "UIN30Intro",
    "str_n30_activity_intro_title",
    nil,
    "str_n30_activity_intro_"
  },
  UIN30EntrustIntro = {
    "UIN30EntrustIntro",
    "str_n30_entrust_intro_title",
    nil,
    "str_n30_entrust_intro_"
  },
  UIN30ShopIntro = {
    "UIN30ShopIntro",
    "str_n30_activity_shop_intro_title",
    nil,
    "str_n30_activity_shop_intro_",
    nil,
    nil,
    "uieff_UIN30ShopIntro_out",
    167
  },
  UIN30TrainingIntro = {
    "UIN30TrainingIntro",
    "str_n30_train_activity_intro_title",
    nil,
    "str_n30_train_activity_intro_",
    "uieff_UIN30TrainingIntro_in",
    500,
    "uieff_UIN30TrainingIntro_out",
    167
  },
  UIActivityBlackBoxIntro = {
    "UIActivityBlackBoxIntro",
    "str_cn7_n36_blackbox_intro_title",
    nil,
    "str_cn7_n36_blackbox_intro_"
  },
  UIN31Intro = {
    "UIN31Intro",
    "str_n31_activity_intro_title",
    nil,
    "str_n31_activity_intro_"
  },
  UIPopStarIntro = {
    "UIPopStarIntro",
    "str_n31_popstar_intro_title",
    nil,
    "str_n31_popstar_intro_"
  },
  UIN32DiffLevelIntro = {
    "UIN32DiffLevelIntro",
    "str_n32_difflevel_intro_title",
    nil,
    "str_n32_difflevel_intro_"
  },
  UIN32ShopIntro = {
    "UIN32ShopIntro",
    "str_n32_activity_shop_intro_title",
    nil,
    "str_n32_activity_shop_intro_"
  },
  UIN32Intro = {
    "UIN32Intro",
    "str_n32_activity_intro_title",
    nil,
    "str_n32_activity_intro_"
  },
  UIN32MultilineMainIntro = {
    "UIN32MultilineMainIntro",
    "str_n32_multiline_main_intro_title",
    nil,
    "str_n32_multiline_main_intro_"
  },
  UIN32MultilineMapIntro = {
    "UIN32MultilineMapIntro",
    "str_n32_multiline_map_intro_title",
    nil,
    "str_n32_multiline_map_intro_"
  },
  UIN33Intro = {
    "UIN33Intro",
    "str_n33_activity_intro_title",
    nil,
    "str_n33_activity_intro_"
  },
  UIN33DateIntro = {
    "UIN33DateIntro",
    "str_n33_date_intro_title",
    nil,
    "str_n33_date_intro_"
  },
  UIN33ShopIntro = {
    "UIN33ShopIntro",
    "str_n33_shop_intro_title",
    nil,
    "str_n33_shop_intro_"
  },
  UIActivityN33LevelIntro = {
    "UIActivityN33LevelIntro",
    "str_n33_level_intro_title",
    nil,
    "str_n33_level_intro_"
  },
  UIN34TaskIntro = {
    "UIN34TaskIntro",
    "str_n34_task_intro_title",
    nil,
    "str_n34_task_intro_"
  },
  UIN34Intro = {
    "UIN34Intro",
    "str_n34_activity_intro_title",
    nil,
    "str_n34_activity_intro_"
  },
  UICN6N35Intro = {
    "UICN6N35Intro",
    "str_cn6&n35_intro_title",
    nil,
    "str_cn6&n35_intro_",
    "uieff_UICN6N35Intro_in",
    220,
    "uieff_UICN6N35Intro_out",
    60
  },
  UICN6N35_Smelt_Intro = {
    "UICN6N35_Smelt_Intro",
    "str_cn6_n35_smelt_intro_title",
    nil,
    "str_cn6_n35_smelt_intro_"
  },
  UIFavourPetIntro = {
    "UIFavourPetIntro",
    "str_favour_pet_intro_title",
    nil,
    "str_favour_pet_intro_"
  },
  UIN37Intro = {
    "UIN37Intro",
    "str_n37_intro_title",
    nil,
    "str_n37_intro_"
  },
  UIN37HardIntro = {
    "UIN37HardIntro",
    "str_n37_hard_intro_title",
    nil,
    "str_n37_hard_intro_"
  },
  UISeasonS3BuildIntro = {
    "UISeasonS3BuildIntro",
    "str_season_s3_castle_intro_title",
    nil,
    "str_season_s3_castle_"
  },
  UICN9SouthSeaIntro = {
    "UICN9SouthSeaIntro",
    "str_cn9_SouthSea_intro_title",
    nil,
    "str_cn9_SouthSea_intro_",
    common[1],
    300,
    common[2],
    500
  },
  UIN38Intro = {
    "UIN38Intro",
    "str_n38_intro_title",
    nil,
    "str_n38_intro_"
  },
  UIN38IntroHard = {
    "UIN38IntroHard",
    "str_n38_hard_intro_title",
    nil,
    "str_n38_hard_intro_"
  },
  UIFavourPetVote2Intro = {
    "UIFavourPetVote2Intro",
    "str_favour_pet_vote2_intro_title",
    nil,
    "str_favour_pet_vote2_intro_"
  },
  UIN39Intro = {
    "UIN39Intro",
    "str_n39_intro_title",
    nil,
    "str_n39_intro_"
  },
  UIN39IntroHard = {
    "UIN39IntroHard",
    "str_n39_hard_intro_title",
    nil,
    "str_n39_hard_intro_"
  },
  UINExploreIntro = {
    "UINExploreIntro",
    common[3],
    nil,
    common[4]
  },
  UISimpleHauteCoutureIntro_fei = {
    "UISimpleHauteCoutureIntro_fei",
    "str_junior_skin_draw_cn11_intro_title",
    nil,
    "str_junior_skin_draw_cn11_intro_"
  },
  UISimpleHauteCoutureIntro_wle = {
    "UISimpleHauteCoutureIntro_wle",
    "str_junior_skin_draw_cn13_intro_title",
    nil,
    "str_junior_skin_draw_cn13_intro_"
  },
  UILuckLandEntry = {
    "UILuckLandEntry",
    "str_luckland_entry_title",
    nil,
    "str_luckland_entry_intro_"
  },
  UILuckLandLevel = {
    "UILuckLandLevel",
    "str_luckland_level_title",
    nil,
    "str_luckland_level_intro_"
  },
  UILuckLandCardBag = {
    "UILuckLandCardBag",
    "str_luckland_cardbag_title",
    nil,
    "str_luckland_cardbag_intro_"
  },
  UILuckLandBuildings = {
    "UILuckLandBuildings",
    "str_luckland_building1_title",
    nil,
    "str_luckland_building1_intro_"
  },
  UILuckLandMainGameController = {
    "UILuckLandMainGameController",
    "str_luckland_mainplay_title",
    nil,
    "str_luckland_mainplay_intro_"
  },
  UILuckLandGameSucPopUp = {
    "UILuckLandGameSucPopUp",
    "str_luckland_gamesuc_title",
    nil,
    "str_luckland_gamesuc_intro_"
  },
  UILuckLandRank = {
    "UILuckLandRank",
    "str_luckland_rank1_title",
    nil,
    "str_luckland_rank1_intro_"
  },
  UICN12N41Intro = {
    "UICN12N41Intro",
    "str_cn12_n41_intro_title",
    nil,
    "str_cn12_n41_intro_"
  },
  UICN12N41BlackIntro = {
    "UICN12N41BlackIntro",
    "str_cn12_n41_black_intro_title",
    nil,
    "str_cn12_n41_black_intro_"
  },
  UICollectCardIntr = {
    "UICollectCardIntr",
    "str_collect_card_open_intro_title",
    nil,
    "str_collect_card_open_intro_"
  },
  UIN0CookIntro = {
    "UIN0CookIntro",
    "str_n0_intro_title",
    nil,
    "str_n0_intro_"
  },
  UIActivityNewYearLuckBagIntr = {
    "UIActivityNewYearLuckBagIntr",
    "str_cn12_n41_luck_bag_intro_title",
    nil,
    "str_cn12_n41_luck_bag_intro_"
  },
  UIActivityCN13PerfectPuzzleEntryController = {
    "UIActivityCN13PerfectPuzzleEntryController",
    common[5],
    nil,
    common[6]
  },
  UICN13PerfectPuzzleMainGameController = {
    "UICN13PerfectPuzzleMainGameController",
    common[5],
    nil,
    common[6]
  },
  UIN43Intro = {
    "UIN43Intro",
    common[3],
    nil,
    common[4]
  },
  UISimpleHauteCoutureIntro_ged = {
    "UISimpleHauteCoutureIntro_ged",
    "str_junior_skin_draw_n44_intro_title",
    nil,
    "str_junior_skin_draw_n44_intro_"
  },
  UISendPetIntro = {
    "UISendPetIntro",
    "str_cn15_n44_6xpet_intro_title",
    nil,
    "str_cn15_n44_6xpet_intro_"
  },
  UICN16N45SeaNoteIntro = {
    "UICN16N45SeaNoteIntro",
    "str_cn9_cn16n45_SeaNote_intro_title",
    nil,
    "str_cn9_cn16n45_SeaNote_intro_",
    common[1],
    300,
    common[2],
    500
  },
  UISimpleHauteCoutureIntro_LYHT = {
    "UISimpleHauteCoutureIntro_LYHT",
    "str_junior_skin_draw_n47_intro_title",
    nil,
    "str_junior_skin_draw_n47_intro_"
  },
  UICN16N45Intro = {
    "UICN16N45Intro",
    "str_cn16_n45_activity_intro_title",
    nil,
    "str_cn16_n45_intro_"
  },
  UICN16N45HardLevel = {
    "UICN16N45HardLevel",
    "str_cn16_n45_hard_intro_title",
    nil,
    "str_cn16_n45_hard_intro_"
  },
  UIN4_CC_Intro = {
    "UIN4_CC_Intro",
    "str_crisis_contract_intro_title",
    nil,
    "str_crisis_contract_intro_"
  },
  UICN17N46Intro = {
    "UICN17N46Intro",
    "str_cn17_n46_intro_title",
    nil,
    "str_cn17_n46_intro_"
  },
  UICN17N46HardLevel = {
    "UICN17N46HardLevel",
    "str_cn17_n46_hard_intro_title",
    nil,
    "str_cn17_n46_hard_intro_"
  },
  UICN18N47Intro = {
    "UICN18N47Intro",
    "str_cn18_n47_intro_title",
    nil,
    "str_cn18_n47_intro_"
  },
  UICN18N47HardLevel = {
    "UICN18N47HardLevel",
    "str_cn18_n47_hard_intro_title",
    nil,
    "str_cn18_n47_hard_intro_"
  },
  UIN48Intro = {
    "UIN48Intro",
    "str_n48_intro_title",
    nil,
    "str_n48_intro_"
  },
  UIN48HardLevel = {
    "UIN48HardLevel",
    "str_n48_hard_intro_title",
    nil,
    "str_n48_hard_intro_"
  },
  UISimpleHauteCoutureIntro_ls = {
    "UISimpleHauteCoutureIntro_ls",
    "str_junior_skin_draw_cn20&n49_intro_title",
    nil,
    "str_junior_skin_draw_cn20&n49_intro_"
  },
  UICN20N49Intro = {
    "UICN20N49Intro",
    "str_cn20_n49_intro_title",
    nil,
    "str_cn20_n49_intro_"
  },
  UICN20N49TalentIntro = {
    "UICN20N49TalentIntro",
    "str_cn20_n49_Talentintro_title",
    nil,
    "str_cn20_n49_Talentintro_"
  },
  UICN20N49AlchemyIntro = {
    "UICN20N49AlchemyIntro",
    "str_cn20_n49_AlchemyIntro_title",
    nil,
    "str_cn20_n49_AlchemyIntro_"
  },
  UICN20N49AlchemyShopIntro = {
    "UICN20N49AlchemyShopIntro",
    "str_cn20_n49_AlchemyShopIntro_title",
    nil,
    "str_cn20_n49_AlchemyShopIntro_"
  },
  UICN20N49TreeIntro = {
    "UICN20N49TreeIntro",
    "str_cn20_n49_TreeIntro_title",
    nil,
    "str_cn20_n49_TreeIntro_"
  },
  UICN21N50Intro = {
    "UICN21N50Intro",
    "str_cn21_n50_intro_title",
    nil,
    "str_cn21_n50_intro_"
  },
  UICN21N50HardLevel = {
    "UICN21N50HardLevel",
    "str_cn21_n50_hard_intro_title",
    nil,
    "str_cn21_n50_hard_intro_"
  },
  UICN22N51Intro = {
    "UICN22N51Intro",
    "str_cn22_n51_intro_title",
    nil,
    "str_cn22_n51_intro_"
  },
  UICN22N51HardLevel = {
    "UICN22N51HardLevel",
    "str_cn22_n51_hard_intro_title",
    nil,
    "str_cn22_n51_hard_intro_"
  },
  UISimpleHauteCoutureIntro_S = {
    "UISimpleHauteCoutureIntro_S",
    "str_junior_skin_draw_n51_intro_title",
    nil,
    "str_junior_skin_draw_n51_intro_"
  }
}
return config, "ID", key
