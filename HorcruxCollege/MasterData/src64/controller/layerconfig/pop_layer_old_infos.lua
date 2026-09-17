return {
	HorcruxInfoLayer = {
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.HorcruxInfoLayerNew")

			return (HorcruxInfoLayerNew:create(...))
		end,
		textures = {
			"HorcruxInfo",
			"HorcruxSelectLayer"
		}
	},
	HorcruxSelectLayer = {
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.HorcruxSelectLayer")

			return (HorcruxSelectLayer:create(...))
		end,
		textures = {
			"HorcruxSelectLayer",
			"HorcruxLayer"
		}
	},
	BattleArrayLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.BattleArrayLayerNew")

			return (BattleArrayLayerNew:create(...))
		end,
		textures = {
			"Array"
		}
	},
	SpecialArrayLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.BattleArrayLayerNew")
			print("::::::::::")

			return (SpecialArrayLayer:create(...))
		end,
		textures = {
			"Array"
		}
	},
	ExploreArrayLayer = {
		hideUI = true,
		bg = LABEL_BG,
		createLayer = function(...)
			require("view.Layer.BattleArrayLayerNew")

			return (ExploreArrayLayer:create(...))
		end
	},
	DormRoomLayer = {
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.DormRoomLayer")

			return (DormRoomLayer:create(...))
		end,
		textures = {
			"SelectPlayerLayer"
		}
	},
	GirlSelectLayer = {
		bg = "mainScenebg/girlselectlayer_bg.png",
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.GirlSelectLayer")

			return (GirlSelectLayer:create(...))
		end,
		textures = {
			"GirlSelectLayer",
			"MainCityBgSelectLayer"
		}
	},
	MainCityBgSelectLayer = {
		hideUI = true,
		createLayer = function(...)
			return (require("view.Layer.MainCityBgSelect.MainCityBgSelectLayer"):create(...))
		end,
		textures = {
			"MainCityBgSelectLayer"
		}
	},
	SoulsLayer = {
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.EquipLayer")

			return (SoulsPopLayer:create(...))
		end
	},
	ShowGirlSwitchLayer = {
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.ShowGirlSwitchLayer")

			return (ShowGirlSwitchLayer:create(...))
		end,
		textures = {
			"showGirlSwitchLayer"
		}
	},
	WeaponLayer = {
		hideUI = true,
		bg = HORCRUXBG,
		createLayer = function(...)
			require("view.Layer.WeaponLayer")

			return (WeaponLayer:create(...))
		end
	},
	PhotoWeaponLayer = {
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.WeaponLayer")

			return (WeaponLayer:createWithItemId(...))
		end
	},
	CookLayer = {
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.CookLayer")

			return (CookLayer:create(...))
		end
	},
	PhotoFileHelpGirlLayer = {
		bg = "mainScenebg/roledatabg.jpg",
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.PhotoFileHelpGirlLayer")

			return (PhotoFileHelpGirlLayer:create(...))
		end,
		textures = {
			"PhotoFile_helpGirl",
			"PhotoFile_weapon_frame",
			"PhotoFile_role_file",
			"PhotoFile_enemy_data"
		}
	},
	PublishnoticeLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.PublishnoticeLayer")

			return (PublishnoticeLayer:create(...))
		end,
		textures = {
			"PublishnoticeLayer"
		}
	},
	SignLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.SignLayer")

			return (SignLayer:create(...))
		end,
		textures = {
			"sign"
		}
	},
	SignLayerNew = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.SignLayerNew"):create(...))
		end,
		textures = {
			"SignLayerNew"
		}
	},
	DropDetailsLayer = {
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.DropDetailsLayer")

			return (DropDetailsLayer:create(...))
		end,
		textures = {
			"DropItemDisplay"
		}
	},
	CommonFlopDropDetailsLayer = {
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.CommonFlopDropDetailsLayer")

			return (CommonFlopDropDetailsLayer:create(...))
		end,
		textures = {
			"CommonFlopDropDetailsLayer"
		}
	},
	SoulsLayer = {
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.EquipLayer")

			return (SoulsLayer:create(...))
		end
	},
	DetailsofHelpGirlLayer = {
		bg = "mainScenebg/roledatabg.jpg",
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.DetailsofHelpGirlLayer")

			return (DetailsofHelpGirlLayer:create(...))
		end,
		textures = {
			"PhotoFile_helpGirl",
			"PhotoFile_weapon_frame",
			"PhotoFile_role_file"
		}
	},
	WeaponLayerwihItemid = {
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.WeaponLayer")

			return (WeaponLayer:createWithItemId(...))
		end
	},
	EquipLayer = {
		hideUI = true,
		bg = MAINBG,
		createLayer = function(...)
			require("view.Layer.EquipLayer")

			return (SoulsLayer:create(...))
		end
	},
	ActivitySignLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Activity.ActivitySignLayer")

			return (ActivitySignLayer:create(...))
		end,
		textures = {
			"Activity_DaKaActivity"
		}
	},
	ActivityManageLayer = {
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.ActivityManageLayer")

			return (ActivityManageLayer:create(...))
		end
	},
	LabRdLayer = {
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.LabRdLayer")

			return (LabRdLayer:create(...))
		end
	},
	TopPlotListLayer = {
		hideUI = true,
		statusbarbg = "taskstatusbar",
		bg = TASK_BG,
		createLayer = function(...)
			require("view.Layer.TopPlotListLayer")

			return (TopPlotListLayer:create(...))
		end,
		textures = {
			"dailytask"
		}
	},
	AchievementListLayer = {
		hideUI = true,
		statusbarbg = "taskstatusbar",
		bg = TASK_BG,
		createLayer = function(...)
			require("view.Layer.AchievementListLayer")

			return (AchievementListLayer:create(...))
		end,
		textures = {
			"TaskLayer"
		}
	},
	SoulStrengthLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.SoulStrengthLayer")

			return (SoulStrengthLayer:create(...))
		end,
		textures = {
			"SoulStrengthLayer"
		}
	},
	FastSoulStrengthLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.FastSoulStrengthLayer")

			return (FastSoulStrengthLayer:create(...))
		end,
		textures = {
			"SoulStrengthLayer"
		}
	},
	ItemsPanel = {
		hideUI = true,
		createLayer = function(...)
			require("view.Sprite.ItemsPanel")

			return (ItemsPanel:create(...))
		end,
		textures = {
			"itempanel",
			"room_widget",
			"HorcruxLayer",
			"DormitoryFixturesLayer",
			"MarketLayer",
			"ItemsPanelPartsLayer",
			"HorcruxSelectLayer"
		}
	},
	ItemsPanelPartsLayer = {
		hideUI = true,
		createLayer = function(...)
			return (require("view.Sprite.ItemsPanelPartsLayer"):create(...))
		end,
		textures = {
			"itempanel",
			"room_widget",
			"HorcruxLayer",
			"DormitoryFixturesLayer",
			"MarketLayer",
			"ItemsPanelPartsLayer"
		}
	},
	ActivityLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.ActivityLayer")

			return (ActivityLayer:create(...))
		end
	},
	PvpResultLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.PvpResultLayer")

			return (PvpResultLayer:create(...))
		end,
		textures = {
			"PvpSettlement"
		}
	},
	PopAdventureResultLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopAdventureResultLayer:create(...))
		end,
		textures = {
			"ChapterSettlement"
		}
	},
	PopAutoChessUpStarLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopAutoChessUpStarLayer:create(...))
		end,
		textures = {
			"PopAutoChessUpStarLayer"
		}
	},
	PopMainLineResultLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopMainLineResultLayer:create(...))
		end,
		textures = {
			"ChapterSettlement"
		}
	},
	PopExploreResultLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopExploreResultLayer:create(...))
		end,
		textures = {
			"ChapterSettlement"
		}
	},
	PopSubsResultLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopSubsResultLayer:create(...))
		end,
		textures = {
			"ChapterSettlement"
		}
	},
	PopOldSubsResultLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopOldSubsResultLayer:create(...))
		end,
		textures = {
			"ChapterSettlement"
		}
	},
	PopAIAttackResultLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopAIAttackResultLayer:create(...))
		end,
		textures = {
			"ChapterSettlement"
		}
	},
	PopQuickFightInfo = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopQuickFightInfo:create(...))
		end
	},
	PopWeaponInfos = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopWeaponInfos:create(...))
		end
	},
	PopComponentInfos = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopComponentInfos:create(...))
		end
	},
	TipsLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.TipsLayer")

			return (TipsLayer:create(...))
		end
	},
	HandOfMidasLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.HandOfMidasLayer")

			return (HandOfMidasLayer:create(...))
		end,
		textures = {
			"midas"
		}
	},
	SchoolCinemalTalkLayer = {
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.SchoolCinemalTalkLayer")

			return (SchoolCinemalTalkLayer:create(...))
		end
	},
	PopHolidayConfirmLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopHolidayConfirmLayer:create(...))
		end,
		textures = {
			"holidayPop"
		}
	},
	PhotoFileRoleFileLayer = {
		bg = "mainScenebg/roledatabg.jpg",
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.PhotoFileRoleFileLayer")

			return (PhotoFileRoleFileLayer:create(...))
		end,
		textures = {
			"PhotoFile_weapon_frame",
			"PhotoFile_role_file",
			"PhotoFile_enemy_data",
			"PhotoFile_roleImage"
		}
	},
	PhotoFileRoleImageLayer = {
		bg = "mainScenebg/image_choose_background.png",
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.PhotoFileRoleImageLayer")

			return (PhotoFileRoleImageLayer:create(...))
		end,
		textures = {
			"soul_servant_info"
		}
	},
	BossFightPreviewLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.BossFightPreviewLayer")

			return (BossFightPreviewLayer:create(...))
		end,
		textures = {
			"BossFightPreview"
		}
	},
	LevelDetailLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.LevelDetailLayer")

			return (LevelDetailLayer:create(...))
		end,
		textures = {
			"LevelDetailLayer0",
			"LevelDetailLayer1"
		}
	},
	LevelDetailGroupLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.LevelDetailGroupLayer")

			return (LevelDetailGroupLayer:create(...))
		end,
		textures = {
			"LevelDetailLayer0",
			"LevelDetailLayer1"
		}
	},
	FightResultLayerNew = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.FightResultLayerNew")

			return (FightResultLayerNew:create(...))
		end,
		textures = {
			"fightResultNew"
		}
	},
	PopQuickGuaJiSure = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopQuickGuaJiSure:create(...))
		end,
		textures = {
			"fightResultNew"
		}
	},
	PopQuickGuaJiResult = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopQuickGuaJiResult:create(...))
		end,
		textures = {
			"fightResultNew"
		}
	},
	PopArenaDefendArray = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopArenaDefendArray:create(...))
		end
	},
	PopShowScoreArenaEnemyArray = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopShowScoreArenaEnemyArray:create(...))
		end,
		textures = {
			"arenascenenew",
			"PopShowScoreArenaEnemyArray"
		}
	},
	PopScoreArenaDetailPage = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopScoreArenaDetailPage:create(...))
		end,
		textures = {
			"arenascenenew"
		}
	},
	AdventureNewDetailLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.AdventureNewDetailLayer")

			return (AdventureNewDetailLayer:create(...))
		end,
		textures = {
			"adventurenewlayer",
			"Array"
		}
	},
	ActivitySignLayer_5_1 = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Activity.ActivitySignLayer_5_1")

			return (ActivitySignLayer_5_1:create(...))
		end,
		textures = {
			"Activity_DaKaActivity"
		}
	},
	PopShowArenaInfo = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopShowArenaInfo:create(...))
		end
	},
	PopScultureLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopScultureLayer:create(...))
		end,
		textures = {
			"ScultureLayer"
		}
	},
	PopPostCardLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopPostCardLayer:create(...))
		end,
		textures = {
			"ScultureLayer"
		}
	},
	PopUpgradeCostlayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopUpgradeCostlayer:create(...))
		end
	},
	PopServantUpgradeLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopServantUpgradeLayer:create(...))
		end,
		textures = {
			"PopServantUpgradeLayer",
			"MarketLayer"
		}
	},
	PopServantUpgradeMaterialLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopServantUpgradeMaterialLayer:create(...))
		end,
		textures = {
			"PopServantUpgradeLayer"
		}
	},
	PopServantOCLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopServantOCLayer:create(...))
		end,
		textures = {
			"PopServantUpgradeLayer"
		}
	},
	PopskillDetailLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopskillDetailLayer:create(...))
		end
	},
	PopServantFastUpgradeLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopServantFastUpgradeLayer:create(...))
		end,
		textures = {
			"PopServantUpgradeLayer",
			"MarketLayer",
			"PopServantFastUpgradeLayer"
		}
	},
	ActivitySignBaseLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Activity.ActivitySignBaseLayer")

			return (ActivitySignBaseLayer:create(...))
		end,
		checktextures = function(self)
			if self.activityUIObjName == "ActivitySignFmlLayer" then
				return {
					"ActivitySignFmlLayer"
				}
			end
		end
	},
	PatrolPopLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.PatrolPopLayer")

			return (PatrolPopLayer:create(...))
		end,
		textures = {
			"patrol"
		}
	},
	NextChapterLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.NextChapterLayer")

			return (NextChapterLayer:create(...))
		end,
		textures = {
			"nextChapter"
		}
	},
	PopWeaponUpQuality = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopWeaponUpQuality:create(...))
		end
	},
	PhotoFileLayer = {
		loading = false,
		bg = "mainScenebg/roledatabg.jpg",
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.PhotoFileLayer")

			return (PhotoFileLayer:create(...))
		end
	},
	PhotoFileEntranceLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.PhotoFileEntranceLayer")

			return (PhotoFileEntranceLayer:create(...))
		end
	},
	PopUnlockLabSlotLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopUnlockLabSlotLayer:create(...))
		end,
		textures = {
			"pop_unlock_room"
		}
	},
	PopUnlockDormRoomLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopUnlockDormRoomLayer:create(...))
		end,
		textures = {
			"pop_unlock_room"
		}
	},
	LabLineLayer = {
		bg = "mainScenebg/fightbg30.jpg",
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.LabLineLayer")

			return (LabLineLayer:create(...))
		end,
		textures = {
			"lab_line"
		}
	},
	LabRecipeListLayer = {
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.LabRecipeListLayer")

			return (LabRecipeListLayer:create(...))
		end,
		textures = {
			"lab_recipe_list"
		}
	},
	PopServantBreakout = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopServantBreakout:create(...))
		end,
		textures = {
			"Pop_servant_breakout",
			"PopServantMaxBreakoutLayer"
		}
	},
	PopChaptersPreviewLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return PopChaptersPreviewLayer:create(...)
		end,
		textures = {
			"ChapterPreviewLayer0",
			"ChapterPreviewLayer1"
		}
	},
	PopTalkPreviewLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return PopTalkPreviewLayer:create(...)
		end,
		textures = {
			"ChapterPreviewLayer0",
			"ChapterPreviewLayer1"
		}
	},
	PopActivityPreviewLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return PopActivityPreviewLayer:create(...)
		end,
		textures = {
			"ChapterPreviewLayer0",
			"ChapterPreviewLayer1"
		}
	},
	PopCityUnlockLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return PopCityUnlockLayer:create(...)
		end,
		textures = {
			"ChapterPreviewLayer0",
			"ChapterPreviewLayer1"
		}
	},
	PopExplorePreviewLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return PopExplorePreviewLayer:create(...)
		end,
		textures = {
			"ChapterPreviewLayer0",
			"ChapterPreviewLayer1"
		}
	},
	PopRechargeLayer = {
		hideUI = true,
		statusbarbg = "shopstatusbar",
		bg = "mainScenebg/Recharge_bg.jpg",
		createLayer = function(...)
			require("view.Layer.RechargeLayer")

			return (PopRechargeLayer:create(...))
		end,
		textures = {
			"recharge",
			"MarketLayer"
		}
	},
	PopResearchMake = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopResearchMake:create(...))
		end,
		textures = {
			"lab_mark_room"
		}
	},
	PopPatrolResult = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopPatrolResult:create(...))
		end,
		textures = {
			"fightResultNew"
		}
	},
	MailLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.MailLayer")

			return (MailLayer:create(...))
		end,
		textures = {
			"Mail"
		}
	},
	PopElectricSupplyLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopElectricSupplyLayer:create(...))
		end,
		textures = {
			"ElectricSupplyLayer"
		}
	},
	PopWeaponUpLevelList = {
		bg = "mainScenebg/equip_bg.jpg",
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.Pops.PopWeaponUpLevelList")

			return (PopWeaponUpLevelList:create(...))
		end,
		textures = {
			"PopWeaponUpLevelList"
		}
	},
	PopLabQuickFinish = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopLabQuickFinish:create(...))
		end
	},
	PatrolFightLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.PatrolFightLayer")

			return (PatrolFightLayer:create(...))
		end,
		textures = {
			"patrol_fight"
		}
	},
	PopGainPostcard = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopGainPostcard:create(...))
		end,
		textures = {
			"gain_postcard"
		}
	},
	ServantChangeSkinLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.ServantChangeSkinLayer")

			return (ServantChangeSkinLayer:create(...))
		end,
		textures = {
			"ServantChangeSkinLayer"
		}
	},
	PopEquipAttrLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopEquipAttrLayer:create(...))
		end,
		textures = {
			"equip_layer_servant_info_layer"
		}
	},
	PopEquipSkillLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopEquipSkillLayer:create(...))
		end
	},
	PopFightPowerLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopFightPowerLayer:create(...))
		end
	},
	PopBuffPanel = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopBuffPanel:create(...))
		end,
		textures = {
			"BuffPanel"
		}
	},
	PopGoLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopGoLayer:create(...))
		end
	},
	PopItemLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopItemLayer:create(...))
		end,
		textures = {
			"decompose"
		}
	},
	PopDecomposeItemLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopDecomposeItemLayer:create(...))
		end,
		textures = {
			"decompose"
		}
	},
	PopGoGainLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopGoGainLayer:create(...))
		end
	},
	PopDoLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopDoLayer:create(...))
		end
	},
	PopPurchaseResultLayer = {
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopPurchaseResultLayer:create(...))
		end,
		textures = {
			"PopPurchaseResultLayer"
		}
	},
	PopGoodsLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopGoodsLayer:create(...))
		end
	},
	PopGiftBagLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopGiftBagLayer:create(...))
		end
	},
	PopGoBuyDiamond = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopGoBuyDiamond:create(...))
		end
	},
	PopGoBuyGiftTicketLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopGoBuyGiftTicketLayer:create(...))
		end
	},
	PopComponentLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopComponentLayer:create(...))
		end
	},
	PopDropPreviewLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopDropPreviewLayer:create(...))
		end
	},
	PublicityLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.PublicityLayer")

			return (PublicityLayer:create(...))
		end,
		textures = {
			"Probability_Publicity"
		}
	},
	PopServantMaxBreakoutLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopServantMaxBreakoutLayer:create(...))
		end,
		textures = {
			"PopServantMaxBreakoutLayer"
		}
	},
	SoulServantInfo = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.SoulServantInfo")

			return (SoulServantInfo:create(...))
		end,
		textures = {
			"soul_servant_info"
		}
	},
	PopShowGirl = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopShowGirl:create(...))
		end
	},
	PopUnlockTrainRoomLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopUnlockTrainRoomLayer:create(...))
		end
	},
	PopTrainPackageLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopTrainPackageLayer:create(...))
		end
	},
	PopLevelUpLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.PopLevelUpLayer")

			return (PopLevelUpLayer:create(...))
		end
	},
	PopRoomQuickFinishLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopRoomQuickFinishLayer:create(...))
		end,
		textures = {
			"pop_unlock_room"
		}
	},
	PopActivityDetail = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopActivityDetail:create(...))
		end,
		textures = {
			"PopActivityDetail",
			"BaseFormationLayer",
			"BondLayer",
			"Array"
		}
	},
	PopContractAttrDetailLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopContractAttrDetailLayer:create(...))
		end,
		textures = {
			"PopActivityDetail"
		}
	},
	PopRecruitTasksLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopRecruitTasksLayer")

			return (PopRecruitTasksLayer:create(...))
		end,
		textures = {
			"PopRecruitTasksLayer"
		}
	},
	PopBachelorWelfareLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopBachelorWelfareLayer:create(...))
		end,
		textures = {
			"PopBachelorWelfareLayer"
		}
	},
	PopRodInfoLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopRodInfoLayer:create(...))
		end,
		textures = {
			"PopRodInfoLayer"
		}
	},
	LevelRankListLayer = {
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.LevelRankListLayer")

			return (LevelRankListLayer:create(...))
		end,
		textures = {
			"arenascenenew"
		}
	},
	PopMemorycardLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopMemorycardLayer:create(...))
		end,
		textures = {
			"Activity_bianhua0"
		}
	},
	PopPasswordLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopPasswordLayer:create(...))
		end,
		textures = {
			"Activity_bianhua0"
		}
	},
	PopNinifaRecordLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopNinifaRecordLayer:create(...))
		end,
		textures = {
			"ActivityNinifaCompositeLayer"
		}
	},
	PopNinifaIllustrateLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopNinifaIllustrateLayer:create(...))
		end,
		textures = {
			"ActivityNinifaCompositeLayer"
		}
	},
	PopDroadcastLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopDroadcastLayer:create(...))
		end
	},
	PopNodeOperationLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopNodeOperationLayer:create(...))
		end
	},
	PopTechnologyTree = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopTechnologyTree:create(...))
		end,
		textures = {
			"PopTechnologyTree",
			"Activity_doubleholiday"
		}
	},
	PopUseBarrageGiftLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopUseBarrageGiftLayer:create(...))
		end,
		textures = {
			"PopUseBarrageGiftLayer"
		}
	},
	PopBattlePassTaskLayer = {
		hideUI = true,
		statusbarbg = "taskstatusbar",
		bg = TASK_BG,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopBattlePassTaskLayer:create(...))
		end,
		textures = {
			"TaskLayer"
		}
	},
	ActivityNianShou = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Activity.ActivitySpringFestival.ActivityNianShou")

			return (ActivityNianShou:create(...))
		end,
		textures = {
			"Activity_Spring_Festival_Activity_nianshou"
		}
	},
	SpringRankListLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.RankListBaseLayer")

			return (SpringRankListLayer:create(...))
		end,
		textures = {
			"arenascenenew"
		}
	},
	SpringTaskListLayer = {
		statusbarbg = "taskstatusbar",
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (SpringTaskListLayer:create(...))
		end,
		textures = {
			"Activity_Spring_Festival_BattlePassSpring"
		}
	},
	PopActivityShareLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopActivityShareLayer:create(...))
		end,
		textures = {
			"Activity_Spring_Festival_Share"
		}
	},
	PopStarRewardLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopStarRewardLayer:create(...))
		end,
		textures = {
			"PopStarRewardLayer"
		}
	},
	ActivityJpCbSignLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (ActivityJpCbSignLayer:create(...))
		end,
		textures = {
			"ActivityJpCbSignLayer"
		}
	},
	PopNoviceAwardLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopNoviceAwardLayer:create(...))
		end,
		textures = {
			"PopNoviceAwardLayer"
		}
	},
	PopComponentStrengthenLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopComponentStrengthenLayer:create(...))
		end,
		textures = {
			"pop_component_strengthen_layer"
		}
	},
	PopAdjustSuccessLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopAdjustSuccessLayer:create(...))
		end,
		textures = {
			"pop_component_strengthen_layer"
		}
	},
	PopSkinPackage = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopSkinPackage:create(...))
		end,
		textures = {}
	},
	PopGMLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopGMLayer:create(...))
		end,
		textures = {}
	},
	PopActivityLayerGirlsDay = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopActivityLayerGirlsDay:create(...))
		end,
		textures = {
			"ActivityLayer_GirlsDay"
		}
	},
	MarryPopLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.MarryPopLayer")

			return (MarryPopLayer:create(...))
		end,
		textures = {
			"marry"
		}
	},
	MarryTalkLayer = {
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.MarryTalkLayer")

			return (MarryTalkLayer:create(...))
		end
	},
	PopAnswerQuestionLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopAnswerQuestionLayer:create(...))
		end,
		textures = {
			"PopAnswerQuestionLayer"
		}
	},
	PatrolGirlSelectLayer = {
		hideUI = true,
		bg = TASK_BG,
		createLayer = function(...)
			require("view.Layer.PatrolGirlSelectLayer")

			return (PatrolGirlSelectLayer:create(...))
		end,
		textures = {
			"GirlSelectLayer"
		}
	},
	PopHorcruxUpstarLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopHorcruxUpstarLayer:create(...))
		end,
		textures = {}
	},
	PopBuyRechargeLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopBuyRechargeLayer:create(...))
		end,
		textures = {
			"PopBuyRechargeLayer",
			"recharge",
			"MarketLayer"
		}
	},
	PopskillDetailLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopskillDetailLayer:create(...))
		end
	},
	PopGetBianhuaBpVIPLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopGetBianhuaBpVIPLayer:create(...))
		end,
		textures = {
			"ActivityBianhuaBP"
		}
	},
	PopGetWarOrdrBpVIPLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopGetWarOrdrBpVIPLayer:create(...))
		end,
		textures = {
			"ActivityBianhuaBP",
			"PopGetWarOrdrBpVIPLayer"
		}
	},
	PopWarOrderBuyLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopWarOrderBuyLayer:create(...))
		end,
		textures = {
			"ActivityBianhuaBP"
		}
	},
	PopReturnBuffLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopReturnBuffLayer:create(...))
		end,
		textures = {
			"activity_return",
			"activity_return"
		}
	},
	SubstitutionArrayLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.BattleArrayLayerNew")
			print("::::::::::")

			return (SubstitutionArrayLayer:create(...))
		end,
		textures = {
			"Array"
		}
	},
	SubRankListLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.RankListBaseLayer")

			return (SubRankListLayer:create(...))
		end,
		textures = {
			"arenascenenew"
		}
	},
	PopActivityReturnSignLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopActivityReturnSignLayer:create(...))
		end,
		textures = {
			"activity_return"
		}
	},
	PopActivityReturnMailLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopActivityReturnMailLayer:create(...))
		end,
		textures = {
			"activity_return"
		}
	},
	PopAutoArrayLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopAutoArrayLayer:create(...))
		end,
		textures = {
			"PopAutoArrayLayer"
		}
	},
	PopCardDesLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopCardDesLayer:create(...))
		end
	},
	PopSubScoreUpLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopSubScoreUpLayer:create(...))
		end,
		textures = {
			"SubstitutionLayer"
		}
	},
	SubstitutionArrayLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.BattleArrayLayerNew")
			print("::::::::::")

			return (SubstitutionArrayLayer:create(...))
		end,
		textures = {
			"Array"
		}
	},
	PopGetBattlepassVIPLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopGetBattlepassVIPLayer:create(...))
		end,
		textures = {
			"ActivityBianhuaBP"
		}
	},
	PopGetBianhuaBpVIPLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopGetBianhuaBpVIPLayer:create(...))
		end,
		textures = {
			"ActivityBianhuaBP"
		}
	},
	PopBattlePassBuyLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopBattlePassBuyLayer:create(...))
		end,
		textures = {
			"ActivityBianhuaBP"
		}
	},
	PopBpPreviewGiftLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopBpPreviewGiftLayer:create(...))
		end,
		textures = {
			"ActivityBianhuaBP",
			"MarketLayer"
		}
	},
	PopBpFastUpgradeLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopBpFastUpgradeLayer:create(...))
		end,
		textures = {
			"ActivityBianhuaBP"
		}
	},
	PopBpFastUpgradeLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopBpFastUpgradeLayer:create(...))
		end,
		textures = {
			"ActivityBianhuaBP"
		}
	},
	PopTransOverdueItemLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopTransOverdueItemLayer:create(...))
		end
	},
	PopDiamondNumLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopDiamondNumLayer:create(...))
		end
	},
	PopShopCurrencySelectLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopShopCurrencySelectLayer:create(...))
		end
	},
	PopPatrolQuickFinishLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopPatrolQuickFinishLayer:create(...))
		end,
		textures = {
			"pop_unlock_room",
			"room_widget"
		}
	},
	PopNovicePasslevelAwardLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopNovicePasslevelAwardLayer:create(...))
		end,
		textures = {
			"PopNovicePasslevelAwardLayer"
		}
	},
	PopShopTimeLimitLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopShopTimeLimitLayer:create(...))
		end,
		textures = {
			"pop_shop_timelimit_layer",
			"PopNoviceAwardLayer"
		}
	},
	PopFriendIntroduceLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopFriendIntroduceLayerNew:create(...))
		end,
		textures = {
			"friendsystem",
			"arenascenenew",
			"ArenaScene",
			"Array",
			"postcard"
		}
	},
	PopFriendManagementLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopFriendManagementLayer:create(...))
		end,
		textures = {
			"friendsystem",
			"arenascenenew",
			"ArenaScene"
		}
	},
	PopHorcruxUpstarLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopHorcruxUpstarLayer:create(...))
		end,
		textures = {}
	},
	PopBuyRechargeLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopBuyRechargeLayer:create(...))
		end,
		textures = {
			"PopBuyRechargeLayer",
			"recharge",
			"MarketLayer"
		}
	},
	PopVisualAdventureChapter = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopVisualAdventureChapter:create(...))
		end,
		textures = {
			"adventure_score"
		}
	},
	PopTvtRecordLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopTvtRecordLayer:create(...))
		end,
		textures = {
			"PopTvtRecordLayer",
			"TvtLevet"
		}
	},
	PopTvtMatchLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopTvtMatchLayer:create(...))
		end,
		textures = {
			"ThreeVsThreeLayer",
			"TvtLevet"
		}
	},
	BattleTvtArrayLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.BattleArrayLayerNew")

			return (BattleTvtArrayLayer:create(...))
		end,
		textures = {
			"Array",
			"PopTvtRecordLayer"
		}
	},
	PopTvtResultLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopTvtResultLayer:create(...))
		end,
		textures = {
			"PopTvtRecordLayer",
			"TvtLevet"
		}
	},
	PopGetBattlepassVIPLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopGetBattlepassVIPLayer:create(...))
		end,
		textures = {
			"ActivitySaveBPLayer"
		}
	},
	PopBattlePassBuyLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopBattlePassBuyLayer:create(...))
		end,
		textures = {
			"ActivityBianhuaBP"
		}
	},
	MarryPopLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.MarryPopLayer")

			return (MarryPopLayer:create(...))
		end,
		textures = {
			"marry"
		}
	},
	MarryTalkLayer = {
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.MarryTalkLayer")

			return (MarryTalkLayer:create(...))
		end
	},
	PopTransOverdueItemLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopTransOverdueItemLayer:create(...))
		end
	},
	MajorRankListLayer = {
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.RankListBaseLayer")

			return (MajorRankListLayer:create(...))
		end,
		textures = {
			"arenascenenew",
			"Activity_Valentine_Day"
		}
	},
	PopShopTimeLimitNewLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopShopTimeLimitNewLayer:create(...))
		end,
		textures = {
			"pop_shop_timelimit_layer",
			"PopNoviceAwardLayer"
		}
	},
	ActivityRechargeTemplate = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityRechargeTemplate")

			return (ActivityRechargeTemplate:create(...))
		end,
		textures = {
			"Activity_recharge",
			"recharge",
			"MarketLayer"
		}
	},
	PopFlopBuyLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopFlopBuyLayer:create(...))
		end,
		textures = {
			"ActivityPreSummer"
		}
	},
	PopPTBuyLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopPTBuyLayer:create(...))
		end,
		textures = {
			"ActivityBianhuaBP"
		}
	},
	PopSwimVoteLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopSwimVoteLayer:create(...))
		end,
		textures = {
			"SwimMainLayer"
		}
	},
	PopSwimTeamInfoLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopSwimTeamInfoLayer:create())
		end,
		textures = {
			"SwimMainLayer"
		}
	},
	PopSwimResultLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopSwimResultLayer:create(...))
		end,
		textures = {
			"SwimMainLayer"
		}
	},
	PopSwimWeekResultLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopSwimWeekResultLayer:create(...))
		end,
		textures = {
			"SwimMainLayer"
		}
	},
	PopSwimRecordLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopSwimRecordLayer:create(...))
		end
	},
	PopShowGilrPreviewLayer = {
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.PopShowGilrPreviewLayer")

			return (PopShowGilrPreviewLayer:create(...))
		end,
		textures = {
			"MarketLayer"
		}
	},
	PopShopTimeLimitLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopShopTimeLimitLayer:create(...))
		end,
		textures = {
			"pop_shop_timelimit_layer",
			"PopNoviceAwardLayer"
		}
	},
	PopShopTimeLimitNewLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopShopTimeLimitNewLayer:create(...))
		end
	},
	ActivityRechargeTemplate = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Activity.ActivityRechargeTemplate")

			return (ActivityRechargeTemplate:create(...))
		end,
		textures = {
			"Activity_recharge",
			"recharge",
			"MarketLayer"
		}
	},
	PopShowGilrPreviewLayer = {
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.Pops.PopShowGilrPreviewLayer")

			return (PopShowGilrPreviewLayer:create(...))
		end,
		textures = {
			"MarketLayer"
		}
	},
	ActivityPopBaseLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (ActivityPopBaseLayer:create(...))
		end
	},
	ActivityWakefundBaseLayer = {
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityWakefundBaseLayer")

			return (ActivityWakefundBaseLayer:create(...))
		end
	},
	ActivityWakefundVipBuyPopLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (ActivityWakefundVipBuyPopLayer:create(...))
		end
	},
	PopShowGirlPageLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopShowGirlPageLayer:create(...))
		end
	},
	PopBirthdayPartyLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopBirthdayPartyLayer:create(...))
		end,
		textures = {
			"PopBirthdayPartyLayer"
		}
	},
	PopPushOpenLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopPushOpenLayer:create(...))
		end,
		textures = {
			"PopPushOpenLayer"
		}
	},
	PopRouletteBuyLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopRouletteBuyLayer:create(...))
		end
	},
	PopPTBuyLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopPTBuyLayer:create(...))
		end,
		textures = {
			"ActivityBianhuaBP"
		}
	},
	BirthPopBaseLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (BirthPopBaseLayer:create(...))
		end
	},
	ActivityJpCbSignLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (ActivityJpCbSignLayer:create(...))
		end,
		textures = {
			"ActivityJpCbSignLayer"
		}
	},
	PopNoviceAwardLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopNoviceAwardLayer:create(...))
		end,
		textures = {
			"PopNoviceAwardLayer",
			"ActivityFlopDuanwu"
		}
	},
	PopComponentStrengthenLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopComponentStrengthenLayer:create(...))
		end,
		textures = {
			"pop_component_strengthen_layer"
		}
	},
	PopCardBuffLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopCardBuffLayer:create(...))
		end,
		textures = {
			"activity_return"
		}
	},
	PopFlopBuyLayer_138 = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopFlopBuyLayer_138:create(...))
		end,
		textures = {
			"ActivityMoonFestival"
		}
	},
	ActivityArtRankListLayer = {
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.RankListBaseLayer")

			return (ActivityArtRankListLayer:create(...))
		end,
		textures = {
			"arenascenenew",
			"Activity_Valentine_Day"
		}
	},
	OldSubRankListLayer = {
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.RankListBaseLayer")

			return (OldSubRankListLayer:create(...))
		end,
		textures = {
			"arenascenenew"
		}
	},
	MonopolyRankListLayer = {
		hideUI = true,
		createLayer = function(...)
			return (require("view.Layer.MonopolyRankListLayer"):create(...))
		end,
		textures = {
			"arenascenenew",
			"Activity_Valentine_Day"
		}
	},
	FlyChessRankListLayer = {
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.RankListBaseLayer")

			return (FlyChessRankListLayer:create(...))
		end,
		textures = {
			"arenascenenew"
		}
	},
	HexagonRankListLayer = {
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.RankListBaseLayer")

			return (HexagonRankListLayer:create(...))
		end,
		textures = {
			"arenascenenew"
		}
	},
	WorldBossRankListLayer = {
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.RankListBaseLayer")

			return (WorldBossRankListLayer:create(...))
		end,
		textures = {
			"arenascenenew"
		}
	},
	PopAdventureInfiniteUpLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopAdventureInfiniteUpLayer:create(...))
		end,
		textures = {
			"adventure_infinite"
		}
	},
	PopCommunityIntroduceLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopCommunityIntroduceLayer:create(...))
		end,
		textures = {
			"community_system_communityMainLayer0",
			"community_system_communityMainLayer1",
			"community_system_joinCommunityLayer0"
		}
	},
	PopCommunityMedalChangeLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopCommunityMedalChangeLayer:create(...))
		end,
		textures = {
			"community_system_communityMainLayer0",
			"community_system_communityMainLayer1",
			"community_system_joinCommunityLayer0"
		}
	},
	PopCommunitySettingLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopCommunitySettingLayer:create(...))
		end,
		textures = {
			"community_system_communityMainLayer0",
			"community_system_communityMainLayer1",
			"community_system_joinCommunityLayer0"
		}
	},
	PopCommunityApplyingLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopCommunityApplyingLayer:create(...))
		end,
		textures = {
			"community_system_communityMainLayer0",
			"community_system_communityMainLayer1",
			"community_system_joinCommunityLayer0"
		}
	},
	PopCommunityVlogLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopCommunityVlogLayer:create(...))
		end,
		textures = {
			"community_system_communityMainLayer0",
			"community_system_communityMainLayer1",
			"community_system_joinCommunityLayer0"
		}
	},
	PopCommunityDonationLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopCommunityDonationLayer:create(...))
		end,
		textures = {
			"community_system_communityMainLayer0",
			"community_system_communityMainLayer1",
			"community_system_joinCommunityLayer0"
		}
	},
	PopCommunityPlayerApplyLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopCommunityPlayerApplyLayer:create(...))
		end,
		textures = {
			"community_system_communityMainLayer0",
			"community_system_communityMainLayer1",
			"community_system_joinCommunityLayer0"
		}
	},
	PopCommunityNoticesLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopCommunityNoticesLayer:create(...))
		end,
		textures = {
			"community_system_communityMainLayer0",
			"community_system_communityMainLayer1",
			"community_system_joinCommunityLayer0"
		}
	},
	PopCommunityFilterLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopCommunityFilterLayer:create(...))
		end,
		textures = {
			"community_system_communityMainLayer0",
			"community_system_communityMainLayer1",
			"community_system_joinCommunityLayer0"
		}
	},
	PopChatInterfaceLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopChatInterfaceLayer:create(...))
		end,
		textures = {
			"chat_system_layer"
		}
	},
	PopCommunityBulidingLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopCommunityBulidingLayer:create(...))
		end,
		textures = {
			"community_system_communityMainLayer0",
			"community_system_communityMainLayer1",
			"community_system_joinCommunityLayer0"
		}
	},
	PopCommunityChartReportLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopCommunityChartReportLayer:create(...))
		end,
		textures = {
			"community_system_communityMainLayer0",
			"community_system_communityMainLayer1",
			"community_system_joinCommunityLayer0"
		}
	},
	InviteLayer = {
		hideUI = true,
		bg = SETTINGBG,
		createLayer = function(...)
			require("view.Layer.InviteLayer")

			return (InviteLayer:create())
		end,
		textures = {
			"InviteLayer"
		}
	},
	PopBuyChatEmotationGiftLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopBuyChatEmotationGiftLayer:create(...))
		end,
		textures = {
			"PopBuyChatEmotationGiftLayer"
		}
	},
	PopCommunityWishManageLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopCommunityWishManageLayer:create(...))
		end,
		textures = {
			"community_system_communityMainLayer0",
			"community_system_communityMainLayer1",
			"community_system_joinCommunityLayer0"
		}
	},
	PopCommunityWishLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopCommunityWishLayer:create(...))
		end,
		textures = {
			"community_system_communityMainLayer0",
			"community_system_communityMainLayer1",
			"community_system_joinCommunityLayer0"
		}
	},
	PopCommunityWishFilterLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopCommunityWishFilterLayer:create(...))
		end,
		textures = {
			"community_system_communityMainLayer0",
			"community_system_communityMainLayer1",
			"community_system_joinCommunityLayer0"
		}
	},
	BondLayer = {
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.BondLayer")

			return (BondLayer:create(...))
		end,
		textures = {
			"BondLayer"
		}
	},
	PopTurnOverItemsLayer = {
		createLayer = function(...)
			require("view.Layer.Pops.PopTurnOverItemsLayer")

			return (PopTurnOverItemsLayer:create(...))
		end,
		textures = {
			"PopTurnOverItemsLayer"
		}
	},
	ShowFrinendArrayLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.BattleArrayLayerNew")

			return (ShowFrinendArrayLayer:create(...))
		end,
		textures = {
			"Array"
		}
	},
	PopBuyPackageDirectLayer_186 = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopBuyPackageDirectLayer_186:create(...))
		end,
		textures = {}
	},
	PopMedalSelectLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopMedalSelectLayer:create(...))
		end,
		textures = {
			"medalSelect"
		}
	},
	PopGameCompoundLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopGameCompoundLayer:create(...))
		end,
		textures = {
			"gamecompound"
		}
	},
	DormitoryFixturesLayer = {
		hideUI = true,
		createLayer = function(...)
			return (require("view.Layer.DormitoryFixturesLayer"):create(...))
		end,
		textures = {
			"DormitoryFixturesLayer",
			"Dormitory",
			"itempanel",
			"MarketLayer"
		}
	},
	PopSkinAccessLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopSkinAccessLayer:create(...))
		end,
		checktextures = function(self)
			return self.activityId and {
				"PopSkinAccessLayer_" .. self.activityId
			} or {}
		end
	},
	PopActivitySurveyLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopActivitySurveyLayer:create(...))
		end,
		textures = {
			"PopActivitySurveyLayer"
		}
	},
	PopSkinGetLayer_286 = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopSkinGetLayer_286:create(...))
		end,
		textures = {
			"PopSkinGetLayer_286"
		}
	},
	PopTapVoteLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopTapVoteLayer:create(...))
		end,
		textures = {
			"PopTapVoteLayer"
		}
	},
	PopDailyRechargeLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopDailyRechargeLayer:create(...))
		end,
		textures = {
			"PopDailyRechargeLayer"
		},
		checktextures = function(self)
			return self.activityId and {
				"PopDailyRechargeLayer_" .. self.activityId
			} or {}
		end
	},
	PopReturnBackGuideTaskLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopReturnBackGuideTaskLayer:create(...))
		end,
		textures = {
			"gameback0",
			"gameback1"
		}
	},
	PopBestTeammatesLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopBestTeammatesLayer:create(...))
		end,
		textures = {
			"servantrank"
		}
	},
	PopCourseLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopCourseLayer:create(...))
		end,
		textures = {
			"gamecourse0",
			"gamecourse1"
		}
	},
	PopMsgLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopMsgLayer:create(...))
		end,
		textures = {
			"gamecourse0",
			"gamecourse1"
		}
	},
	PopPatrolOneKeyLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopPatrolOneKeyLayer:create(...))
		end,
		textures = {
			"patrol_fight"
		}
	},
	PopInviteResidentLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopInviteResidentLayer:create(...))
		end,
		textures = {
			"InviteResident"
		}
	},
	PopArtTaskLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopArtTaskLayer:create(...))
		end
	},
	PopSummerTSTaskLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopSummerTSTaskLayer:create(...))
		end,
		textures = {
			"ActivityArt_722"
		}
	},
	PopCommonTaskLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopCommonTaskLayer:create(...))
		end
	},
	flychessTaskLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (flychessTaskLayer:create(...))
		end
	},
	PopRouletteTaskLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopRouletteTaskLayer:create(...))
		end
	},
	PopActivityGameTaskLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopActivityGameTaskLayer:create(...))
		end
	},
	PopInviteDetailLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopInviteDetailLayer:create(...))
		end,
		textures = {
			"InviteResident"
		}
	},
	PopTowerSkillSelectLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopTowerSkillSelectLayer:create(...))
		end,
		textures = {
			"ExpeditionLayer"
		}
	},
	FormationPointsMatchLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.Formation.FormationPointsMatchLayer"):create(...))
		end,
		textures = {
			"BaseFormationLayer"
		}
	},
	FormationOverclockLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.Formation.FormationOverclockLayer"):create(...))
		end,
		textures = {
			"BaseFormationLayer"
		}
	},
	FormationGrabMatchLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.Formation.FormationGrabMatchLayer"):create(...))
		end,
		textures = {
			"BaseFormationLayer"
		}
	},
	FormationModeLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.Formation.FormationModeLayer"):create(...))
		end,
		textures = {
			"BaseFormationLayer"
		}
	},
	FormationMaterialLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.Formation.FormationMaterialLayer"):create(...))
		end,
		textures = {
			"BaseFormationLayer"
		}
	},
	FormationElementsLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.Formation.FormationElementsLayer"):create(...))
		end,
		textures = {
			"BaseFormationLayer"
		}
	},
	FormationJumptowerLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.Formation.FormationJumptowerLayer"):create(...))
		end,
		textures = {
			"BaseFormationLayer"
		}
	},
	FormationGroupFightLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.Formation.FormationGroupFightLayer"):create(...))
		end,
		textures = {
			"BaseFormationLayer"
		}
	},
	FormationBossfightLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.Formation.FormationBossfightLayer"):create(...))
		end,
		textures = {
			"BaseFormationLayer"
		}
	},
	FormationExploreLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.Formation.FormationExploreLayer"):create(...))
		end,
		textures = {
			"BaseFormationLayer"
		}
	},
	FormationSpecialExploreLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.Formation.FormationSpecialExploreLayer"):create(...))
		end,
		textures = {
			"BaseFormationLayer"
		}
	},
	FormationFriendFightLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.Formation.FormationFriendFightLayer"):create(...))
		end,
		textures = {
			"BaseFormationLayer"
		}
	},
	FormationMainLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.Formation.FormationMainLayer"):create(...))
		end,
		textures = {
			"BaseFormationLayer",
			"HelpBattleLayer"
		}
	},
	Formation3V3Layer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.Formation.Formation3V3Layer"):create(...))
		end,
		textures = {
			"BaseFormationLayer",
			"Formation3V3Layer"
		}
	},
	Formation3V3SettingLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.Formation.Formation3V3SettingLayer"):create(...))
		end,
		textures = {
			"BaseFormationLayer"
		}
	},
	FormationTestFightLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.Formation.FormationTestFightLayer"):create(...))
		end,
		textures = {
			"BaseFormationLayer"
		}
	},
	FormationOldSubstituteLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.Formation.FormationOldSubstituteLayer"):create(...))
		end,
		textures = {
			"BaseFormationLayer"
		}
	},
	PopLimitTimePackageLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopLimitTimePackageLayer:create(...))
		end,
		textures = {
			"newcomerpackages"
		}
	},
	RecollectionsLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.Recollections.RecollectionsLayer"):create(...))
		end,
		textures = {
			"RecollectionsLayer"
		}
	},
	RecollectionsSweepstakeLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.Recollections.RecollectionsSweepstakeLayer"):create(...))
		end,
		textures = {
			"RecollectionsSweepstakeLayer"
		}
	},
	ThreeVsThreeHistoryLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.ThreeVsThreeHistoryLayer"):create(...))
		end,
		textures = {
			"ThreeVsThreeHistoryLayer"
		}
	},
	PopSpringInfoLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopSpringInfoLayer:create(...))
		end,
		textures = {
			"PopSpringInfoLayer"
		}
	},
	PrivilegeSuccessTipsLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.PrivilegeSuccessTipsLayer"):create(...))
		end,
		textures = {
			"PrivilegeSuccessTipsLayer"
		}
	},
	ShowRoleOverClockLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.ShowRoleOverClockLayer"):create(...))
		end,
		textures = {
			"ShowRoleOverClockLayer",
			"MarketLayer"
		}
	},
	PrivilegeFailedTipsLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.PrivilegeFailedTipsLayer"):create(...))
		end,
		textures = {
			"PrivilegeFailedTipsLayer"
		}
	},
	PopActivityBpSignLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopActivityBpSignLayer:create(...))
		end,
		checktextures = function(self)
			return self.activityId and {
				"ActivityBpSign_" .. self.activityId
			} or {}
		end
	},
	NewbeeTwistReturnLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")
			require("view.Layer.NewbeeTwistReturnLayer")

			return (NewbeeTwistReturnLayer:create(...))
		end,
		textures = {
			"NewbeeTwistReturnLayer"
		}
	},
	ManageMoneyLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")
			require("view.Layer.ManageMoneyLayer")

			return (ManageMoneyLayer:create(...))
		end,
		textures = {
			"ManageMoneyLayer"
		}
	},
	QuickFormationLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.QuickFormationLayer"):create(...))
		end,
		textures = {
			"QuickFormationLayer",
			"HorcruxSelectLayer"
		}
	},
	HelpBattleLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.HelpBattle.HelpBattleLayer"):create(...))
		end,
		textures = {
			"HelpBattleLayer"
		}
	},
	PopCreateNewAccountLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopCreateNewAccountLayer:create(...))
		end,
		textures = {
			"PopCreateNewAccountLayer"
		}
	},
	BagLayerNew = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.BagLayerNew")

			return (BagLayerNew:create(...))
		end,
		textures = {
			"BagLayer",
			"HorcruxLayer",
			"ItemsPanelPartsLayer",
			"HorcruxSelectLayer"
		}
	}
}
